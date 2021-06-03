import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_mobile/data/api_services.dart';
import 'package:projeto_mobile/models/equipe_model.dart';

class DepEquipes extends StatefulWidget {
  DepEquipes({Key key}) : super(key: key);
  @override
  _DepEquipeState createState() => _DepEquipeState();
}

class _DepEquipeState extends State<DepEquipes> {
  List<Equipe> equipes;

  getEquipes() {
    APIServices.buscarEquipes().then((response) {
      Iterable list = json.decode(response.body);
      List<Equipe> listaEquipes = [];
      listaEquipes = list.map((model) => Equipe.fromObject(model)).toList();
      setState(() {
        equipes = listaEquipes;
      });
    });
  }

  @override
  void initState() {
    getEquipes();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: equipes == null
          ? Center(
              child: Text('Não há nada por aqui...'),
            )
          : listaEquipes(),
    );
  }

  Widget listaEquipes() {
    return ListView.builder(
      itemCount: equipes.length,
      itemBuilder: (context, index) {
        String depant = "";
        if (index == 0)
          depant = equipes[equipes.length - 1].departamento;
        else
          depant = equipes[index - 1].departamento;
        if (depant != equipes[index].departamento) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Card(
                  margin: new EdgeInsets.only(top: 20.0, bottom: 20.00),
                  color: Colors.black54,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              equipes[index].departamento,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  color: Colors.white10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              equipes[index].nome,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              color: Colors.white10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          equipes[index].nome,
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
