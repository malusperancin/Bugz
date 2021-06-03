import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_mobile/data/api_services.dart';
import 'package:projeto_mobile/models/evento_model.dart';
import 'package:projeto_mobile/models/funcionario_model.dart';
import 'package:projeto_mobile/models/lugar_model.dart';
import 'package:projeto_mobile/models/tipo_model.dart';
import 'package:projeto_mobile/ui/evento/editar_evento.dart';
import 'package:projeto_mobile/ui/evento/form_evento.dart';
import 'package:confirm_dialog/confirm_dialog.dart';

class Eventos extends StatefulWidget {
  Eventos({Key key}) : super(key: key);
  @override
  _EventoState createState() => _EventoState();
}

class _EventoState extends State<Eventos> {
  List<Evento> eventos;
  List<Lugar> lugares;
  List<Tipo> tipos;
  List<Funcionario> funcionarios;
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

  getLocais() {
    APIServices.buscarLugares().then((response) {
      Iterable list = json.decode(response.body);
      List<Lugar> listaLugar = [];
      listaLugar = list.map((model) => Lugar.fromObject(model)).toList();
      setState(() {
        lugares = listaLugar;
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

  deletarEvento(Evento evento) async {
    var deletou = await APIServices.deletarEvento(evento);
    getEventos();
    setState(() {});

    if (!deletou) {}
  }

  void telaEditar(BuildContext context, var indice) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditarEvento(
                evento: eventos[indice],
                lugares: lugares,
                tipos: tipos,
                funcionarios: funcionarios)));

    getEventos();
    setState(() {});
  }

  @override
  void initState() {
    getFuncionarios();
    getLocais();
    getTipos();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getEventos();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 35.0, 0, 0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0),
            ),
            child: DefaultTabController(
              length: 2,
              child: Scaffold(
                backgroundColor: Color.fromRGBO(0, 0, 0, 0),
                appBar: TabBar(
                  labelColor: Color.fromRGBO(0, 0, 0, 1),
                  unselectedLabelColor: Colors.grey[600],
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      color: Color.fromRGBO(0, 0, 0, 0)),
                  tabs: [Tab(text: "Consultar"), Tab(text: "Adicionar")],
                ),
                body: TabBarView(
                  children: [
                    eventos == null
                        ? Center(child: Text('Não há nada por aqui...'))
                        : listaEventos(),
                    FormEvento(
                        lugares: lugares,
                        tipos: tipos,
                        funcionarios: funcionarios)
                  ],
                ),
              ),
            ),
          )
        ]));
  }

  Widget getWidget(int index) {
    if (!verMais)
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
                                        eventos[index]
                                            .participantes[i]
                                            .foto)))),
                      ),
                      SizedBox(
                        width: 10,
                      ),
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
                    indexExpandido = index;
                  }))
        ]);
  }

  Widget listaEventos() {
    return ListView.builder(
      itemCount: eventos.length,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0),
            child: Container(
              color: Colors.grey[200],
              child: Container(
                width: double.infinity,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 18.0),
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
                            SizedBox(height: 6),
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
                        SizedBox(height: 20),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              ClipOval(
                                child: Material(
                                  color: Colors.grey[400], // button color
                                  child: InkWell(
                                    splashColor:
                                        Colors.grey[400], // inkwell color
                                    child: SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: Icon(Icons.edit)),
                                    onTap: () {
                                      telaEditar(context, index);
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              ClipOval(
                                child: Material(
                                  color: Colors.grey[400], // button color
                                  child: InkWell(
                                    splashColor:
                                        Colors.red[400], // inkwell color
                                    child: SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: Icon(Icons.delete_forever)),
                                    onTap: () async {
                                      if (await confirm(context,
                                          title: Text("Deletar"),
                                          textOK: Text("Sim"),
                                          textCancel: Text("Não"),
                                          content: Text("Deletar '" +
                                              eventos[index].nome +
                                              "' para sempre?")))
                                        deletarEvento(eventos[index]);
                                    },
                                  ),
                                ),
                              )
                            ]),
                        SizedBox(
                          height: 10,
                        ),
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
