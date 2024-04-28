import 'package:app/screens/freedge_items.dart';
import 'package:app/screens/wait.dart';
import 'package:app/services/api.dart';
import 'package:app/util/food_data.dart';
import 'package:app/widgets/add_item_modal.dart';
import 'package:flutter/material.dart';

class AddItemsScreen extends StatefulWidget {
  final int freedgeNumber;
  final String name;

  const AddItemsScreen(
      {super.key, required this.freedgeNumber, required this.name});

  @override
  State<AddItemsScreen> createState() => _AddItemsScreenState();
}

class _AddItemsScreenState extends State<AddItemsScreen> {
  List<FoodData> _items = [];
  bool isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Items to Freedge"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: _items.length > 0 && !isSubmitting
                  ? ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                              "${_items[index].name} ${_items[index].score * _items[index].quantity}"),
                          leading: SizedBox(
                            height: 50,
                            width: 50,
                            child: _items[index].image != null
                                ? Image.network(
                                    _items[index].image!,
                                  )
                                : const Icon(Icons.food_bank),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    _items[index].quantity++;
                                  });
                                },
                                icon: const Icon(Icons.add),
                              ),
                              Text("${_items[index].quantity}"),
                              IconButton(
                                onPressed: () {
                                  if (_items[index].quantity == 1) {
                                    setState(() {
                                      _items.removeAt(index);
                                    });
                                    return;
                                  }
                                  setState(() {
                                    _items[index].quantity--;
                                  });
                                },
                                icon: const Icon(Icons.remove),
                              ),
                            ],
                          ),
                        );
                      })
                  : const Center(child: Text("No items added yet!")),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    FoodData? val = await showModalBottomSheet<FoodData>(
                      isDismissible: false,
                      showDragHandle: true,
                      context: context,
                      builder: (context) => const AddItemModal(),
                    );
                    if (val != null) {
                      setState(() {
                        _items.add(val);
                      });
                    }
                  },
                  child: Text("Add Item"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isSubmitting = true;
                    });

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WaitScreen(
                          future: APIService.instance
                              .addItems(widget.freedgeNumber, _items),
                          onSuccess: (_) => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FreedgeItemsScreen(
                                freedgeNumber: widget.freedgeNumber,
                                name: widget.name,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: Text("Submit Items"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
