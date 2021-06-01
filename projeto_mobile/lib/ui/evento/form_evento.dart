import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:projeto_mobile/models/evento_model.dart';
import 'package:projeto_mobile/models/funcionario_model.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:projeto_mobile/data/api_services.dart';
import 'package:projeto_mobile/models/lugar_model.dart';
import 'package:projeto_mobile/models/tipo_model.dart';
import 'package:projeto_mobile/ui/funcionario/funcionarios.dart';

class FormEvento extends StatefulWidget {
  FormEvento({Key key}) : super(key: key);

  @override
  _FormEventoState createState() => _FormEventoState();
}

class _FormEventoState extends State<FormEvento> {

  addEvento() {
    //Evento evento = new Evento(0, _nomeController.text, _dataController.text, _lugar, _tipo, _responsavel, _participantes)
    APIServices.adicionarEvento(evento).then((response) {
      print(response);
    });
  }

  List<Lugar> lugares;
  List<Tipo> tipos;
  List<Funcionario> funcionarios;

  getLocais() {
    APIServices.buscarLugares().then((response) {
      Iterable list = json.decode(response.body);
      List<Lugar> listaLugar = [];
      listaLugar = list.map((model) => Lugar.fromObject(model)).toList();
      setState(() {
        lugares = listaLugar;
        lugar = listaLugar[0].nome;
      });
    });
  }

  getTipos() {
    APIServices.buscarTipos().then((response) {
      Iterable list = json.decode(response.body);
      List<Tipo> listaTipo = [];
      listaTipo = list.map((model) => Tipo.fromObject(model)).toList();
      setState(() {
        tipos = listaTipo;
        tipo = listaTipo[0].nome;
      });
    });
  }

  getFuncionarios() {
    APIServices.buscarFuncionarios().then((response) {
      Iterable list = json.decode(response.body);
      List<Funcionario> listaFuncionarios = [];
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
    getLocais();
    getTipos();
    getFuncionarios();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _nomeController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: "Nome")
                ),
                TextFormField(
                  controller: _dataController,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(labelText: "Data")
                ),
                DropdownButton<String>(
                  value: lugar,
                  icon: const Icon(Icons.location_on),
                  onChanged: (String lugarSelecionado) {
                    setState(() {
                      lugar = lugarSelecionado;
                      print(lugar);
                    });
                  },
                  items: lugares.map((e) => DropdownMenuItem(value: e.nome, child: Text(e.nome))).toList()
                ),
                DropdownButton<String>(
                  value: tipo,
                  onChanged: (String tipoSelecionado) {
                    setState(() {
                      tipo = tipoSelecionado;
                      print(tipo);
                    });
                  },
                  items: tipos.map((e) => DropdownMenuItem(value: e.nome, child: Text(e.nome))).toList()
                ),
                TextFormField(
                  controller: _responsavelController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: "Responsavel")
                ),
                Container(
                  child: MultiSelectDialogField(
                    items: funcionarios.map((e) => MultiSelectItem(e, e.nome + "  " + e.equipe)).toList(),
                    
                    buttonText: Text("Participantes"),
                    cancelText: Text("Fechar"),
                    confirmText: Text("Feito"),
                    title: Text("Participantes"),
                    selectedColor: Colors.orange[500],
                    unselectedColor: Colors.orange[100],
                   
                    listType: MultiSelectListType.CHIP,

                    onConfirm: (values) {
                      convidados = values;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
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
                      child: Text("Criar evento",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  )
                )
              ]
            )
          ),
        )
      )
    );
  }
}
