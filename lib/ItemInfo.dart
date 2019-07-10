///
/// The information of the item
///
import 'package:flutter/material.dart';

class ItemInfo {
  String msg;
  Color color;

  ItemInfo({this.msg, this.color});

  String get getContent => msg;
  Color get getColor => color;

}