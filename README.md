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


### Router
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


### Home Screen
- HomeViewModel을 AutoDisposeStreamNotifier로 만들어 Stream으로 데이터 제공.
- ViewModel의 역할이 화면에 보여줄 데이터를 가공하는 것이기 때문에 HomeViewModel의 build에서 가공.

```dart
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final moodModelStream = ref.watch(homeProvider);
    final viewModel = ref.read(homeProvider.notifier);

    return moodModelStream.when(
      data: (data) {
        ...
    );
  }
}

class HomeViewModel extends AutoDisposeStreamNotifier<List<MoodModel>> {
  late final MoodRepository _repository;

  @override
  Stream<List<MoodModel>> build() {
    _repository = ref.read(moodRepo);
    final user = ref.read(authRepo).user!;

    return _repository.fetchMoods(user.uid).map((snapshot) {
      List<MoodModel> models = [];

      for (final doc in snapshot.docs) {
        final json = doc.data();
        final model = MoodModel.fromJson(json);

        models.add(model);
      }

      return models;
    });
  }
...
}

class MoodRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchMoods(String uid) {
    return _db
        .collection("users")
        .doc(uid)
        .collection("moods")
        .orderBy("createdAt", descending: true)
        .snapshots();
  }
...
}
```


### Theme
- 전역 함수로 ThemeData 제공.
- SharedPreferencesAsync를 사용하여 테마 저장
  - String으로 저장한 테마 데이터 변환을 위해 AppThemeType에 fromString 생성자 제공.

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
```