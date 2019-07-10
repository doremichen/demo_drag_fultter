///
/// Common data or util
///
import 'package:flutter/material.dart';
import 'ItemInfo.dart';

class APP_UTILE {

  static const bool SUCCESS = true;
  static const bool FAIL = false;

  static List<String> PAGE_NAME = [
    "Drag demo",
  ];

  static List<ItemInfo> initializeList(List<ItemInfo> list) {
    List<ItemInfo> items = [
      ItemInfo(msg: "One", color: Colors.red),
      ItemInfo(msg: "TWO", color: Colors.yellow),
      ItemInfo(msg: "THREE", color: Colors.green),
    ];

    return items;
  }

}