class UserData {
  String? sId; // Update from "_id" to "sId"
  String? companyEmployeeID;
  String? managerID;
  DateTime? joiningDate;
  String? profilePhoto;
  String? jobTitle;
  String? mobileNumber;
  String? companyName;
  String? address;
  String? department;
  String? education;
  String? employmentStatus;
  String? workSchedule;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? salary;

  UserData({
    this.sId,
    this.companyEmployeeID,
    this.managerID,
    this.joiningDate,
    this.profilePhoto,
    this.jobTitle,
    this.mobileNumber,
    this.companyName,
    this.address,
    this.department,
    this.education,
    this.employmentStatus,
    this.workSchedule,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.salary,
  });

  UserData.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      sId = json['_id'] ?? ""; // Update from "_id" to "sId"
      companyEmployeeID = json['ComapnyEmplyeeID'] ?? "";
      managerID = json['ManagerId'] ?? "";
      joiningDate = json['JoiningDate'] != null
          ? DateTime.parse(json['JoiningDate'])
          : null;
      profilePhoto = json['ProfilePhoto'] ?? "";
      jobTitle = json['JobTitle'] ?? "";
      mobileNumber = json['MoblieNumber'] ?? "";
      companyName = json['CompanyName'] ?? "";
      address = json['Address'] ?? "";
      department = json['Department'] ?? "";
      education = json['Education'] ?? "";
      employmentStatus = json['EmploymentStatus'] ?? "";
      workSchedule = json['WorkSedule'] ?? "";
      firstName = json['FirstName'] ?? "";
      lastName = json['LastName'] ?? "";
      email = json['Email'] ?? "";
      password = json['Password'] ?? "";
      salary = json['Salary'] ?? "";
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId; // Update from "sId" to "_id"
    data['ComapnyEmplyeeID'] = companyEmployeeID;
    data['ManagerId'] = managerID;
    data['JoiningDate'] = joiningDate?.toIso8601String();
    data['ProfilePhoto'] = profilePhoto;
    data['JobTitle'] = jobTitle;
    data['MoblieNumber'] = mobileNumber;
    data['CompanyName'] = companyName;
    data['Address'] = address;
    data['Department'] = department;
    data['Education'] = education;
    data['EmploymentStatus'] = employmentStatus;
    data['WorkSedule'] = workSchedule;
    data['FirstName'] = firstName;
    data['LastName'] = lastName;
    data['Email'] = email;
    data['Password'] = password;
    data['Salary'] = salary;
    return data;
  }
}
