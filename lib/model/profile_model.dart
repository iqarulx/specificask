class ProfileModel {
  String chapterName;
  String name;
  String companyName;
  String firstName;
  String lastName;
  String businessType;
  String mobileNumber;
  String classification;
  ProfileModel({
    required this.chapterName,
    required this.name,
    required this.companyName,
    required this.firstName,
    required this.lastName,
    required this.businessType,
    required this.mobileNumber,
    required this.classification,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chapterName': chapterName,
      'name': name,
      'companyName': companyName,
      'firstName': firstName,
      'lastName': lastName,
      'businessType': businessType,
      'mobileNumber': mobileNumber,
      'classification': classification,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      chapterName: map['chapter_name'] as String,
      name: map['name'] as String,
      companyName: map['company_name'] as String,
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      businessType: map['business_type'] as String,
      mobileNumber: map['mobile_number'] as String,
      classification: map['classification'] as String,
    );
  }
}
