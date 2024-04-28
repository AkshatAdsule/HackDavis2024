import 'package:app/util/food_data.dart';
import 'package:app/widgets/add_item_modal.dart';
import 'package:flutter/material.dart';
import 'package:qr_mobile_vision/qr_camera.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<FoodData> _items = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            "Add Items to Freedge",
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: _items.length > 0
                ? ListView.builder(
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_items[index].name),
                        leading: SizedBox(
                            height: 50,
                            width: 50,
                            child: _items[index].image != null
                                ? Image.network(
                                    _items[index].image!,
                                  )
                                : const Icon(Icons.food_bank)),
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
                            Text(_items[index].quantity.toString()),
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
                onPressed: () {},
                child: Text("Submit Items"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
