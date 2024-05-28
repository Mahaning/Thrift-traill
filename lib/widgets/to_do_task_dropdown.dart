import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thrift_till/utils/icons_list.dart';

import '../utils/todo_icons_list.dart';

class TaskCategoryDropDown extends StatelessWidget {
  TaskCategoryDropDown({Key? key, this.cattype, required this.onChanged})
      : super(key: key);

  final String? cattype;
  final ValueChanged<String?> onChanged;

  var toDoListAppIcons = ToDoListAppIcons();

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: cattype,
      isExpanded: true,
      hint: Text("Select Category"),
      items: toDoListAppIcons.homeExpensesCategories
          .map((e) =>
          DropdownMenuItem<String>(
            value: e['name'] ?? '', // Ensure value is not null
            child: Row(
              children: [
                Icon(
                  e['icon'],
                  color: Colors.black45,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  e['name'],
                  style: TextStyle(color: Colors.black45),
                ),
              ],
            ),
          ))
          .toList(),
      onChanged: onChanged,
    );
  }
}