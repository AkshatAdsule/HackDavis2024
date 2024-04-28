import 'package:app/services/api.dart';
import 'package:app/util/user.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/circle_image_picker.dart';

class LeaderBoardScreen extends StatefulWidget {
  const LeaderBoardScreen({super.key});

  @override
  State<LeaderBoardScreen> createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
  Widget build(BuildContext context) {
    return MyListView();
  }
}

class MyListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>>(
        future: APIService.instance.getLeaderBoard(),
        builder: (context, snapshop) {
          if (snapshop.connectionState == ConnectionState.done) {
            if (snapshop.hasError) {
              return const Text("Error");
            }
            if (snapshop.hasData) {
              return ListView.builder(
                itemCount: snapshop.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        leading: CircleImagePicker(
                          onSelect: (s) {},
                          initialImage:
                              NetworkImage(snapshop.data![index].profilePhoto),
                        ),
                        title: Text(snapshop.data![index].name),
                        subtitle: Text(snapshop.data![index].points.toString()),
                      ),
                    ),
                  );
                },
              );
            }
          }
          return const CircularProgressIndicator();
        });
    // return ListView.builder(
    //   itemCount: items.length * 10,
    //   itemBuilder: (context, index) {
    //     return Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: Card(
    //         child: ListTile(
    //           leading: CircleImagePicker(
    //             onSelect: (s) {},
    //             initialImage: NetworkImage(items[index % 3]['Image']),
    //           ),
    //           title: Text(items[index % 3]['Name']),
    //           subtitle: Text(items[index % 3]['Points']),
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}
