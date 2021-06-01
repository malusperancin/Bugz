import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_mobile/data/api_services.dart';
import 'package:projeto_mobile/models/evento_model.dart';
import 'package:projeto_mobile/ui/evento/form_evento.dart';

class Eventos extends StatefulWidget {
  Eventos({Key key}) : super(key: key);
  @override
  _EventoState createState() => _EventoState();
}

class _EventoState extends State<Eventos> {
  List<Evento> eventos;
  bool verMais = false;
  int indexExpandido = -1;

  getEventos() {
    APIServices.buscarEventos().then((response) {
      Iterable list = json.decode(response.body);
      List<Evento> listaEventos = [];
      listaEventos = list.map((model) => Evento.fromObject(model)).toList();
      setState(() {
        eventos = listaEventos;
      });
    });
  }

  @override
  void initState() {
    getEventos();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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

  Widget getWidget(int index) {
    if (!verMais )
      return verMaisWidget(index);
    else if (index == indexExpandido) {
      indexExpandido = -1;
      verMais = !verMais;
      return listaParticipantes(index);
    } else
      return verMaisWidget(index);
  }

  Widget verMaisWidget(int index) {
    return GestureDetector(
        child: Text("Ver mais", textAlign: TextAlign.center),
        onTap: () => setState(() {
              verMais = !verMais;
              indexExpandido = index;
            }));
  }

  Widget listaParticipantes(int index) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          for (int i = 0; i < eventos[index].participantes.length; i++)
                    Padding(
                    padding: const EdgeInsets.all(0),
                child: Card(
                  color: Colors.white10,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage("assets/images/" +
                                        eventos[index].participantes[i].foto)))),
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            eventos[index].participantes[i].nome,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),

          SizedBox(height: 10),
          GestureDetector(
              child: Text("Ver menos", textAlign: TextAlign.center),
              onTap: () => setState(() {
                    verMais = !verMais;
                    indexExpandido = index;
                  }))
        ]);
  }

  Widget listaEventos() {
    return ListView.builder(
      itemCount: eventos.length,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white70, width: 1),
                borderRadius: BorderRadius.circular(15),
              ),
              color: Colors.white10,
              child: Container(
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18),
                  child: Wrap(
                    children: <Widget>[
                      Column(children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    eventos[index].nome,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    eventos[index].tipo,
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20),
                                  ),
                                ]),
                            Text(
                              "Por: " + eventos[index].responsavel,
                              style: TextStyle(
                                  color: Colors.black45, fontSize: 15),
                            ),
                            SizedBox(height: 10),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Data: " + eventos[index].data,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "Local: " + eventos[index].lugar,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                ]),
                          ],
                        ),
                        SizedBox(height: 10),
                        Container(child: Center(child: getWidget(index))),
                      ])
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
