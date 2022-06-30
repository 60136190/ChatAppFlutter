// import 'dart:io';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_picker/Picker.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:ms_neighbor/services/check_permission.dart';
// import 'package:ms_neighbor/themes/themes.dart';
// import 'package:task1/src/services/check_permission.dart';
// import 'package:task1/src/themes/themes.dart';
//
// class CustomBottomSheet {
//   final BuildContext context;
//   final String title;
//   final List<String> items;
//   final num defaultSelected;
//   final num isDeleteStyle;
//   final bool showCancel;
//
//   const CustomBottomSheet(this.context,
//       {this.title,
//       this.items,
//       this.defaultSelected,
//       this.isDeleteStyle,
//       this.showCancel = true})
//       : assert(items.length >= 1);
//
//   Future<int> show() async {
//     Widget buildItem(index) =>
//         Stack(alignment: Alignment.center, children: <Widget>[
//           Text('${items[index]}', style: TextStyle(color: Colors.black)),
//           if (defaultSelected != null && defaultSelected == index)
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Icon(Icons.check_box, color: Colors.green),
//             )
//         ]);
//
//     return await showCupertinoModalPopup(
//         barrierColor: Colors.black54,
//         context: context,
//         builder: (context) => showCancel
//             ? CupertinoActionSheet(
//                 title: title != null ? Text('$title') : null,
//                 actions: <Widget>[
//                   ...List.generate(
//                       items.length,
//                       (index) => Container(
//                             color: Colors.white70,
//                             child: CupertinoActionSheetAction(
//                               child: buildItem(index),
//                               onPressed: () => Navigator.pop(context, index),
//                             ),
//                           ))
//                 ],
//                 cancelButton: CupertinoActionSheetAction(
//                   //isDefaultAction: true,
//                   child: const Text(
//                     'キャンセル',
//                     style: TextStyle(color: MyTheme.pinkMedium),
//                   ),
//                   onPressed: () => Navigator.pop(context),
//                 ))
//             : CupertinoActionSheet(
//                 title: title != null ? Text('$title') : null,
//                 actions: <Widget>[
//                   ...List.generate(
//                       items.length,
//                       (index) => CupertinoActionSheetAction(
//                             child: buildItem(index),
//                             onPressed: () => Navigator.pop(context, index),
//                           ))
//                 ],
//               ));
//   }
//
//   static Future<File> imagePicker(BuildContext context) async {
//     var result = await CustomBottomSheet(context, items: [
//       'カメラから',
//       'ギャラリーから',
//     ]).show();
//     switch (result) {
//       case 0:
//         if (await CheckPermission.camera) {
//           var image = await ImagePicker().getImage(source: ImageSource.camera);
//           return File(image.path);
//         }
//         return null;
//       case 1:
//         if (await CheckPermission.photos) {
//           var image = await ImagePicker().getImage(source: ImageSource.gallery);
//           return File(image.path);
//         }
//         return null;
//       default:
//         return null;
//     }
//   }
//
//   static Future<List<int>> customPicker(
//     BuildContext context, {
//     String title,
//     int min,
//     int max,
//     String textFormat,
//     List<int> selecteds,
//   }) async {
//     var listValue;
//     final formatValue = (v) => v == min - 1 ? 'こだわらない' : '$v' + textFormat;
//     await Picker(
//         adapter: NumberPickerAdapter(data: [
//           NumberPickerColumn(
//               begin: min - 1, end: max, onFormatValue: formatValue),
//           NumberPickerColumn(
//               begin: min - 1, end: max, onFormatValue: formatValue)
//         ]),
//         height: 200,
//         cancelText: 'キャンセル',
//         title: Text('$title     ',
//             style: TextStyle(
//                 fontSize: 16,
//                 color: MyTheme.textDefaultColor,
//                 fontWeight: FontWeight.bold)),
//         confirmText: '完了',
//         cancelTextStyle: TextStyle(
//             fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w400),
//         confirmTextStyle:
//             TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
//         textStyle: TextStyle(fontSize: 16, color: MyTheme.textDefaultColor),
//         selectedTextStyle: TextStyle(fontSize: 18, color: Colors.blue),
//         selecteds: selecteds,
//         onConfirm: (Picker picker, _) {
//           int _min = picker.getSelectedValues()[0];
//           int _max = picker.getSelectedValues()[1];
//           listValue = [_min, _max];
//         }).showModal(context);
//     return listValue;
//   }
// }
