import 'package:flutter/material.dart';
import 'package:item_tracker/calculate.dart';
import 'package:item_tracker/item.dart';

class ItemProvider extends ChangeNotifier {
  List<Item> itemList = List.empty(growable: true);
  late List<GlobalKey> key;

  void addItem(Item item, int index) {
    itemList.add(item);
    key = List.generate(itemList.length, (index) => GlobalKey());
    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }

  void removeItem(int index) {
    itemList.removeAt(index);
    // itemList.removeWhere((element) => element.name==item.name);
    key = List.generate(itemList.length, (index) => GlobalKey());
    notifyListeners();
  }

  void editItem(Item item, int index) {
    itemList[index] = item;
    notifyListeners();
  }

  Calculate? getWidgetSizePosition(int index) {
    if (null != key[index].currentContext) {
      final RenderBox renderBox =
          key[index].currentContext?.findRenderObject()! as RenderBox;

      return Calculate(renderBox.size, renderBox.localToGlobal(Offset.zero));
    }

    return null;
  }
}
