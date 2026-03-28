class UserModeL {
  String name;
  String email;
  String? image;
  String? address;
  String? token;
  String? visa;

  UserModeL({
    required this.name,
    required this.email,
    this.image,
    this.address,
    this.token,
    this.visa,
  });

  factory UserModeL.fromJson(Map<String,dynamic> json){
    return UserModeL(
      name: json["name"]?? "",
      email: json["email"] ?? "",
      image: json["image"] ?? "",
      address: json["address"] ?? "",
      token: json["token"] ?? "",
      visa: json["Visa"]?.toString() ?? "",
    );
  }
}
