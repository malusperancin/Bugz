import 'package:flutter/material.dart';
import 'package:projeto_mobile/ui/funcionarios.dart';
import 'package:projeto_mobile/ui/departamentoequipes.dart';
import 'package:projeto_mobile/ui/evento/evento.dart';

class CustomNavBar extends StatefulWidget {
  int paginaAberta;
  CustomNavBar({this.paginaAberta});

  @override
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  Widget paginaAtual;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      //color: Colors.black,
      shape: CircularNotchedRectangle(),
      notchMargin: 10,
      child: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            //Primeira linha
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      widget.paginaAberta = 0;
                    });
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => Funcionarios()));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.account_circle_rounded,
                          color: widget.paginaAberta == 0
                              ? Colors.black87
                              : Colors.grey),
                      Text(
                        "Funcionarios",
                        style: TextStyle(
                            color: widget.paginaAberta == 0
                                ? Colors.black87
                                : Colors.grey),
                      )
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      widget.paginaAberta = 1;
                    });
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => DepEquipes()));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.wc_rounded,
                          color: widget.paginaAberta == 1
                              ? Colors.black87
                              : Colors.grey),
                      Text(
                        "Times/Departamentos",
                        style: TextStyle(
                            color: widget.paginaAberta == 1
                                ? Colors.black87
                                : Colors.grey),
                      )
                    ],
                  ),
                ),
              ],
            ),
            //Segunda linha
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      widget.paginaAberta = 2;
                    });
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Eventos()));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.event_available,
                          color: widget.paginaAberta == 2
                              ? Colors.black87
                              : Colors.grey),
                      Text(
                        "Eventos",
                        style: TextStyle(
                            color: widget.paginaAberta == 2
                                ? Colors.black87
                                : Colors.grey),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
