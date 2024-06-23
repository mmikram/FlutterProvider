import 'package:flutter/material.dart';
import 'package:item_tracker/display_item.dart';

import 'package:item_tracker/item_provider.dart';
import 'package:item_tracker/my_drawer.dart';
import 'package:provider/provider.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  ItemProvider? itemProvider;

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemProvider>(builder: ((context, itemProvider, child) {
      return Scaffold(
        drawer: myDrawer,
        appBar: AppBar(
          title: const Text("Item Tracker"),
          backgroundColor: Colors.lightBlue,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            displayDialog(context, itemProvider, 0, false);
          },
          child: const Icon(Icons.add),
        ),
        body: displayList(context, itemProvider)
      );
    }));
  }


}
