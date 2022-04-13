import 'package:task1/src/models/table_of_contents_model.dart';
import 'package:task1/src/models/user_profile_list_model.dart';
import 'package:task1/src/utils/ng_words.dart' as NGWords;


class ServerState {
  final UserProfileMetadata userProfileList;
  final List<TableOfContentsModel> qaTableOfContents;
  final Map<String, String> contactCategories;
  final String profileNotSet;
  final int supporter;
  final Map<String, dynamic> agencyConfig;
  final Map<String, dynamic> functionOff;
  final int enabledIdentify;
  final Map chatNotice;
  final String pushOffTitle;
  final String pushOffContent;
  final String pushOffImage;

  ServerState({
    this.userProfileList,
    this.qaTableOfContents,
    this.contactCategories,
    this.profileNotSet,
    this.supporter,
    this.agencyConfig,
    this.functionOff,
    this.enabledIdentify,
    this.chatNotice,
    this.pushOffTitle,
    this.pushOffContent,
    this.pushOffImage
  });

  bool get reviewMode {
    //print("version_appstore_review::: ${this.functionOff['version_appstore_review']}");
    // return true;
    return this.functionOff['version_appstore_review']?.toString() == '1';
  }

  static ServerState fromJson(Map<String, dynamic> json) {
    NGWords.initFromAPIData(json);

    final jsonData = json['data'];
    Map<String, dynamic> jsonMap (String key)  => jsonData.containsKey(key) ? jsonData[key] : null; 
    String jsonString (String key)  => jsonData.containsKey(key) ? '${jsonData[key] ?? ''}' : '';
    int jsonInt (String key)  => jsonData.containsKey(key) ? int.tryParse('${jsonData[key]}') : null;
    int jsonSupporterInt (String key)  => jsonData['supporter'].containsKey(key) ? int.tryParse('${jsonData['supporter'][key]}') : null;

    return ServerState(
      userProfileList: UserProfileMetadata.fromAPIData(json),
      qaTableOfContents: TableOfContentsModel.fromAPIData(json),
      profileNotSet: jsonString('profile_not_set'),
      supporter: jsonMap('supporter') != null ? jsonSupporterInt('id') : null,
      agencyConfig: jsonMap('agency_config'),
      functionOff: jsonMap('function_off'),
      // enabledIdentify: jsonSupporterInt('enabled_identify'),
      enabledIdentify: jsonInt('enabled_identify'),
      chatNotice: jsonMap('chat_warning'),

      pushOffTitle: jsonString('push_off_title'),
      pushOffContent: jsonString('push_off_content'),
      pushOffImage: jsonString('push_off_image'),
    );
  }
}