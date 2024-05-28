import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/icons_list.dart';


class CategoryDropDown extends StatelessWidget {
  CategoryDropDown({super.key, this.cattype, required this.onChanged});

  final String? cattype;
  final ValueChanged<String?> onChanged;

  var appIcon=AppIcons();
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: cattype,
        isExpanded: true,
        hint: Text("Select Category"),
        items: appIcon.homeExpensesCategories
        .map((e) => DropdownMenuItem<String>(
            value: e['name'],

            child: Row(
              children: [
                Icon(e['icon'],color: Colors.black45,),
                SizedBox(
                  width: 15,
                ),
                Text(e['name'],style: TextStyle(color: Colors.black45),),
              ],
            ))).toList(),
        onChanged: onChanged);
  }
}
