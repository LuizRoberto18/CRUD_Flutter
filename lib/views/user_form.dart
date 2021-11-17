import 'dart:ffi';

import 'package:crud_sistema/models/user.dart';
import 'package:crud_sistema/provider/users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserForm extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  void _loadFormData(User user) {
    if (user != null) {
      _formData['id'] = user.id;
      _formData['name'] = user.name;
      _formData['email'] = user.email;
      _formData['avatarUrl'] = user.avatarUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as User;

    //metodo para pegar os dados preenchidos para atualizar
    _loadFormData(user);
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulario de Usúario"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              final isValid = _form.currentState!.validate();
              if (isValid) {
                _form.currentState!.save();
                Provider.of<UsersController>(context, listen: false).put(
                  User(
                    id: _formData["id"].toString(),
                    name: _formData["name"].toString(),
                    email: _formData["email"].toString(),
                    avatarUrl: _formData["avatarUrl"].toString(),
                  ),
                );
                Navigator.of(context).pop();
              }
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: 20,
          left: 40,
          right: 40,
        ),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _formData['name'],
                decoration: InputDecoration(
                  labelText: 'Nome',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nome Invalido";
                  }
                  return null;
                },
                onSaved: (value) => _formData['name'] = value!,
              ),
              SizedBox(height: 20),
              TextFormField(
                initialValue: _formData['email'],
                decoration: InputDecoration(
                  labelText: 'E-mail',
                ),
                onSaved: (value) => _formData['email'] = value!,
              ),
              SizedBox(height: 20),
              TextFormField(
                initialValue: _formData['avatarUrl'],
                decoration: InputDecoration(
                  labelText: 'URL do Avatar',
                ),
                onSaved: (value) => _formData['avatarUrl'] = value!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
