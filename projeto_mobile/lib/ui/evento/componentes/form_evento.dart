import 'package:flutter/material.dart';
import 'package:projeto_mobile/models/evento_model.dart';
import 'package:projeto_mobile/models/funcionario_model.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:projeto_mobile/models/api_services.dart';

class FormEvento extends StatefulWidget {
  FormEvento({Key key}) : super(key: key);

  @override
  _FormEventoState createState() => _FormEventoState();
}

class _FormEventoState extends State<FormEvento> {
  List<Funcionario> funcionarios;

  getFuncionarios() {
    APIServices.buscarFuncionarios().then((response) {
      Iterable list = json.decode(response.body);
      List<Funcionario> listaFuncionarios = List<Funcionario>();
      listaFuncionarios =
          list.map((model) => Funcionario.fromObject(model)).toList();
      setState(() {
        funcionarios = listaFuncionarios;
      });
    });
  }

  String lugar = "";
  String tipo = "";
  List<Funcionario> convidados = [];
  final _nomeController = TextEditingController();
  final _dataController = TextEditingController();
  final _responsavelController = TextEditingController();

  Evento evento;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
      padding: EdgeInsets.all(10),
      child: Form(
          child: Column(children: <Widget>[
        TextFormField(
            controller: _nomeController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: "Nome")),
        TextFormField(
            controller: _dataController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: "Data")),
        DropdownButtonFormField<String>(
            //value: lugar,
            decoration: InputDecoration(labelText: "Selecione o Lugar"),
            onChanged: (String lugarSelecionado) {
              setState(() {
                lugar = lugarSelecionado;
                print(lugar);
              });
            },
            items: <String>['Casinha', 'Sei la ', 'Nao sei', 'Vslinhos']
                .map(
                  (e) => DropdownMenuItem(value: e, child: Text(e)),
                )
                .toList()),
        DropdownButtonFormField<String>(
            //value: lugar,
            decoration: InputDecoration(labelText: "Selecione o tipo"),
            onChanged: (String tipoSelecionado) {
              setState(() {
                tipo = tipoSelecionado;
                print(tipo);
              });
            },
            items: <String>['Reuniao', 'Provinha ', 'Passeio', 'Sei la']
                .map(
                  (e) => DropdownMenuItem(value: e, child: Text(e)),
                )
                .toList()),
        TextFormField(
            controller: _responsavelController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: "Responsavel")),
        MultiSelectDialogField(
          items: funcionarios.map((e) => MultiSelectItem(e, e.nome)).toList(),
          listType: MultiSelectListType.CHIP,
          onConfirm: (values) {
            convidados = values;
          },
        ),
        Padding(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: Container(
              height: 40,
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {
                  Evento newEvento = new Evento.SemId(
                      _nomeController.text,
                      _dataController.text,
                      lugar,
                      tipo,
                      _responsavelController.text,
                      convidados);
                  print(newEvento);
                },
                color: Colors.redAccent,
                child: Text("Criar evento",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ))
      ])),
    )));
  }
}
