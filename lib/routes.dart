import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task1/src/services/socket_io_client.dart';
import 'package:task1/src/storages/store.dart';
import 'package:task1/src/ui/auth/login_screen.dart';
import 'package:task1/src/ui/auth/register_screen.dart';

class Routes {
  static const String appNavigator = 'main';
  static const String loginScreen = 'login';
  static const String registerScreen = 'register';
  static const String registerPhoneNumberScreen = 'registerPhoneNumber';
  static const String verifyPhoneNumberScreen = 'verifyPhoneNumber';
  static const String suggestedLikesScreen = 'suggestedLikes';
  static const String settingScreen = 'setting';
  static const String webViewScreen = 'webView';
  static const String chattingScreen = 'chatting';
  static const String chattingGroupScreen = 'chattingGroup';
  static const String noticeDetailScreen = 'noticeDetail';
  static const String postKeijibanScreen = 'postKeijiban';
  static const String keijibanDetailScreen = 'keijibanDetail';
  static const String userProfileScreen = 'user';
  static const String editProfileScreen = 'editProfile';
  static const String editStatusScreen = 'editStatus';
  static const String favoriteFootprintScreen = 'favoritefootprint';
  static const String blockListScreen = 'block';
  static const String variousSettingScreen = 'various';
  static const String addPointScreen = 'point';
  static const String contactScreen = 'contact';
  static const String activityScreen = 'activity';

  static const String showImage = 'showImage';
  static const String showMapView = 'showMapview';
  static const String userSearchScreen = 'userSearch';
  static const String noticeScreen = 'noticeScreen';
  static const String campaignScreen = 'campaignScreen';

  static const String myPageNoticeDetailScreen = 'myPageNoticeDetail';

  static const String devicePrepareScreen = 'DevicePrepareScreen';

  static const String callScreen = 'callScreen';

  static const String keijibanSearch = 'keijibanSearch';
  static const String keijibanNewPostScreen = 'keijibanPostScreen';
  static const String pointTable = 'pointTable';

  static const String blogScreen = 'UserBlogListScreen';
  static const String blogDetail = 'UserBlogDetailScreen';
  static const String blogMypagePost = 'BlogMypagePostScreen';

  static const String allUserNavi = 'allUserNavi';

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    if (routeSettings.name != loginScreen &&
        routeSettings.name != registerScreen &&
        routeSettings.name != webViewScreen)
      store<SocketIo>().sendScreenView(routeSettings.name);

    switch (routeSettings.name) {
      // case loginScreen:
      //   return MaterialPageRoute(
      //       builder: (context) => LoginScreen(), settings: routeSettings);
      case registerScreen:
        return MaterialPageRoute(builder: (context) => RegisterScreen());

      // case appNavigator:
      //   return MaterialPageRoute(builder: (context) => AppNavigator());
      //
      // case userSearchScreen:
      //   return MaterialPageRoute(
      //       builder: (context) => UserSearchScreen(), fullscreenDialog: true);
      //
      // case devicePrepareScreen:
      //   return MaterialPageRoute(builder: (context) => DevicePrepareScreen());

    // message
    // keijiban
    // point add
    // mypage

      // case settingScreen:
      //   return MaterialPageRoute(builder: (context) => SettingScreen());
      // case webViewScreen:
      //   final args = routeSettings.arguments as List<String>;
      //   return MaterialPageRoute(
      //       settings: routeSettings,
      //       builder: (context) => WebViewScreen(url: args[0], title: args[1]));
      // case chattingScreen:
      //   UserChat userChat;
      //   if (routeSettings.arguments is Map) {
      //     final value = routeSettings.arguments as Map;
      //     userChat = value['userChat'];
      //   } else
      //     userChat = routeSettings.arguments as UserChat;
      //   return MaterialPageRoute(
      //       settings: routeSettings,
      //       builder: (context) => ChattingScreen(userChat: userChat));
      // case chattingGroupScreen:
      //   return MaterialPageRoute(
      //       settings: routeSettings,
      //       builder: (context) => ChattingGroupScreen(
      //         infoRoom: routeSettings.arguments,
      //       ));
      //
      // case noticeDetailScreen:
      //   return MaterialPageRoute(
      //       builder: (context) =>
      //           MyPageNoticeDetailScreen(routeSettings.arguments));
      //
      // case keijibanDetailScreen:
      //   return MaterialPageRoute(
      //       settings: routeSettings,
      //       builder: (context) => KeijibanDetailScreen(
      //         keijiban: routeSettings.arguments,
      //       ));

      // case userProfileScreen:
      //   int userID;
      //   bool hideBottomTabbarWhenReturn = false;
      //   if (routeSettings.arguments is Map) {
      //     final value = routeSettings.arguments as Map;
      //     userID = value['userID'];
      //     hideBottomTabbarWhenReturn = value['hideBottomTabbarWhenReturn'];
      //   } else
      //     userID = routeSettings.arguments as int;
      //   return MaterialPageRoute(
      //       settings: routeSettings,
      //       builder: (context) => UserProfileScreen(
      //           userID: userID,
      //           hideBottomTabbarWhenReturn: hideBottomTabbarWhenReturn));
      //
      // case editStatusScreen:
      //   return MaterialPageRoute(builder: (context) => EditStatusScreen());
      //
      // case editProfileScreen:
      //   return MaterialPageRoute(
      //     settings: routeSettings,
      //     builder: (context) =>
      //         EditProfileScreen(profile: routeSettings.arguments),
      //   );
      //
      // case favoriteFootprintScreen:
      //   final firstScreen = routeSettings.arguments as String;
      //   return MaterialPageRoute(
      //       builder: (context) =>
      //           FavoritesFootprintScreen(firstScreen: firstScreen));
      //
      // case blockListScreen:
      //   return MaterialPageRoute(builder: (context) => BlockListScreen());
      //
      // case variousSettingScreen:
      //   return MaterialPageRoute(builder: (context) => VariousSettingScreen());
      //
      // case addPointScreen:
      //   return MaterialPageRoute(builder: (context) => AddPointScreen());
      //
      // case contactScreen:
      //   return MaterialPageRoute(builder: (context) => ContactScreen());
      //
      // case activityScreen:
      //   return MaterialPageRoute(builder: (context) => ActivityScreen());
      //
      // case ShowImage.route:
      //   var tag;
      //   var url;
      //   final arg = routeSettings.arguments;
      //   if (arg is Map) {
      //     tag = arg['tag'];
      //     url = arg['urlImage'];
      //   } else {
      //     tag = url = arg;
      //   }
      //   return ShowImage(tag: tag, urlImage: url);
      //
      // case noticeScreen:
      //   return MaterialPageRoute(builder: (context) => NoticeScreen());
      //
      // case campaignScreen:
      //   return MaterialPageRoute(builder: (context) => CampaignScreen());
      //
      // case myPageNoticeDetailScreen:
      //   return MaterialPageRoute(
      //       builder: (context) =>
      //           MyPageNoticeDetailScreen(routeSettings.arguments));
      //
      // case keijibanSearch:
      //   return MaterialPageRoute(builder: (_) => KeijibanSearchScreen());
      //
      // case keijibanNewPostScreen:
      //   return MaterialPageRoute(
      //       builder: (_) => KeijibanNewPostScreen(
      //         bloc: routeSettings.arguments,
      //       ));
      //
      // case pointTable:
      //   return MaterialPageRoute(builder: (_) => PointTableScreen());
      //
      // case blogScreen:
      //   return MaterialPageRoute(
      //       builder: (_) => BlogListScreen(routeSettings.arguments));
      //
      // case blogDetail:
      //   return MaterialPageRoute(
      //       builder: (_) => BlogDetailScreen(routeSettings.arguments));
      //
      // case blogMypagePost:
      //   return MaterialPageRoute(builder: (_) => BlogMypagePostScreen());
      //
      // case allUserNavi:
      //   return MaterialPageRoute(
      //       builder: (_) => AllUserNavi(filter: routeSettings.arguments));

      default:
        return null;
    }
  }
}
