import 'package:flutter/material.dart';
import 'package:hrdmagenta/services/bloc.dart';

class Create extends StatefulWidget {
  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              onChanged: bloc.updateTitle,
              maxLines: 4,
              decoration: InputDecoration(hintText: 'Add what you want do'),
            ),
            RaisedButton(
              onPressed: () async {
                bloc.addSaveTodo();
                await new Future.delayed(const Duration(milliseconds: 500));
                bloc.fetchAllTodo();
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            )
          ],
        ),
      ),
    );
  }
}
