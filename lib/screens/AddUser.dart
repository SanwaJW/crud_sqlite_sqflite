import 'package:crud_sqlite_sqflite/model/User.dart';
import 'package:crud_sqlite_sqflite/services/userService.dart';
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final _userNameController = TextEditingController();
  final _userContactController = TextEditingController();
  final _userDescriptionController = TextEditingController();

  bool _validateName = false;
  bool _validateContact = false;
  bool _validateDescription = false;

  late UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('add'),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: 400,
            color: Colors.black26,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Add New Details',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                TextField(
                  controller: _userNameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Name',
                    labelText: 'Name',
                    errorText:
                        _validateName ? 'Name Value Can\'t Be Empty' : null,
                  ),
                ),
                TextField(
                  controller: _userContactController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Contact',
                    labelText: 'Contact',
                    errorText: _validateContact
                        ? 'Contact Value Can\'t Be Empty'
                        : null,
                  ),
                ),
                TextField(
                  controller: _userDescriptionController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Description',
                    labelText: 'Description',
                    errorText: _validateDescription
                        ? 'Description Value Can\'t Be Empty'
                        : null,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            _userNameController.text.isEmpty
                                ? _validateName = true
                                : _validateName = false;
                            _userContactController.text.isEmpty
                                ? _validateContact = true
                                : _validateContact = false;
                            _userDescriptionController.text.isEmpty
                                ? _validateDescription = true
                                : _validateDescription = false;
                          });
                          if (_validateName == false &&
                              _validateContact == false &&
                              _validateDescription == false) {
                            // print("Good Data Can Save");
                            User _user = User();
                            _user.name = _userNameController.text;
                            _user.contact = _userContactController.text;
                            _user.description = _userDescriptionController.text;
                            var result = await _userService.saveUser(_user);
                            print(result);
                            Navigator.pop(context, result);
                          }
                        },
                        child: const Text('Save Details')),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color?>(
                                Colors.red[300])),
                        onPressed: () {
                          _userNameController.clear();
                          _userContactController.clear();
                          _userDescriptionController.clear();
                        },
                        child: const Text('Clear Details')),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
