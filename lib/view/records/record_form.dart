import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/firebase_connection.dart';
import 'package:flutter_application_1/entities/record.dart';


class RecordForm extends StatefulWidget {
  final String action;
  final Record record;

  const RecordForm({Key? key, required this.action, required this.record}) : super(key: key);

  @override
  State<RecordForm> createState() => _RecordFormState();
}

class _RecordFormState extends State<RecordForm> {
  final formKey = GlobalKey<FormState>();
  late Map<String, dynamic> data = widget.record.toJson();
  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.action} registro', style: const TextStyle(fontSize: 24)),
      ),
      body: Form(
        key: formKey,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            const SizedBox(height: 16),
            formTextField("nombre", data),
            const SizedBox(height: 16),
            formTextField("apellido", data),
            const SizedBox(height: 16),
            formNumberField("cell", data),
            const SizedBox(height: 16),
            formTextField("licencia", data),

            const SizedBox(height: 25),
            const Text("Carro", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            formTextField("Color", data['Carro']),
            const SizedBox(height: 16),           
            formTextField("marca", data['Carro']),
            const SizedBox(height: 16),           
            formNumberField("modelo", data['Carro']),
            const SizedBox(height: 16),           
            formTextField("placa", data['Carro']),

            const SizedBox(height: 25),
            const Text("Servicio", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            formCheckField("lavado", data['Servicio']),
            const SizedBox(height: 16),
            formCheckField("polish", data['Servicio']),
            const SizedBox(height: 16),
            formCheckField("tapiceria", data['Servicio']),

            const SizedBox(height: 20),
            formSubmit(),
          ],
        ),
      ),
    );
  }

  Widget formTextField(field, data) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "${field.toString()[0].toUpperCase()}${field.toString().substring(1).toLowerCase()}",
        border: const OutlineInputBorder(),
      ),
      initialValue: data[field],
      validator: (value) {
        if (value!.length < 2) {
          return "Ingrese al menos 2 caracteres";
        } else {
          return null;
        }
      },
      onChanged: (value) => setState(() => data[field] = value),
    );
  }

  Widget formNumberField(field, data) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "${field.toString()[0].toUpperCase()}${field.toString().substring(1).toLowerCase()}",
        border: const OutlineInputBorder(),
      ),
      initialValue: (data[field] != null) ? data[field].toString() : "",
      validator: (value) {
        if (value!.length < 2) {
          return "Ingrese al menos 2 caracteres";
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.number,
      onChanged: (value) => setState(() => data[field] = int.parse(value)),
    );
  }

  Widget formCheckField(field, data) {
    final isChecked = (data[field] == "si") ? true : false;
    return CheckboxListTile(
      title: Text("${field.toString()[0].toUpperCase()}${field.toString().substring(1).toLowerCase()}"),
      value: isChecked,
      onChanged: (value) => setState(() {
        data[field] = (value!) ? "si" : "no";
      })
    );
  }

  Widget formSubmit() {
    return OverflowBar(
      alignment: MainAxisAlignment.end,
      children: [
        // TextButton(
        //   onPressed: () {},
        //   child: const Text('Cancel'),
        // ),
        TextButton(
          onPressed: () {
            final isValid = formKey.currentState!.validate();
            if (isValid) {
              formKey.currentState?.save();
              const message = "Se guardó el registro de forma exitosa";
              const snackBar = SnackBar(
                content: Text(
                  message,
                  style: TextStyle(fontSize: 20),
                ),
              );

              saveRecord();
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }

  void saveRecord() async {
    final con = FirebaseConnection();
    final id = (widget.record.id != null) ? widget.record.id : "123";
    await con.writeRecord(data, id!);
  }
  
}

// Map<String, dynamic> data2 = {
//     "nombre": "",
//     "apellido": "",
//     "cell": 0,
//     "licencia": "",
//     "Carro": {
//       "Color": "",
//       "marca": 0,
//       "modelo": "",
//       "placa": ""
//     },
//     "Servicio": {
//       "lavado": "no",
//       "polish": "no",
//       "tapiceria": "no",
//     },
//   };