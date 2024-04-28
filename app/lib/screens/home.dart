import 'package:flutter/material.dart';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MyListView();
  }
}

class MyListView extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    {
      'title': 'Item 1',
      'image': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAA...',
    },
    {
      'title': 'Item 2',
      'image': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAA...',
    },
    {
      'title': 'Item 3',
      'image': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAA...',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(items[index]['title']),
          leading: Image.memory(
            base64Decode(""),
          ),
        );
      },
    );
  }
}
