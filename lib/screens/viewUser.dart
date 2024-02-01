import 'package:crud_sqlite_sqflite/model/User.dart';
import 'package:flutter/material.dart';

class ViewUser extends StatefulWidget {
  late final User user;
  ViewUser({super.key, required this.user});

  @override
  State<ViewUser> createState() => _ViewUserState();
}

class _ViewUserState extends State<ViewUser> {
  @override
  Widget build(BuildContext context) {
    String id = widget.user.id?.toString() ?? 'null';
    return Scaffold(
      appBar: AppBar(title: const Text('User details')),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        width: double.infinity,
        height: double.infinity,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                // mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("User Id $id"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text('Name'),
                      Text(widget.user.name ?? 'null')
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text('Contact'),
                      Text(widget.user.contact ?? 'null')
                    ],
                  ),
                ],
              ),
              const Text('Discription'),
              Text(widget.user.description ?? 'null'),
            ]),
      ),
    );
  }
}
