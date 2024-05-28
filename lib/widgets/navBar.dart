import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key, required this.selectedIndex, required this.onDestinationSelected});

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade600,
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: NavigationBar(
          onDestinationSelected:onDestinationSelected,
          indicatorColor: Colors.deepPurpleAccent,
          selectedIndex: selectedIndex,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home,color: Colors.white,),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.explore),
                selectedIcon:Icon(Icons.explore,color: Colors.white,),
              label: 'Transactions',
            ),
            NavigationDestination(
              icon: Icon(Icons.add),
              selectedIcon:Icon(Icons.add,color: Colors.white,),
              label: 'new Transaction',
            ),
            NavigationDestination(
              icon:  Icon(Icons.list),
              selectedIcon:Icon(Icons.list,color: Colors.white,),
              label: 'To-Do-List ',
            ),
            NavigationDestination(
              icon: Icon(Icons.groups),
              selectedIcon:Icon(Icons.groups,color: Colors.white,),
              label: 'Bill Spit',
            ),



          ],

      ),
    );
  }
}
