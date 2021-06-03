import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_mobile/ui/departamentoEquipes/departamentoEquipes.dart';
import 'package:projeto_mobile/ui/evento/evento.dart';
import 'package:projeto_mobile/ui/funcionario/funcionarios.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  List<Widget> _children = [
    new Funcionarios(),
    new DepEquipes(),
    new Eventos()
  ];

  int _selectedPage = 0;

  Future<void> createInstances() async {
    setState(() {
      _children = [new Funcionarios(), new DepEquipes(), new Eventos()];
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: createInstances,
        child: Scaffold(
            body: IndexedStack(
              index: _selectedPage,
              children: _children,
            ),
            bottomNavigationBar: BottomAppBar(
              elevation: 0.0,
              child: Container(
                height: 50,
                decoration:
                    BoxDecoration(color: Color.fromRGBO(3, 37, 80, 1)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    MaterialButton(
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
                                  : Colors.white38)
                        ],
                      ),
                    ),
                    MaterialButton(
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
                                  : Colors.white38)
                        ],
                      ),
                    ),
                    MaterialButton(
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
                                  : Colors.white38)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }


  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}
