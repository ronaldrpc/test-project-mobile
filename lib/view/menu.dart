import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/record.dart';
import 'package:flutter_application_1/view/profile.dart';
import 'package:flutter_application_1/view/records/record_list_view.dart';
import 'package:flutter_application_1/view/records/record_multi_form.dart';


class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int _selectedIndex = 0;
  Map<String, dynamic> data = {
    "nombre": 'Admin',
    "apellido": "istrador",
    "correo": "admin@admin.com",
    "contacto": 12345,
  };


  Widget _home() {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home', 
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500)
        ),
      ),
      body: const Center(
        child: Text(
          'Welcome!', 
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
        )
      )
    );
  }

  Widget _body() {
    switch (_selectedIndex) {
      case 0:
        return _home();
      case 1:
        return const RecordListView();
      case 2:
        return RecordMultiForm(record: Record(), goToListView: goToList);
      case 3:
        return ProfileView(data: data);
      default:
        return _home();
    }
  }

  void  _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  void goToList() {
    setState(() => _selectedIndex = 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.blue[800],
      //   title: const Text('App Bar')
      // ),
      body: Center(
        child: _body(), // _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue[800],
        unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Lista',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Crea',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}