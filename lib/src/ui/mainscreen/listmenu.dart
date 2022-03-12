import 'package:flutter/material.dart';
class ListMenu{
  final String name;
  final String price;
  final String newMessage;
  ListMenu(@required this.name,@required this.price,@required this.newMessage);
}

List listmenu = [
  ListMenu('Thai nam', '10-30vnd','hello'),
  ListMenu('Thuy Tien', '10-30vnd','hello'),
  ListMenu('Kim Binh', '10-30vnd','you are welcome'),
  ListMenu('Khanh Vy', '10-30vnd','good bye'),
  ListMenu('Thai nam', '10-30vnd','hello'),
  ListMenu('Thai nam', '10-30vnd','hello'),
  ListMenu('Thai nam', '10-30vnd','hello'),
  ListMenu('Thai nam', '10-30vnd','hello'),
];