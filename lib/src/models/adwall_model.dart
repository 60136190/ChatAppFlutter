class AdWall {
  bool enable;
  String url;
  final String banner;
  final AdWallData dialogPoint;
  final AdWallData purchasePoint;

  AdWall({this.enable, this.url, this.banner, this.dialogPoint, this.purchasePoint});

  static AdWall formJson(Map<String, dynamic> json) {
    var adWallData = json.containsKey('adwall_data') ? json['adwall_data'] : null;
    return AdWall(
      dialogPoint: adWallData != null && adWallData.containsKey('dialog_point') // live: dialog_not_enough_point
          ? AdWallData.fromJson(adWallData['dialog_point'])
          : null,
      purchasePoint: adWallData != null && adWallData.containsKey('purchase_point') //: live purchase_point_sceen
          ? AdWallData.fromJson(adWallData['purchase_point'])
          : null,
      banner: json.containsKey('adwall_image_url') ? json['adwall_image_url'] : null,
    );
  }
}

class AdWallData {
  final String slug;
  final String displayName;
  final String startNumberOfPurchase;
  final String endNumberOfPurchase;

  const AdWallData({this.slug, this.displayName, this.startNumberOfPurchase, this.endNumberOfPurchase});

  static AdWallData fromJson(Map<String, dynamic> json) {
    return AdWallData(
      slug: json.containsKey('slug') ? json['slug'] : null,
      displayName: json.containsKey('display_name') ? json['display_name'] : null,
      startNumberOfPurchase: json.containsKey('start_number_of_purchase') ? json['start_number_of_purchase'] : null,
      endNumberOfPurchase: json.containsKey('end_number_of_purchase') ? json['end_number_of_purchase'] : null,
    );
  }
}
