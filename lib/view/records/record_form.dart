import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/firebase_connection.dart';
import 'package:flutter_application_1/entities/record.dart';
import 'package:flutter_application_1/view/forms/form_check_field.dart';
import 'package:flutter_application_1/view/forms/form_text_field.dart';
import 'package:flutter_application_1/view/forms/forms_number_field.dart';


class RecordForm extends StatefulWidget {
  final String action;
  final Record record;
  final String id;

  const RecordForm({Key? key, required this.action, required this.record, required this.id}) : super(key: key);

  @override
  State<RecordForm> createState() => _RecordFormState();
}

class _RecordFormState extends State<RecordForm> {
  final formKey = GlobalKey<FormState>();
  Map<String, dynamic> data = {};
  bool _editable = false;
  bool _loaded = false;

  Future<void> getRecordsFromFirebase() async {
    final connection = FirebaseConnection();
    final recordList = await connection.getRecordByPath(widget.id);
    if (mounted && !_loaded) {
      setState(() {
        data = recordList.records![0].toJson();
      });
      _loaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    getRecordsFromFirebase();

    if (data.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            '${_editable ? widget.action : 'Ver'} registro',
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w500)
          ),
        ),
        body: const Center(
          child: Text("Cargando...", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold))
        )
      );
    }
    else {
      return _form(data);
    }
  }

  Widget _form(data) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${_editable ? widget.action : 'Ver'} registro',
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w500)
        ),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            CircleAvatar(
              radius: 70,
              child: ClipOval(
                child: Image.network(
                  data['image'],
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text("Editable", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                Switch.adaptive(
                  value: _editable,
                  onChanged: (value) => setState(() => _editable = value)
                )
              ],
            ),
            const SizedBox(height: 10),
            const Text("Usuario", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            FormTextField(field: "nombre", data: data, setState: setState, editable: _editable),
            const SizedBox(height: 16),
            FormTextField(field: "apellido", data: data, setState: setState, editable: _editable),
            const SizedBox(height: 16),
            FormNumberField(field: "cel", data: data, setState: setState, editable: _editable),
            const SizedBox(height: 16),
            FormTextField(field: "licencia", data: data, setState: setState, editable: _editable),

            const SizedBox(height: 25),
            const Text("Carro", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            FormTextField(field: "Color", data: data['Carro'], setState: setState, editable: _editable),
            const SizedBox(height: 16),           
            FormTextField(field: "marca", data: data['Carro'], setState: setState, editable: _editable),
            const SizedBox(height: 16),           
            FormNumberField(field: "modelo", data: data['Carro'], setState: setState, editable: _editable),
            const SizedBox(height: 16),           
            FormTextField(field: "placa", data: data['Carro'], setState: setState, editable: _editable),

            const SizedBox(height: 25),
            const Text("Servicio", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            FormCheckField(field: "lavado", data: data['Servicio'], setState: setState, editable: _editable),
            const SizedBox(height: 16),
            FormCheckField(field: "polish", data: data['Servicio'], setState: setState, editable: _editable),
            const SizedBox(height: 16),
            FormCheckField(field: "tapiceria", data: data['Servicio'], setState: setState, editable: _editable),

            const SizedBox(height: 20),
            formSubmit(),
            const SizedBox(height: 20),
          ],
        ),
      )
    );
  }

  Widget formSubmit() {
    return OverflowBar(
      alignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            onPrimary: Theme.of(context).colorScheme.onPrimary,
            primary: Theme.of(context).colorScheme.primary,
          ),
          onPressed: !_editable ? null : () {
            final isValid = formKey.currentState!.validate();
            if (isValid) {
              formKey.currentState?.save();
              const message = "El registro se guardó de forma exitosa";
              const snackBar = SnackBar(
                content: Text(
                  message,
                ),
              );

              saveRecord();
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Navigator.pop(context);
            }
          },
          child: const Text('Guardar cambios', style: TextStyle(fontSize: 20)),
        ),
      ],
    );
  }

  void saveRecord() async {
    final con = FirebaseConnection();
    await con.writeRecord(data, data['id']);
  }
  
}

