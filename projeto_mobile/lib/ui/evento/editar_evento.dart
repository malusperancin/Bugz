import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:projeto_mobile/models/evento_model.dart';
import 'package:projeto_mobile/models/funcionario_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:projeto_mobile/data/api_services.dart';
import 'package:projeto_mobile/models/lugar_model.dart';
import 'package:projeto_mobile/models/tipo_model.dart';
import 'package:intl/intl.dart';

class EditarEvento extends StatefulWidget {
  EditarEvento(
      {Key key, this.lugares, this.tipos, this.funcionarios, this.evento})
      : super(key: key);

  final Evento evento;
  final List<Lugar> lugares;
  final List<Tipo> tipos;
  final List<Funcionario> funcionarios;

  @override
  _EditarEventoState createState() => _EditarEventoState();
}

class _EditarEventoState extends State<EditarEvento> {
  Evento evento;
  List<Funcionario> convidados = [];
  Funcionario responsavel;

  final _nomeController = TextEditingController();
  final _dataController = TextEditingController();
  final _responsavelController = TextEditingController();

  var dateFormatted = '';

  DateTime selectedDate;

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2022, 12));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        var date =
            "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
        dateFormatted =
            '${picked.toLocal().year}-${picked.toLocal().month}-${picked.toLocal().day}';
        _dataController.text = date;
      });
  }

  editarEvento() {
    evento.nome = _nomeController.text;
    evento.responsavel = responsavel.id.toString();
    evento.data = _dataController.text;
    APIServices.editarEvento(evento).then((response) {});
  }

  @override
  void initState() {
    evento = widget.evento;
    var inputFormat = DateFormat("dd/MM/yyyy");
    var data = inputFormat.parse(evento.data);
    responsavel = widget.funcionarios[0];
    _nomeController.text = evento.nome;
    _dataController.text = evento.data;
    _responsavelController.text = evento.responsavel;

    for (var func in widget.funcionarios)
      for (var conv in evento.participantes)
        if (func.id == conv.id) convidados.add(func);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
          SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.fromLTRB(25, 60, 25, 10),
            child: Form(
                child: Column(children: <Widget>[
              TextFormField(
                  controller: _nomeController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Nome",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  )),
              SizedBox(height: 15),
              TextFormField(
                  controller: _dataController,
                  readOnly: true,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        icon: Icon(
                          Icons.calendar_today_outlined,
                        ),
                        onPressed: () {
                          _selectDate(context);
                        }),
                    labelText: "Data",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  )),
              SizedBox(height: 15),
              DropdownButtonFormField<String>(
                  value: evento.lugar,
                  icon: const Icon(Icons.location_on),
                  onChanged: (String lugarSelecionado) {
                    setState(() {
                      evento.lugar = lugarSelecionado;
                    });
                  },
                  items: setItensLugares(),
                  decoration: InputDecoration(
                    labelText: "Lugar",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  )),
              SizedBox(height: 15),
              DropdownButtonFormField<String>(
                  value: evento.tipo,
                  onChanged: (String tipoSelecionado) {
                    setState(() {
                      evento.tipo = tipoSelecionado;
                    });
                  },
                  items: setItensTipos(),
                  decoration: InputDecoration(
                    labelText: "Tipo",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  )),
              SizedBox(height: 15),
              DropdownButtonFormField<Funcionario>(
                  value: responsavel,
                  onChanged: (Funcionario responsavelSelecionado) {
                    setState(() {
                      responsavel = responsavelSelecionado;
                    });
                  },
                  items: setItensResponsavel(),
                  decoration: InputDecoration(
                    labelText: "Responsável",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  )),
              SizedBox(height: 15),
              Container(
                child: MultiSelectDialogField(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[300],
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  items: setItensFuncionarios(),
                  buttonText: Text("Participantes"),
                  cancelText: Text("Fechar"),
                  confirmText: Text("Feito"),
                  title: Text("Participantes"),
                  selectedColor: Color.fromRGBO(3, 37, 80, 1),
                  unselectedColor: Color.fromRGBO(23, 104, 172, 1),
                  itemsTextStyle: TextStyle(color: Colors.white),
                  selectedItemsTextStyle: TextStyle(color: Colors.white),
                  listType: MultiSelectListType.CHIP,
                  onConfirm: (values) {
                    convidados = values;
                  },
                  searchable: true,
                ),
              )
            ])),
          )),
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Container(
              margin: EdgeInsets.only(bottom: 40, left: 80, right: 80),
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  editarEvento();
                },
                child: Text("Editar evento",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            )
          ])
        ]));
  }

  List<DropdownMenuItem<String>> setItensLugares() {
    return widget.lugares
        .map((e) => DropdownMenuItem(value: e.nome, child: Text(e.nome)))
        .toList();
  }

  List<DropdownMenuItem<String>> setItensTipos() {
    return widget.tipos
        .map((e) => DropdownMenuItem(value: e.nome, child: Text(e.nome)))
        .toList();
  }

  List<DropdownMenuItem<Funcionario>> setItensResponsavel() {
    return widget.funcionarios
        .map((e) => DropdownMenuItem(value: e, child: Text(e.nome)))
        .toList();
  }

  List<MultiSelectItem<Funcionario>> setItensFuncionarios() {
    return widget.funcionarios
        .map((e) => MultiSelectItem(e, e.nome + " " + e.equipe))
        .toList();
  }
}
