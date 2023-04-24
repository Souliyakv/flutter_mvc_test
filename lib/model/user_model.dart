import 'dart:convert';

// ເປັນການສະແດງຂໍ້ມູນ
UserModel userFromJson(String str) => UserModel.fromJson(json.decode(str));
String userToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  // ເປັນ ຕົວປ່ຽນພາຍໃນໃຊ້ໃນ model
  UserModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.phone,
      this.password,
      this.profile,
      this.token});
  // ຕົວປ່ຽນພາຍນອກທີ່ສົ່ງມາ
  int? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? password;
  String? profile;
  String? token;
// ເປັນການສ້າງ from ຂໍ້ມູນເພື່ອເອົາໄປໃສ່ງານ
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phone: json["phone"],
        password: json["password"],
        profile: json["profile"],
        token: json["token"],
      );
// ເປັນການສົ່ງຂໍ້ມູນກັບຄືນຫາ server
  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "password": password,
        "profile": profile,
        "token": token
      };
}
