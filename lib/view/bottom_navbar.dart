import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/record.dart';
import 'package:flutter_application_1/view/profile.dart';
import 'package:flutter_application_1/view/records/record_list_view.dart';
import 'package:flutter_application_1/view/records/record_multi_form.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  Map<String, dynamic> data = {
    "nombre": 'Admin',
    "apellido": "istrador",
    "correo": "admin@admin.com",
    "contacto": 12345,
  };

  Widget _body() {
    // final screens = [
    //   RecordForm(action: "Crear", record: Record()),
    //   const RecordListView(),
    //   RecordMultiForm(record: Record(), goToListView: goToList),
    // ];
    // return screens[_selectedIndex];
    switch (_selectedIndex) {
      case 0:
        return const Text('Home', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold));
      case 1:
        return const RecordListView();
      case 2:
        return RecordMultiForm(record: Record(), goToListView: goToList);
      case 3:
        return ProfileView(data: data);
      default:
        return const Text("Home", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _body(),
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: Colors.blue.shade100,
            labelTextStyle: MaterialStateProperty.all(
              const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          child: NavigationBar(
            height: 70,
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onTapped,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.stream),
                label: 'Home'
              ),
              NavigationDestination(
                icon: Icon(Icons.list_alt_outlined),
                selectedIcon: Icon(Icons.list_alt),
                label: 'Lista'
              ),
              NavigationDestination(
                icon: Icon(Icons.edit),
                label: 'Crea'
              ),
              NavigationDestination(
                icon: Icon(Icons.person),
                label: 'Perfil'
              ),
            ],
          )
        ),
    );
  }

  void _onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void goToList() {
    setState(() => _selectedIndex = 0);
  }
}



