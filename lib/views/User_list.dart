import 'package:crud_sistema/components/user_tile.dart';
import 'package:crud_sistema/models/user.dart';
import 'package:crud_sistema/provider/users.dart';
import 'package:crud_sistema/routes/app_routes.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UsersController users = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Usúarios"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.USER_FORM);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: 20,
          left: 15,
          right: 5,
        ),
        child: ListView.builder(
          //exibir a quantidade da lista
          itemCount: users.count,
          //cria um componente que sera um texto mostrando os valores dos atributos da calss usuario
          itemBuilder: (ctx, i) => UserTile(users.byIndex(i)),
        ),
      ),
    );
  }
}
