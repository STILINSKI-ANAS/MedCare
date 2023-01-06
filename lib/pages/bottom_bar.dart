import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:medcare/pages/pharmacie2.dart';
import '../router/routes.dart';
import 'doctorpage.dart';
import 'formpage.dart';
import 'homepage/index.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex=0;
  static final List<Widget> _widgetOptions =<Widget>[
    HomePage(),
    FormPage(),
    PharmacyPage(),
    DoctorPage(),
  ];

  void _onItempressed(int index)async {
    switch (index){
      case 0:
        setState(() {
          _selectedIndex=index;
        });
        break;
      case 1:
        await Navigator.of(context).pushNamed(RouteManager.formPage);
        break;
      case 2:
         setState(() {
          _selectedIndex=index;
        });
        break;
      case 3:
         setState(() {
          _selectedIndex=index;
        });
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItempressed,
        elevation: 10,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.blueGrey,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: const Color(0xff526480),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(FluentSystemIcons.ic_fluent_home_regular,color:Color(
                  0xBE9A9A9A)),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_home_filled,color:Color(0xFF32A060)),
              label: "home"),
          BottomNavigationBarItem(
              icon: Icon(FluentSystemIcons.ic_fluent_add_circle_regular,color:Color(0xBE9A9A9A)),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_add_circle_filled,color:Color(0xFF32A060)),
              label: "Add Med"),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_pharmacy,color:Color(0xBE9A9A9A)),
              activeIcon: Icon(Icons.local_pharmacy,color:Color(0xFF32A060)),
              label: "Pharmacie"),
          BottomNavigationBarItem(
              icon: Icon(Icons.medical_services_rounded,color:Color(0xBE9A9A9A)),
              activeIcon: Icon(Icons.medical_services_rounded,color:Color(0xFF32A060)),
              label: "Docteur"),
        ],
      ),
    );
  }

}
