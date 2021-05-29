import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class APIServices{
  static String getFuncionarios = 'http://192.168.15.155:5000/api/funcionarios';
  static String getEquipes = 'http://192.168.15.155:5000/api/equipes';
  static String getEventos = 'http://192.168.15.155:5000/api/eventos';

  static Future buscarFuncionarios() async{
    return await http.get(Uri.parse(getFuncionarios));
  }

  static Future buscarEventos() async{
    return await http.get(Uri.parse(getEventos));
  }

  static Future buscarParticipantes(int idEvento) async{
    return await http.get(Uri.parse(getFuncionarios + "/" + idEvento.toString()));
  }

  static Future buscarEquipes() async{
    return await http.get(Uri.parse(getEquipes));
  }
}