import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/firebase_connection.dart';
import 'package:flutter_application_1/entities/record.dart';
import 'package:flutter_application_1/view/forms/form_check_field.dart';
import 'package:flutter_application_1/view/forms/form_text_field.dart';
import 'package:flutter_application_1/view/forms/forms_number_field.dart';


// ignore: must_be_immutable
class RecordMultiForm extends StatefulWidget {
  final Record record;
  Function goToListView;

  RecordMultiForm({Key? key, required this.record, required this.goToListView}) : super(key: key);

  @override
  State<RecordMultiForm> createState() => _RecordMultiFormState();
}

class _RecordMultiFormState extends State<RecordMultiForm> {
  late Map<String, dynamic> data = widget.record.toJson();
  int _selectedStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registro', 
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500)),
      ),
      body: Stepper(
        type: StepperType.horizontal,
        steps: getSteps(),
        currentStep: _selectedStep,
        onStepTapped: (step) => setState(() => _selectedStep = step),
        onStepContinue: continueStep,
        onStepCancel: cancelStep,
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          final lastStep = (_selectedStep == getSteps().length - 1);
          return Container(
            margin: const EdgeInsets.only(top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    onPrimary: Theme.of(context).colorScheme.onSecondaryContainer,
                    primary: Theme.of(context).colorScheme.secondaryContainer,
                  ),
                  onPressed: details.onStepCancel,
                  child: const Text('Cancelar', style: TextStyle(fontSize: 20)),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    onPrimary: Theme.of(context).colorScheme.onPrimary,
                    primary: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: details.onStepContinue,
                  child: Text(
                    (lastStep) ? 'Enviar' : 'Siguiente', 
                    style: const TextStyle(fontSize: 20)
                  ),
                ),
              ]
            ),
          );
        },
      ),
    );
  }

  List<Step> getSteps() {
    return [
      Step(
        // state: _selectedStep > 0 ? StepState.complete : StepState.indexed,
        isActive: _selectedStep >= 0,
        title: const Text('Usuario'),
        content: Container(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              FormTextField(field: "nombre", data: data, setState: setState),
              const SizedBox(height: 16),
              FormTextField(field: "apellido", data: data, setState: setState),
              const SizedBox(height: 16),
              FormNumberField(field: "cell", data: data, setState: setState),
              const SizedBox(height: 16),
              FormTextField(field: "licencia", data: data, setState: setState),
            ],
          ),
        ),
      ),
      Step(
        // state: _selectedStep > 1 ? StepState.complete : StepState.indexed,
        isActive: _selectedStep >= 1,
        title: const Text('Carro'),
        content: Container(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              FormTextField(field: "Color", data: data['Carro'], setState: setState),
              const SizedBox(height: 16),           
              FormTextField(field: "marca", data: data['Carro'], setState: setState),
              const SizedBox(height: 16),           
              FormNumberField(field: "modelo", data: data['Carro'], setState: setState),
              const SizedBox(height: 16),           
              FormTextField(field: "placa", data: data['Carro'], setState: setState),
            ],
          )
        ),
      ),
      Step(
        // state: _selectedStep > 2 ? StepState.complete : StepState.indexed,
        isActive: _selectedStep >= 2,
        title: const Text('Servicio'),
        content: Container(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              FormCheckField(field: "lavado", data: data['Servicio'], setState: setState),
              const SizedBox(height: 16),
              FormCheckField(field: "polish", data: data['Servicio'], setState: setState),
              const SizedBox(height: 16),
              FormCheckField(field: "tapiceria", data: data['Servicio'], setState: setState),
            ],
          )
        ),
      ),
    ];
  }


  void continueStep() {
    final lastStep = (_selectedStep == getSteps().length - 1);
    if (lastStep) {
      saveRecord();
      showSnackBar();
      widget.goToListView();
    }
    else {
      setState(() {
        _selectedStep = _selectedStep + 1;
      });
    }
  }

  void cancelStep() {
    if (_selectedStep != 0) {
      setState(() {
        _selectedStep = _selectedStep - 1;
      });
    }
  }

  void saveRecord() async {
    final con = FirebaseConnection();
    final id = (widget.record.id != null) ? widget.record.id : "123";
    await con.writeRecord(data, id!);
  }

  void showSnackBar() {
    const message = "El registro se guardó de forma exitosa";
    const snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(fontSize: 18),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}