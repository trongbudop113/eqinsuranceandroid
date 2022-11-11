class UpdateDeviceReq {
  String? ClientId;
  String? RequestKey;
  String? Username;

  UpdateDeviceReq({this.ClientId, this.RequestKey, this.Username});

  Map<String, dynamic> toMap() {
    return {
      'ClientId': this.ClientId,
      'RequestKey': this.RequestKey,
      'Username': this.Username
    };
  }
}