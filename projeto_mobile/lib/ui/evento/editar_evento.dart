import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:projeto_mobile/models/evento_model.dart';
import 'package:projeto_mobile/models/funcionario_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:projeto_mobile/data/api_services.dart';
import 'package:projeto_mobile/models/lugar_model.dart';
import 'package:projeto_mobile/models/tipo_model.dart';

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

  editarEvento() {
    evento.nome = _nomeController.text;
    evento.responsavel = responsavel.id.toString();
    evento.data = _dataController.text;
    APIServices.editarEvento(evento).then((response) {});
  }

  @override
  void initState() {
    evento = widget.evento;
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
            keyboardType: TextInputType.datetime,
            decoration: InputDecoration(labelText: "Data")),
        DropdownButton<String>(
            value: evento.lugar,
            icon: const Icon(Icons.location_on),
            onChanged: (String lugarSelecionado) {
              setState(() {
                evento.lugar = lugarSelecionado;
              });
            },
            items: setItensLugares()),
        DropdownButton<String>(
            value: evento.tipo,
            onChanged: (String tipoSelecionado) {
              setState(() {
                evento.tipo = tipoSelecionado;
              });
            },
            items: setItensTipos()),
        DropdownButton<Funcionario>(
            value: responsavel,
            onChanged: (Funcionario responsavelSelecionado) {
              setState(() {
                responsavel = responsavelSelecionado;
              });
            },
            items: setItensResponsavel()),
        Container(
          child: MultiSelectDialogField(
            initialValue: convidados,
            items: setItensFuncionarios(),
            buttonText: Text("Participantes"),
            cancelText: Text("Fechar"),
            confirmText: Text("Feito"),
            title: Text("Participantes"),
            selectedColor: Colors.orange[500],
            unselectedColor: Colors.orange[100],
            listType: MultiSelectListType.CHIP,
            onConfirm: (values) {
              convidados = values;
              evento.participantes = convidados;
            },
            searchable: true,
          ),
        ),
        Padding(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: Container(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  editarEvento();
                },
                child: Text("Editar evento",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ))
      ])),
    )));
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
