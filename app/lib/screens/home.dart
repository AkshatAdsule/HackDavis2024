import 'package:app/screens/freedge_items.dart';
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
      'title': 'Freedge at Memorial Union',
      'image': 'http://192.168.185.239:3000/freedge/1/image',
    },
    {
      'title': 'Freedge at Silo',
      'image': 'http://192.168.185.239:3000/freedge/2/image',
    },
    {
      'title': 'Freedge at Walker Hall',
      'image': 'http://192.168.185.239:3000/freedge/3/image',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FreedgeItemsScreen(
                    freedgeNumber: index + 1, name: items[index]['title']),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 1,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        items[index]['image'],
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      items[index]['title'],
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
