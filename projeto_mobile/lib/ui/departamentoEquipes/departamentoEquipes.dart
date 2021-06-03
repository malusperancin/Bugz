import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_mobile/data/api_services.dart';
import 'package:projeto_mobile/models/equipe_model.dart';

import '../home.dart';

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
      resizeToAvoidBottomInset: false,
      body: equipes == null
          ? Center(
              child: Text('Não há nada por aqui...'),
            )
          : listaEquipes(),
    );
  }

  Widget listaEquipes() {
    return Stack(children: [
      ListView.builder(
        itemCount: equipes.length,
        itemBuilder: (context, index) {
          String depant = "";
          if (index == 0)
            depant = equipes[equipes.length - 1].departamento;
          else
            depant = equipes[index - 1].departamento;
          if (depant != equipes[index].departamento) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 0 , 0),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: new EdgeInsets.only(top: 20.0, bottom: 20.00),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 10, 10, 0),
                      child: Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                equipes[index].departamento,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 22,
                                fontFamily: "Roboto"),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Color.fromRGBO(5, 102, 116, 0),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                equipes[index].nome,
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 18, fontFamily: "Roboto"),
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
              padding: const EdgeInsets.fromLTRB(15, 0, 0 , 0),
              child: Container(
                color: Color.fromRGBO(5, 102, 116, 0),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            equipes[index].nome,
                            style: TextStyle(color: Colors.black45, fontSize: 18,fontFamily: "Roboto"),
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
      )
    ]);
  }
}
