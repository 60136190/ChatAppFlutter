class RegisterData {
  final String displayName, password, genderID, age, areaID, cityID, carrierName, mobileNetworkCode, deviceID;

  const RegisterData({
    this.displayName,
    this.password,
    this.genderID,
    this.age,
    this.areaID,
    this.cityID,
    String carrierName,
    String mobileNetworkCode,
    String deviceID
  }) : this.carrierName = carrierName ?? 'UNKNOWN',
        this.mobileNetworkCode = mobileNetworkCode ?? 'UNKNOWN',
        this.deviceID = deviceID ?? 'UNKNOWN';

  Map<String, String> toJson() => {
    'displayname': displayName,
    'password': password,
    'sex': genderID,
    'age': age,
    'area': areaID,
    'city': cityID
    // 'carriername': carrierName,
    // 'mobilenetworkcode': mobileNetworkCode
  };
}