import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_mobile/models/api_services.dart';
import 'package:projeto_mobile/models/evento_model.dart';
import 'package:projeto_mobile/nav/navbar.dart';
import 'package:projeto_mobile/ui/evento/componentes/form_evento.dart';

class Eventos extends StatefulWidget {
  Eventos({Key key}) : super(key: key);
  @override
  _EventoState createState() => _EventoState();
}

class _EventoState extends State<Eventos> {
  List<Evento> eventos;

  getEventos() {
    APIServices.buscarEventos().then((response) {
      Iterable list = json.decode(response.body);
      List<Evento> listaEventos = List<Evento>();
      listaEventos = list.map((model) => Evento.fromObject(model)).toList();
      setState(() {
        eventos = listaEventos;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getEventos();
    return Scaffold(
        body: Container(
      margin: EdgeInsets.fromLTRB(10.0, 35.0, 10.0, 0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
        color: Colors.red[600],
      ),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: TabBar(
            labelColor: Colors.redAccent,
            unselectedLabelColor: Colors.grey[600],
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Colors.white),
            tabs: [Tab(text: "Consultar"), Tab(text: "Adicionar")],
          ),
          body: TabBarView(
            children: [
              eventos == null
                  ? Center(
                      child: Text('Vazio'),
                    )
                  : listaEventos(),
              FormEvento()
            ],
          ),
        ),
      ),
    ));
  }

  Widget listaEventos() {
    return ListView.builder(
      itemCount: eventos.length,
      itemBuilder: (context, index) {
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
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              eventos[index].nome,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            SizedBox(width: 18),
                            Text(
                              eventos[index].tipo,
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20),
                            ),
                          ]),
                      Text(
                        eventos[index].responsavel,
                        style: TextStyle(color: Colors.black45, fontSize: 15),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              eventos[index].data,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                            SizedBox(width: 18),
                            Text(
                              eventos[index].lugar,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ]),
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
