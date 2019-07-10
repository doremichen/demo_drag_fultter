///
/// The item data
///
import 'package:flutter/foundation.dart';

import 'ItemInfo.dart';
import 'utils.dart';

class DataController with ChangeNotifier {


  // drop status
  bool dropStatus;
  // the info of item
  ItemInfo acceptInfo;
  // the list of the item
  List<ItemInfo> items;

  // Initialization
  DataController() {
    dropStatus = APP_UTILE.FAIL;
    items = APP_UTILE.initializeList(items);
  }

  // interface
  bool get isDropStatus => dropStatus;
  ItemInfo get getAcceptItemInfo => acceptInfo;
  List<ItemInfo> get getItemList => items;

  // Initialize draggable list
  initDragList() {
    items = APP_UTILE.initializeList(items);
    notifyListeners();
  }

  // Add item to list
  addItem(ItemInfo item) {
    items.add(item);
    notifyListeners();
  }

  // remove item form list
  removeItem() {
    items.removeLast();
    notifyListeners();
  }

  // change drop status
  changeDropStatus(bool status) {
    dropStatus = status;
    notifyListeners();
  }

  // set accepted info
  setAcceptedInfo(ItemInfo data) {
    acceptInfo = data;
    notifyListeners();
  }

}