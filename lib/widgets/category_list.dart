import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../utils/icons_list.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({Key? key, required this.onChanged}) : super(key: key);
  final ValueChanged<String?> onChanged;

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  String currentCategory = "";
  List<Map<String, dynamic>> categorylist = [];
  final scrollController = ScrollController(); // Corrected spelling
  var appIcon = AppIcons();

  @override
  void initState() {
    super.initState();
    setState(() {
      categorylist = appIcon.homeExpensesCategories;
      categorylist.insert(0, addCat);
    });
  }

  var addCat = {
    "name": "All",
    "icon": FontAwesomeIcons.cartPlus,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,

      child: ListView.builder(
        controller: scrollController, // Set the scrollController here
        itemCount: categorylist.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var data = categorylist[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                currentCategory = data['name'];
                widget.onChanged(data['name']);
              });
            },
            child: IntrinsicWidth(
              child: Container(
                // width: 150,
                margin: EdgeInsets.all(4),
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  color: currentCategory == data['name'] ? Colors.blue.shade900 : Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),

                ),
                child: Container(

                  child: Center(

                    child: Row(
                      children: [
                        Icon(
                          data['icon'],
                          size: 15,
                          color: currentCategory == data['name'] ? Colors.white : Colors.blue.shade900,
                        ),
                        SizedBox(width: 10),
                        Text(
                          data['name'],
                          style: TextStyle(
                            color: currentCategory == data['name'] ? Colors.white : Colors.blue.shade900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
