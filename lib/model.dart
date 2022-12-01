class UserModel {
  String? email;
  String? wrool;
  String? uid;
  String? name;

// receiving data
  UserModel({this.uid, this.email, this.wrool, this.name});
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      wrool: map['wrool'],
      name: map['name'],
    );
  }
// sending data
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'wrool': wrool,
      'name': name,
    };
  }
}
