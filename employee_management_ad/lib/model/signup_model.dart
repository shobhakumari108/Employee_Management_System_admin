class Admin {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? sId;

  Admin({this.firstName, this.lastName, this.email, this.password, this.sId});

  Admin.fromJson(Map<String, dynamic> json) {
    firstName = json['FirstName'];
    lastName = json['LastName'];
    email = json['Email'];
    password = json['Password'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FirstName'] = this.firstName;
    data['LastName'] = this.lastName;
    data['Email'] = this.email;
    data['Password'] = this.password;
    data['_id'] = this.sId;
    return data;
  }
}
