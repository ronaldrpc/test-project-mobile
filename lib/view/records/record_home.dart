import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/record.dart';
import 'package:flutter_application_1/view/records/record_form.dart';
import 'package:flutter_application_1/view/records/record_list_view.dart';

class RecordHome extends StatefulWidget {
  const RecordHome({Key? key}) : super(key: key);

  @override
  State<RecordHome> createState() => _RecordHomeState();
}

class _RecordHomeState extends State<RecordHome> {
  int _selectedIndex = 0;
  final screens = [
    const RecordListView(),
    RecordForm(action: "Crear", record: Record()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('Registros'),
        // ),
        body: screens[_selectedIndex],
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: Colors.blue.shade100,
            labelTextStyle: MaterialStateProperty.all(
              const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          child: NavigationBar(
            height: 60,
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onTapped,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.list_alt_outlined),
                selectedIcon: Icon(Icons.list_alt),
                label: 'Lista'
              ),
              NavigationDestination(
                icon: Icon(Icons.edit),
                label: 'Crea'
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
}



// BottomNavigationBar(
//           // type: BottomNavigationBarType.shifting,
//           backgroundColor: Colors.blue,
//           selectedItemColor: Colors.white,
//           unselectedItemColor: Colors.black54,
//           currentIndex: _selectedIndex,
//           iconSize: 30,
//           selectedFontSize: 16,
//           unselectedFontSize: 14,
//           items: const [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.list_alt), //format_list_bulleted
//               label: 'Lista',
//               backgroundColor: Colors.blue
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.edit), // app_registration
//               label: 'Crea',
//               backgroundColor: Colors.red
//             ),
//           ],
//           onTap: _onTapped,
//         )

