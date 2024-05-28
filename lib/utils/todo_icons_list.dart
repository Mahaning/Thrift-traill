import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ToDoListAppIcons {
  final List<Map<String,dynamic>> homeExpensesCategories = [
    {
      "name" : "Learning",
      "icon" : FontAwesomeIcons.graduationCap,
      "id": "Ler001",
    },
    {
      "name" : "Genral",
      "icon" : FontAwesomeIcons.tasks,
    },
    {
      "name" : "Work",
      "icon" : FontAwesomeIcons.briefcase,
    },
    {
      "name" : "Helth",
      "icon" : FontAwesomeIcons.dumbbell,
    },
    {
      "name" : "Relationship",
      "icon" : FontAwesomeIcons.handHoldingHeart,
    },
    {
      "name" : "Travel",
      "icon" : FontAwesomeIcons.plane,
    },
    {
      "name" : "Food",
      "icon" : FontAwesomeIcons.utensils,
    },
    {
      "name" : "Phone Call",
      "icon" : FontAwesomeIcons.phone,
    },
    {
      "name" : "Meeting",
      "icon" : FontAwesomeIcons.peopleGroup,
    },

  ];

  IconData getexpenseCategoryIcons(String taskcategoryName){
    final taskcategory = homeExpensesCategories.firstWhere(
            (taskcategory) => taskcategory['name'] == taskcategoryName,
        orElse: () => {"icon": FontAwesomeIcons.questionCircle} // return a default icon when the category is not found
    );
    return taskcategory['icon'];
  }
}
