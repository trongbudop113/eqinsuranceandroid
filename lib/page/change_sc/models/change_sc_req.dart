class ChangeSCReq {
  String? sUserName;
  String? sPassword;
  String? sUserID;
  String? sOldPin;
  String? sNewPin;
  String? sManufacturer;
  String? sModel;
  String? sOsName;
  String? sOsVersion;

  ChangeSCReq({this.sUserName, this.sPassword, this.sUserID, this.sOsVersion, this.sOsName, this.sModel, this.sManufacturer, this.sOldPin, this.sNewPin});

  Map<String, dynamic> toMap() {
    return {
      '_UserName': this.sUserName,
      '_Password': this.sPassword,
      '_UserID': this.sUserID,
      '_OldPin': this.sOldPin,
      '_NewPin': this.sNewPin,
      '_manufacturer': this.sManufacturer,
      '_model': this.sModel,
      '_osname': this.sOsName,
      '_osversion': this.sOsVersion,
    };
  }
}