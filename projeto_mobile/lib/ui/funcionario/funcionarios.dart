import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_mobile/data/api_services.dart';
import 'package:projeto_mobile/models/funcionario_model.dart';

class Funcionarios extends StatefulWidget {
  Funcionarios({Key key}) : super(key: key);
  @override
  _FuncionarioState createState() => _FuncionarioState();
}

class _FuncionarioState extends State<Funcionarios> {
  List<Funcionario> funcionarios;

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

  @override
  void initState() {
    getFuncionarios();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        body: funcionarios == null
            ? Center(
                child: Text('Vazio'),
              )
            : listaFuncionarios());
  }

  Widget _buildAppBar() {
    return AppBar(title: Text('Lista de Funcionarios'));
  }

  Widget listaFuncionarios() {
    return ListView.builder(
      itemCount: funcionarios.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            color: Colors.white10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/images/" +
                                    funcionarios[index].foto)))),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        funcionarios[index].nome,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Text(
                        funcionarios[index].apelido,
                        style: TextStyle(color: Colors.black45, fontSize: 15),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          funcionarios[index].departamento,
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
