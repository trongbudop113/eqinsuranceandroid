class GetNotificationReq {
  String? sUserName;
  String? sPassword;
  String? sType;
  String? sAgentCode;

  GetNotificationReq({this.sUserName, this.sPassword, this.sType, this.sAgentCode});

  Map<String, dynamic> toMap() {
    return {
      '_UserName': this.sUserName,
      '_Password': this.sPassword,
      '_Type': this.sType,
      '_AgentCode': this.sAgentCode,
    };
  }
}