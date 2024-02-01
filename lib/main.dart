import 'package:crud_sqlite_sqflite/model/User.dart';
import 'package:crud_sqlite_sqflite/screens/AddUser.dart';
import 'package:crud_sqlite_sqflite/screens/editUser.dart';
import 'package:crud_sqlite_sqflite/screens/viewUser.dart';
import 'package:crud_sqlite_sqflite/services/userService.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<User> _listUser;
  final UserService _userService = UserService();

  getAllUserDetails() async {
    _listUser = <User>[];
    var users = await _userService.readAllUsers();
    users.forEach((user) {
      setState(() {
        var userModel = User();
        userModel.id = user['id'];
        userModel.name = user['name'];
        userModel.contact = user['contact'];
        userModel.description = user['description'];
        _listUser.add(userModel);
      });
    });
  }

  @override
  void initState() {
    getAllUserDetails();
    super.initState();
  }

  showSuccessSnackBar(String message) {
    var snackBar = SnackBar(
      content: Text(message),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('SQlite')),
        backgroundColor: const Color.fromARGB(255, 68, 130, 181),
      ),
      body: ListView.builder(
          itemCount: _listUser.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewUser(user: _listUser[index]),
                      ));
                },
                leading: const Icon(Icons.person),
                title: Text(_listUser[index].name ?? ''),
                subtitle: Text(_listUser[index].contact ?? ''),
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditUser(
                                user: _listUser[index],
                              ),
                            )).then((data) {
                          if (data != null) {
                            getAllUserDetails();
                            showSuccessSnackBar('Update User sucssfully');
                          }
                        });
                      },
                      icon: const Icon(Icons.edit)),
                  IconButton(
                      onPressed: () {
                        _deletFormDialoge(context, _listUser[index].id);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),
                ]),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddUser(),
                )).then((data) {
              if (data != null) {
                getAllUserDetails();
                showSuccessSnackBar('User detail add sucssfully');
              }
            });
          },
          child: const Icon(Icons.add)),
    );
  }

  void _deletFormDialoge(BuildContext context, int? id) {
    showDialog(
        context: context,
        builder: (par) {
          return AlertDialog(
            title: const Text('Are you sure to delete'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    _userService.deleteUser(id);
                    Navigator.pop(context);
                    getAllUserDetails();
                  },
                  child: const Text('Delete')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'))
            ],
          );
        });
  }
}
