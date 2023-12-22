class AppNotyficationsRegisterBody {
  String deviceHash;
  String deviceName;
  String fcmToken;
  String username;

  AppNotyficationsRegisterBody({
    required this.deviceHash,
    required this.deviceName,
    required this.fcmToken,
    required this.username,
  });

  Map<String, dynamic> toJson() => {
        'deviceHash': deviceHash,
        'deviceName': deviceName,
        'fcmToken': fcmToken,
        'username': username,
      };
}
