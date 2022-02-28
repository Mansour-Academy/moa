class TranslationModel {
  late String loginHead;
  late String emailAddress;
  late String password;
  late String emailAddressError;
  late String passwordError;
  late String donNotHaveAccount;
  late String registerNow;

  late String registerHead;
  late String fullName;
  late String nationalId;
  late String government;
  late String mobileNumber;
  late String address;
  late String confirmPassword;

  late String fullNameError;
  late String nationalIdError;
  late String mobileNumberError;
  late String addressError;
  late String confirmPasswordError;

  late String myRequests;
  late String orderNumber;
  late String requestType;
  late String submissionDate;
  late String orderStatus;
  late String departmentName;
  late String responseDate;
  late String attendanceDate;
  late String comments;
  late String print;
  late String noDataFound;





  TranslationModel.fromJson(Map<String, dynamic> json) {
    noDataFound = json['noDataFound'];
    print = json['print'];
    myRequests = json['myRequests'];
    orderNumber = json['orderNumber'];
    requestType = json['requestType'];
    submissionDate = json['submissionDate'];
    orderStatus = json['orderStatus'];
    departmentName = json['departmentName'];
    responseDate = json['responseDate'];
    attendanceDate = json['attendanceDate'];
    comments = json['comments'];


    fullNameError = json['fullNameError'];
    nationalIdError = json['nationalIdError'];
    mobileNumberError = json['mobileNumberError'];
    addressError = json['addressError'];
    confirmPasswordError = json['confirmPasswordError'];

    registerHead = json['registerHead'];
    fullName = json['fullName'];
    nationalId = json['nationalId'];
    government = json['government'];
    mobileNumber = json['mobileNumber'];
    address = json['address'];
    confirmPassword = json['confirmPassword'];

    loginHead = json['loginHead'];
    emailAddress = json['emailAddress'];
    password = json['password'];
    emailAddressError = json['emailAddressError'];
    passwordError = json['passwordError'];
    donNotHaveAccount = json['donNotHaveAccount'];
    registerNow = json['registerNow'];
  }

  Map toJson() => {
        'fullNameError': fullNameError,
        'nationalIdError': nationalIdError,
        'mobileNumberError': mobileNumberError,
        'addressError': addressError,
        'confirmPasswordError': confirmPasswordError,

        'registerHead': registerHead,
        'fullName': fullName,
        'nationalId': nationalId,
        'government': government,
        'mobileNumber': mobileNumber,
        'address': address,
        'confirmPassword': confirmPassword,

        'loginHead': loginHead,
        'emailAddress': emailAddress,
        'password': password,
        'emailAddressError': emailAddressError,
        'passwordError': passwordError,
        'donNotHaveAccount': donNotHaveAccount,
        'registerNow': registerNow,
      };
}
