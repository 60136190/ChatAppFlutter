
class User {
  int userID;
  String userCode;
  String displayName;
  String avatarUrl;

  List<bool> isWaitingApprove;
  String age;
  User({this.userID, this.userCode, this.displayName, this.avatarUrl, this.isWaitingApprove, this.age,});
}
