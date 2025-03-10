# Mood Tracker

## Screenshot

| SignInScreen | SignUpScreen | HomeScreen |
| :-: | :-: | :-: |
| <img src="https://github.com/user-attachments/assets/2b8dd956-348a-4cb6-917f-849fce982ea4" height=400 /> | <img src="https://github.com/user-attachments/assets/6f3e1f27-c321-4d55-aa56-acdbf49e88df" height=400 /> | <img src="https://github.com/user-attachments/assets/9334b08b-af14-4ca0-985e-c2384a7cf51a" height=400 /> |

| WriteScreen | SettingsScreen | License Page |
| :-: | :-: | :-: |
| <img src="https://github.com/user-attachments/assets/dea82adb-bfac-460c-864b-887b984f882a" height=400 /> | <img src="https://github.com/user-attachments/assets/1757253f-fdf0-478e-829b-aa85cb6c1ef2" height=400 /> | <img src="https://github.com/user-attachments/assets/e7b26d4a-2ace-407a-ae0c-fe9131545cc5" height=400 /> |

## Structure
<img src="https://github.com/user-attachments/assets/c4c357bf-99f9-454c-8ca4-b7bd3ab08134" />

## Detail

### Firestore
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
- user 당 moods 컬렉션 하나만 있으면 되고 상위 문서의 크기는 그대로이기 때문에 이러한 구조 채택.


### Home Screen
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
- Stream으로 데이터 제공.
- ViewModel의 역할이 화면에 보여줄 데이터를 가공하는 것이기 때문에 HomeViewModel의 build에서 가공.


### Theme

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
```
- 함수로 ThemeData 제공.
- SharedPreferences에 String으로 저장한 테마 데이터 변환을 위해 AppThemeType에 fromString 생성자 제공.