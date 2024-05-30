class UserModel {
  String? id;
  String? uid;
  String? name;
  String? photoUrl;
  String? email;
  String? password;
  bool isAdd = false;

  UserModel({
    this.id,
    this.uid,
    this.name,
    this.email,
    this.photoUrl,
    this.password
  });

  factory UserModel.fromJson(json) {
    String name =
        json["name"] ?? '${json["firstName"] ?? ''} ${json["lastName"] ?? ''}';
    return UserModel(
      id: json['id'],
      uid: json["uid"],
      name: name,
      email: json["email"],
      photoUrl: json["photoUrl"],
      //  password:json['password']
    );
  }

  factory UserModel.init() {
    return UserModel(
      id: "",
      uid: '',
      name: '',
      email: '',
    //  password: ''
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'uid': uid,
        'name': name,
        'email': email,
        'photoUrl': photoUrl,
      };
}

//users
class Users {
  List<UserModel> users;

  //DateTime date;

  Users({required this.users});

  factory Users.fromJson(json) {
    List<UserModel> tempUsers = [];

    for (int i = 0; i < json.length; i++) {
      UserModel tempUser = UserModel.fromJson(json[i]);
      tempUser.id = json[i].id;
      tempUsers.add(tempUser);
    }
    return Users(users: tempUsers);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> tempUsers = [];
    for (UserModel user in users) {
      tempUsers.add(user.toJson());
    }
    return {
      'users': tempUsers,
    };
  }
}
