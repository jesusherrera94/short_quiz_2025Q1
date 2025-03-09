import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoScreen(),
    );
  }
}

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _todoController = TextEditingController();
  String? _selectedCategory;
  String? _userName;
  String? _todoItem;
  String _message = '';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    // TODO: implemente la carga del nombre de usuario de las shared_preferences.
  }

  Future<void> _saveUserName(String name) async {
    // TODO: implemente el guardado del nombre de usuario en las shared_preferences.
  }

  Future<void> _addTodo() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        print('Sending to-do: $_todoItem to $_selectedCategory for $_userName');
        // TODO: implemente el llamado a _sendTodo aqui, hint:.

        setState(() {
          _message = 'Item sent successfully';
        });
      } catch (e) {
        print('Error: $e');
        setState(() {
          _message = 'Error occurred while sending to-do';
        });
      }
    }
  }


  Future<dynamic> _sendTodo({
    required String name,
    required String todo,
    required String category,
  }) async  {
    // TODO: implemente el llamado a dio aqui.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('To-Do List')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Your Name'),
                // TODO: implemente validacion usando validator y guardado del nombre de usuario usando onChanged.
                
              ),
              TextFormField(
                controller: _todoController,
                decoration: const InputDecoration(labelText: 'To-Do Item'),
                // TODO: implemente validacion usando validator y guardado del to-do item usando onChanged.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a to-do item';
                  }
                  return null;
                },
                onChanged: (value) => setState(() {
                  _todoItem = value;
                }),
              ),

                 DropdownSearch<String>(
                mode: Mode.form,
                    items: (f, cs) => ['Work', 'Personal', 'Shopping', 'Study'],
                    onChanged: (String? value) =>
                        _selectedCategory = value,
                    selectedItem: _selectedCategory,
                    popupProps: const PopupProps.menu(
                      title: Text('Select your principal interest'),
                      showSelectedItems: true,
                      showSearchBox: true
                    ),
                  ),
              ElevatedButton(
                onPressed: _addTodo,
                child: const Text('Add To-Do'),
              ),
              const SizedBox(height: 16),
              // TODO: implemente la visualizacion del mensaje de estado.
            ],
          ),
        ),
      ),
    );
  }
}