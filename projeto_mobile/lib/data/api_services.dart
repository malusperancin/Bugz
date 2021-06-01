import 'package:http/http.dart' as http;
import 'package:projeto_mobile/models/evento_model.dart';

class APIServices {
  static String getFuncionarios = 'http://192.168.1.120:5001/api/funcionarios';
  static String getEquipes = 'http://192.168.1.120:5001/api/equipes';
  static String getEventos = 'http://192.168.1.120:5001/api/eventos';
  static String getLugares = 'http://192.168.1.120:5001/api/lugares';
  static String getTipos = 'http://192.168.1.120:5001/api/tipos';
  static String postEvento = 'http://192.168.1.120:5001/api/eventos';
  static String putEvento = 'http://192.168.1.120:5001/api/eventos/';
  static String deleteEvento = 'http://192.168.1.120:5001/api/eventos/';

  static Future buscarFuncionarios() async {
    return await http.get(Uri.parse(getFuncionarios));
  }

  static Future buscarEventos() async {
    return await http.get(Uri.parse(getEventos));
  }

  static Future buscarEquipes() async {
    return await http.get(Uri.parse(getEquipes));
  }

  static Future buscarLugares() async {
    return await http.get(Uri.parse(getLugares));
  }

  static Future buscarTipos() async {
    return await http.get(Uri.parse(getTipos));
  }

  static Future adicionarEvento(Evento evento) async {
    return await http.post(Uri.parse(postEvento), body: evento);
  }

  static Future editarEvento(Evento evento) async {
    return await http.put(Uri.parse(putEvento+evento.id.toString()), body: evento);
  }

  static Future deletarEvento(Evento evento) async {
    return await http.put(Uri.parse(postEvento+evento.id.toString()));
  }
}
