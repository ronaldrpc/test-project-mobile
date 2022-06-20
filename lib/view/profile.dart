import 'package:flutter/material.dart';


class ProfileView extends StatefulWidget {
  final Map<String, dynamic> data;
  const ProfileView({Key? key, required this.data}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  // Map<String, dynamic> data = {
  //   "nombre": 'Admin',
  //   "apellido": "istrador",
  //   "correo": "admin@admin.com",
  //   "contacto": 12345,
  // };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perfil de usuario', 
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500)
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(25),
        children: [
          const CircleAvatar(
            backgroundColor: Colors.black,
            radius: 100,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                "https://m.media-amazon.com/images/I/41bzx00f+NL._AC_SX355_.jpg"
              ),
              radius: 99,
            ),
          ),
          const SizedBox(height: 15),
          _info(const Icon(Icons.person), "Nombre", "Alatus Nemesos"),
          _info(const Icon(Icons.info_outline_rounded), "Acerca de", "Last guardian yaksha"),
          _info(const Icon(Icons.phone), "Contacto", "+0 123 456 789"),
        ],
      ),
    );
  }

  Widget _info(icon, title, info) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10, right: 20),
                child: icon,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title),
                  Text(info, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
                ]
              )
            ]
          ),
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: const Icon(Icons.edit),
          )
        ],
      ),
    );
  }
}



            // const SizedBox(height: 16),
            // FormTextField(field: "nombre", data: widget.data, setState: setState),
            // const SizedBox(height: 16),
            // FormTextField(field: "apellido", data: widget.data, setState: setState),
            // const SizedBox(height: 16),
            // FormTextField(field: "correo", data: widget.data, setState: setState),
            // const SizedBox(height: 16),
            // FormNumberField(field: "contacto", data: widget.data, setState: setState),