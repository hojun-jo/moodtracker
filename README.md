# Mood Tracker
간단한 아이콘과 짧은 글로 기록할 수 있는 감성적인 일기 앱.

**주요 기능**

인증
  - Firebase Authentication을 이용한 이메일 로그인/회원가입

일기
  - 아이콘으로 감정 표현
  - 일기 작성/삭제
  - Firestore를 이용한 실시간 데이터 동기화

테마
  - 커스텀 테마

## Screenshot

| Sign In Screen | Sign Up Screen | Home Screen |
| :-: | :-: | :-: |
| <img src="https://github.com/user-attachments/assets/2b8dd956-348a-4cb6-917f-849fce982ea4" height=400 /> | <img src="https://github.com/user-attachments/assets/6f3e1f27-c321-4d55-aa56-acdbf49e88df" height=400 /> | <img src="https://github.com/user-attachments/assets/9334b08b-af14-4ca0-985e-c2384a7cf51a" height=400 /> |

| Write Screen | Settings Screen | License Page |
| :-: | :-: | :-: |
| <img src="https://github.com/user-attachments/assets/dea82adb-bfac-460c-864b-887b984f882a" height=400 /> | <img src="https://github.com/user-attachments/assets/1757253f-fdf0-478e-829b-aa85cb6c1ef2" height=400 /> | <img src="https://github.com/user-attachments/assets/e7b26d4a-2ace-407a-ae0c-fe9131545cc5" height=400 /> |

## Structure
<img src="https://github.com/user-attachments/assets/c4c357bf-99f9-454c-8ca4-b7bd3ab08134" />

## Detail

### Firestore
- Firestore에서 유저 문서 하위에 일기 컬렉션을 저장하는 구조 설계.
- 유저마다 컬렉션 하나만 있으면 되고, Firestore의 경우 상위 문서의 크기는 변하지 않기 때문에 성능 문제도 없을 것이라 판단.

```
{
    "users": [
        {
            "moods": [
                {
                    "createdAt",
                    "description",
                    "id",
                    "moodType",
                    "uid",
                },
            ]
            "email",
            "name",
            "uid",
        },
    ]
}
```

### Theme
- 전역 함수로 `ThemeData` 제공.
- `SharedPreferencesAsync`를 사용하여 테마 저장- 
  - `SharedPreferences`는 deprecated 예정이기 때문.
  - `String`으로 저장한 테마 데이터 변환을 위해 `AppThemeType`에 `fromString` 생성자 제공.
- `AsyncNotifierProvider`로 App에 테마를 제공하여 앱 전역에서 테마 일관성 유지.

```dart
ThemeData appThemeData(AppThemeType appBackground) {
  return ThemeData(
    ...
}

enum AppThemeType {
  cherryBlossom("cherryBlossom"),
  apricot("apricot"),
  almond("almond"),
  ashGray("ashGray"),
  thistle("thistle");

  final String text;

  const AppThemeType(this.text);

  factory AppThemeType.fromString(String text) {
    return values.firstWhere((e) => e.text == text);
  }
...
}

class ThemeRepository {
  final SharedPreferencesAsync _asyncPref = SharedPreferencesAsync();

  Future<void> setTheme(String theme) async {
    await _asyncPref.setString("theme", theme);
  }
...
}

class ThemeNotifier extends AutoDisposeAsyncNotifier<AppThemeType> {
  ...
}

final themeProvider =
    AsyncNotifierProvider.autoDispose<ThemeNotifier, AppThemeType>(
  () => ThemeNotifier(),
);

class MoodTrackerApp extends ConsumerWidget {
  const MoodTrackerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    ...
  }
}
```

### UX
- 유저가 일기 작성 중 다른 탭으로 이동 후에도 내용 유지.
  - 각 탭의 상태를 유지하기 위해 StatefulShellRoute 사용.

```dart
final routerProvider = Provider((ref) {
  return GoRouter(
    ...
    routes: [
      ...
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MainNavigationBar(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePath.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePath.write,
                builder: (context, state) => const WriteScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePath.settings,
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});

```