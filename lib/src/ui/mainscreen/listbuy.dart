import 'package:flutter/material.dart';

class ListBuy {
  final String promotion;
  final String pt;
  final int price;
  final String color;

  ListBuy(@required this.promotion,@required this.pt,@required this.price, @required this.color);
}

List listbuy = [
  ListBuy("+80", "500", 5000,"0xffb74093"),
  ListBuy("+40", "300", 3000,"0xffb74093"),
  ListBuy("+20", "200", 2000,"0xffb74093"),
  ListBuy("+10", "150", 1500,"0xffb74093"),
  ListBuy("+5", "100", 1000,"0xffb74093"),
  ListBuy("+5", "100", 1000,"0xffb74093"),
  ListBuy("+5", "100", 1000,"0xffb74093"),
  ListBuy("+5", "100", 1000,"0xffb74093"),
  ListBuy("+5", "100", 1000,"0xffb74093"),
  ListBuy("+5", "100", 1000,"0xffb74093"),
];
