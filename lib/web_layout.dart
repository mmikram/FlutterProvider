import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:item_tracker/display_item.dart';

import 'package:item_tracker/item_provider.dart';
import 'package:item_tracker/my_drawer.dart';
import 'package:provider/provider.dart';

class WebLayout extends StatefulWidget {
  const WebLayout({super.key});

  @override
  State<WebLayout> createState() => _WebLayoutState();
}

class _WebLayoutState extends State<WebLayout> {
  ItemProvider? itemProvider;

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemProvider>(builder: ((context, itemProvider, child) {
      return Scaffold(
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
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              myDrawer,
              displayList(context, itemProvider),
            ],
          )
      );
    }));
  }


}
