import '../core/utils/app_constant.dart';

class UserModel {
  String? id;
  String? uid;
  String? name;
  String? userName;
  String? photoUrl;
  String? phoneNumber;
  String? email;
  String? password;
  String? typeUser;
  bool isAdd = false;

  bool get isAdmin=>typeUser?.toLowerCase().contains(AppConstants.collectionAdmin.toLowerCase())??false;

  UserModel({
    this.id,
    this.uid,
    this.name,
    this.userName,
    this.email,
    this.photoUrl,
    this.phoneNumber,
    this.password,
    this.typeUser
  });

  factory UserModel.fromJson(json) {
    String name =
        json["name"] ?? '${json["firstName"] ?? ''} ${json["lastName"] ?? ''}';
    return UserModel(
      id: json['id'],
      uid: json["uid"],
      name: json["name"],
      phoneNumber: json["phoneNumber"],
      userName: json["userName"],
      email: json["email"],
      photoUrl: json["photoUrl"],
      typeUser: json["typeUser"],
      //  password:json['password']
    );
  }

  factory UserModel.init() {
    return UserModel(
      id: "",
      uid: '',
      name: '',
      email: '',
      typeUser: '',
    //  password: ''
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'uid': uid,
        'name': name,
        'email': email,
        'userName': userName,
        'phoneNumber': phoneNumber,
        'photoUrl': photoUrl,
        'typeUser': typeUser,
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
