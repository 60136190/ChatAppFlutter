// import 'dart:math';
// import 'package:intl/intl.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class Utils {
//   static Color hexToColor(String code) {
//     return new Color(
//         int.tryParse(code.substring(1, 7), radix: 16)! + 0xFF000000);
//   }
//
//   static String parseParamsToData(Map value) {
//     String params = '?';
//     for (String key in value.keys) {
//       if (value[key] == null || value[key] == '' || value[key] == 'null') {
//         //break;
//       } else {
//         String addParam = key + '=' + value[key].toString();
//
//         if (params != '?') {
//           // first param
//           params += '&' + addParam;
//         } else {
//           // after 2nd param
//           params += addParam;
//         }
//       }
//     }
//
//     return params;
//   }
//
//   // static checkImageCache(String urlImage) async {
//   //   //print("image url: $urlImage");
//   //   if (urlImage == null || urlImage.isEmpty) return null;
//   //   final cacheVariable = '?time=';
//   //   final prefs = await SharedPreferences.getInstance();
//   //   var url = urlImage;
//   //   if (url.contains(cacheVariable)) {
//   //     List<String> arraySplit = urlImage.split(cacheVariable);
//   //     prefs.setString(arraySplit[0], arraySplit[1]);
//   //     if (arraySplit[0].contains('temp/')) {
//   //       final s = arraySplit[0].replaceAll("temp/", '');
//   //       prefs.setString(s, arraySplit[1]);
//   //     }
//   //     url = arraySplit[0] + cacheVariable + arraySplit[1];
//   //   } else {
//   //     final cacheValue = prefs.getString(urlImage) ?? null;
//   //     if (cacheValue != null) {
//   //       url = urlImage + cacheVariable + cacheValue;
//   //     } else {
//   //       final currentTime = DateTime.now().millisecondsSinceEpoch;
//   //       prefs.setString(urlImage, currentTime?.toString());
//   //       url = urlImage + cacheVariable + currentTime?.toString();
//   //     }
//   //   }
//   //   //print(url);
//   //   return url;
//   // }
//
//   static Map<String, String> paramsToMap(Map value) {
//     var params = Map<String, String>();
//     for (String key in value.keys) {
//       if (value[key] == null || value[key] == 'null') {
//       } else {
//         params[key] = value[key];
//       }
//     }
//     return params;
//   }
//
//   static timestampToHour(String data) {
//     if (data != null && data.isNotEmpty) {
//       // var date = new DateTime.fromMillisecondsSinceEpoch(DateTime.parse(data).millisecondsSinceEpoch);
//       // return '${_formatTime(date.hour)}:${_formatTime(date.minute)}';
//
//       DateTime date = DateFormat("yyyy-M-d HH:mm").parse(data);
//       String dateFormat = DateFormat('yyyy/M/d HH:mm').format(date);
//
//       final dateNow = DateTime.now();
//
//       final difference = dateNow.difference(date);
//
//       if (difference.inDays > 8) {
//         return dateFormat;
//       }else if (difference.inDays >= 1) {
//         return '${difference.inDays} 日前';
//       }else if (difference.inMinutes >= 2) {
//         return '${difference.inMinutes} 分前';}
//     }
//     return '';
//   }
//
//   static String randomPassword(int length) {
//     const chars = "abcdefghijklmnopqrstuvwxyz0123456789";
//     Random random = new Random(new DateTime.now().millisecondsSinceEpoch);
//     String result = "";
//     for (var i = 0; i < length; i++) {
//       result += chars[random.nextInt(chars.length)];
//     }
//     return result;
//   }
//
//   static String randomString(int length) {
//     var rand = new Random();
//     var codeUnits = new List.generate(length, (index) {
//       return rand.nextInt(33) + 89;
//     });
//     return new String.fromCharCodes(codeUnits);
//   }
//
//   static _formatTime(time) {
//     if (time.toString().length == 1)
//       return '0' + time.toString();
//     else
//       return time;
//   }
//
//   // static timeToString(dynamic timestamp) {
//   //   var date = new DateTime.fromMillisecondsSinceEpoch(
//   //       int.tryParse(timestamp.toString()));
//   //   return '${_formatTime(date.month)}'
//   //       '/'
//   //       '${_formatTime(date.day)}'
//   //       ' '
//   //       '${_formatTime(date.hour)}'
//   //       ':'
//   //       '${_formatTime(date.minute)}';
//   // }
//
//   // Format: YYYY/MM/DD hh:mm
//   static String formatDateTimeForPostMeta(DateTime dateTime) {
//     return '${dateTime.year}/'
//         '${dateTime.month.toString().padLeft(2, '0')}/'
//         '${dateTime.day.toString().padLeft(2, '0')} '
//         '${dateTime.hour}:'
//         '${dateTime.minute.toString().padLeft(2, '0')}';
//   }
//
//   static void shiftFocus(BuildContext context, FocusNode from, FocusNode to) {
//     from.unfocus();
//     FocusScope.of(context).requestFocus(to);
//   }
//
//   // static PickerModel toPicker(List<PickerModel> list, String id) {
//   //   if (id == '' || id == 'null') return null;
//   //   int index = list.indexWhere((item) => item.value == int.tryParse(id));
//   //
//   //   if (index != -1)
//   //     return list[index];
//   //   else
//   //     return null;
//   // }
//
//   // static String getName(List<PickerModel> list, String id) {
//   //   if (id == '' || id == null || id == 'null') return '未設定';
//   //   int index = list.indexWhere((item) => item.value == int.tryParse(id));
//   //
//   //   if (index != -1)
//   //     return list[index].name;
//   //   else
//   //     return '未設定';
//   // }
//
//   static bool isGoodEnoughEmailAddress(String input) =>
//       RegExp(r'^\S+@\S+$', caseSensitive: false).hasMatch(input);
//
//   // static Future<PickedFile> getImageFromGallery() async {
//   //   PickedFile imagePicker;
//   //   try {
//   //     imagePicker = await ImagePicker().getImage(source: ImageSource.gallery, imageQuality: 100);
//   //     return imagePicker;
//   //   } catch (e) {
//   //     print('getImageFromGallery error: $e');
//   //     return null;
//   //   }
//   // }
//
//   // static String numberFormat(String number) {
//   //   if (number.length > 3) {
//   //     var value = number;
//   //     value = value.replaceAll(RegExp(r'\D'), '');
//   //     value = value.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), ',');
//   //     return value;
//   //   }
//   //   return number;
//   // }
//
//   // static Future<String> getVOIPToken() async {
//   //   final prefer = await SharedPreferences.getInstance();
//   //   return prefer.getString("voipToken") ?? null;
//   // }
//   //
//   // static setVOIPToken(String voipToken) async {
//   //   final prefer = await SharedPreferences.getInstance();
//   //   prefer.setString("voipToken", voipToken);
//   // }
// }
