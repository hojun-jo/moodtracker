class UserModel {
  final String uid;

  UserModel({required this.uid});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel(uid: json['uid']);

  Map<String, dynamic> toJson() => {'uid': uid};

  @override
  int get hashCode => uid.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel && other.uid == uid;
  }
}
