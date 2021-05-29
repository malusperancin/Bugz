import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_mobile/ui/departamentoequipes.dart';
import 'package:projeto_mobile/ui/evento/evento.dart';
import 'package:projeto_mobile/ui/funcionarios.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  final List<Widget> _children = [Funcionarios(), DepEquipes(), Eventos()];

  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: _selectedPage,
          children: _children,
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0.0,
          child: Container(
            margin: EdgeInsets.all(10.0),
            height: 95,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                color: Colors.grey[600]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      _selectedPage = 0;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.account_circle_rounded,
                          color: _selectedPage == 0
                              ? Colors.white
                              : Colors.white38),
                      Text(
                        "Funcionários",
                        style: TextStyle(
                            color: _selectedPage == 0
                                ? Colors.white
                                : Colors.white38),
                      )
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      _selectedPage = 1;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.wc_rounded,
                          color: _selectedPage == 1
                              ? Colors.white
                              : Colors.white38),
                      Text(
                        "Times e Depart.",
                        style: TextStyle(
                            color: _selectedPage == 1
                                ? Colors.white
                                : Colors.white38),
                      )
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      _selectedPage = 2;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.event_available,
                          color: _selectedPage == 2
                              ? Colors.white
                              : Colors.white38),
                      Text(
                        "Eventos",
                        style: TextStyle(
                            color: _selectedPage == 2
                                ? Colors.white
                                : Colors.white38),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
