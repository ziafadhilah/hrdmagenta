import 'dart:async';

import 'package:hrdmagenta/model/example.dart';
import 'package:hrdmagenta/services/api_provider.dart';

class Repository {
  // final title = '';
  final todoApiProvider = TodoApiProvider();

  Future<List<Example>> fetchAllTodo() => todoApiProvider.fetchTodoList();

  Future addSaveTodo(String title) => todoApiProvider.addTodo(title);

  Future updateSaveTodo(String ids) => todoApiProvider.updateTodo(ids);
}
