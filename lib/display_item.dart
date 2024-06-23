import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:item_tracker/calculate.dart';

import 'package:item_tracker/item.dart';
import 'package:item_tracker/item_provider.dart';

  Widget displayList(BuildContext context, ItemProvider itemProvider) {
    return Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: itemProvider.itemList.length,
          itemBuilder: (context, index) {
            return Card(
              key: itemProvider.key[index],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        itemProvider.itemList[index].name,
                        style:
                        const TextStyle(color: Colors.brown, fontSize: 18),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 4.0),
                      child: Text(
                        itemProvider.itemList[index].description,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                            child: const Text('Know Widget Position and Size'),
                            onPressed: () {
                              final calculate =
                              itemProvider.getWidgetSizePosition(index);
                              _calculateDisplayDialog(calculate!,context);
                            }),
                        IconButton(
                            onPressed: () {
                              itemProvider.removeItem(index);
                            },
                            color: Colors.red,
                            icon: const Icon(Icons.delete)),
                        IconButton(
                            onPressed: () {
                              displayDialog(
                                  context, itemProvider, index, true);
                            },
                            color: Colors.lightBlue,
                            icon: const Icon(Icons.edit)),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }

  displayDialog(BuildContext context, ItemProvider itemProvider, int index,
      bool isEdit) async {
    final formKey = GlobalKey<FormBuilderState>();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(isEdit ? 'Edit Item' : 'Add Item'),
            content: FormBuilder(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FormBuilderTextField(
                    name: "Name",
                    initialValue: itemProvider.itemList.isNotEmpty && isEdit
                        ? itemProvider.itemList[index].name
                        : "",
                    decoration: const InputDecoration(labelText: "Name"),
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required()]),
                  ),
                  const Padding(padding: EdgeInsets.all(10.0)),
                  FormBuilderTextField(
                    name: "Description",
                    maxLines: 3,
                    initialValue: itemProvider.itemList.isNotEmpty && isEdit
                        ? itemProvider.itemList[index].description
                        : "",
                    decoration: const InputDecoration(labelText: "Description"),
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required()]),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(isEdit ? 'Update' : 'Add'),
                onPressed: () {
                  if (formKey.currentState?.saveAndValidate() ?? false) {
                    String? name =
                        formKey.currentState?.fields["Name"]?.value.toString();
                    String? description = formKey
                        .currentState?.fields["Description"]?.value
                        .toString();
                    Item item = Item(name!, description!);
                    if (isEdit) {
                      itemProvider.editItem(item, index);
                    } else {
                      itemProvider.addItem(item, index);
                    }
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Data added successfully"),
                    ));
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          );
        });
  }

  _calculateDisplayDialog(Calculate calculate,BuildContext context) async {
    final formKey = GlobalKey<FormBuilderState>();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Calculate"),
            content: FormBuilder(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Widget Height=>   ${calculate.size?.height}"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Widget Width=>   ${calculate.size?.width}"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Widget Position X Axis=>   ${calculate.position?.dx}"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Widget Position Y Axis=>   ${calculate.position?.dy}"),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                  child: const Text("Close"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
            ],
          );
        });
  }

