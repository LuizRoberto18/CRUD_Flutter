//controlar a lista de usuarios, CRUD
import 'dart:math';

import 'package:crud_sistema/data/dummy_users.dart';
import 'package:crud_sistema/models/user.dart';
import 'package:flutter/cupertino.dart';

class UsersController with ChangeNotifier {
  Map<String, User> _items = {...DUMMY_USERS};

  //mostrar todos os usuarios criados
  List<User> get all {
    return [..._items.values];
  }

  //mostra a lista de usuarios
  int get count {
    return _items.length;
  }

  //criar um compomente para mostrar os valores em um elemento
  User byIndex(int i) {
    return _items.values.elementAt(i);
  }

  //criando um usuario
  void put(User user) {
    if (user == null) {
      return;
    }
    //update
    if (user.id != null &&
        user.id.trim().isNotEmpty &&
        _items.containsKey(user.id)) {
      _items.update(
        user.id,
        (value) => User(
          id: user.id,
          name: user.name,
          email: user.email,
          avatarUrl: user.avatarUrl,
        ),
      );
    } else {
      // add
      final id = Random().nextDouble().toString();
      _items.putIfAbsent(
        id,
        () => User(
          id: id,
          name: user.name,
          email: user.email,
          avatarUrl: user.avatarUrl,
        ),
      );
    }
    //notificar o provider para ele atualizar a tela e inserir o novo usuario
    notifyListeners();
  }

  //delete
  void remove(User user) {
    if (User != null && user.id != null) {
      _items.remove(user.id);
      notifyListeners();
    }
  }
}
