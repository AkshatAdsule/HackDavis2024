import 'package:app/screens/add_items.dart';
import 'package:app/services/api.dart';
import 'package:app/util/item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FreedgeItemsScreen extends StatefulWidget {
  final String name;
  final int freedgeNumber;
  const FreedgeItemsScreen(
      {super.key, required this.freedgeNumber, required this.name});

  @override
  State<FreedgeItemsScreen> createState() => _FreedgeItemsScreenState();
}

class _FreedgeItemsScreenState extends State<FreedgeItemsScreen> {
  @override
  void initState() {
    super.initState();
    _initItems();
  }

  List<Item>? _items;

  void _initItems() async {
    setState(() {
      _items = null;
    });
    APIService.instance.getFreedgeItems(widget.freedgeNumber).then((value) {
      setState(() {
        _items = value;
      });
    });
  }

  @override
  void didChangeDependencies() {
    _initItems();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Center(
        child: _items == null
            ? const CircularProgressIndicator()
            : ListView.builder(
                itemCount: _items!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_items![index].name),
                    subtitle: Text((_items![index]).owner!["name"]),
                    leading: SizedBox(
                      height: 50,
                      width: 50,
                      child: _items![index].image != null &&
                              _items![index].image != "NO_IMAGE_PROVIDED"
                          ? Image.network(_items![index].image!)
                          : const Icon(Icons.food_bank),
                    ),
                  );
                },
              ),

        // child: FutureBuilder<List<Item>>(
        //   future: APIService.instance.getFreedgeItems(widget.freedgeNumber),
        //   builder: (context, snapshot) {
        //     print(snapshot);
        //     if (snapshot.connectionState == ConnectionState.done) {
        //       if (snapshot.hasError) {
        //         return const Text("Error");
        //       }
        //       if (snapshot.hasData) {
        //         return ListView.builder(
        //           itemCount: snapshot.data!.length,
        //           itemBuilder: (context, index) {
        //             return ListTile(
        //               title: Text(snapshot.data![index].name),
        //               subtitle: Text((snapshot.data![index]).owner!["name"]),
        //               leading: SizedBox(
        //                 height: 50,
        //                 width: 50,
        //                 child: snapshot.data![index].image != null &&
        //                         snapshot.data![index].image !=
        //                             "NO_IMAGE_PROVIDED"
        //                     ? Image.network(snapshot.data![index].image!)
        //                     : const Icon(Icons.food_bank),
        //               ),
        //             );
        //           },
        //         );
        //       }
        //     }
        //     return const CircularProgressIndicator();
        //   },
        // ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (FirebaseAuth.instance.currentUser == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content:
                    Text("You must be logged in to add items to a Freedge"),
              ),
            );
            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddItemsScreen(
                freedgeNumber: widget.freedgeNumber,
                name: widget.name,
              ),
            ),
          ).then((_) {
            _initItems();
          });
        },
        label: Text("Add Items to Freedge"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
