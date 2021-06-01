import 'package:http/http.dart' as http;
import 'package:projeto_mobile/models/evento_model.dart';

class APIServices {
  static final String url = 'http://192.168.0.136:5001/api/';

  static Future buscarFuncionarios() async {
    return await http.get(Uri.parse(url + 'funcionarios'));
  }

  static Future buscarEventos() async {
    return await http.get(Uri.parse(url + 'eventos'));
  }

  static Future buscarEquipes() async {
    return await http.get(Uri.parse(url + 'equipes'));
  }

  static Future buscarLugares() async {
    return await http.get(Uri.parse(url + 'lugares'));
  }

  static Future buscarTipos() async {
    return await http.get(Uri.parse(url + 'tipos'));
  }

  static Future adicionarEvento(Evento evento) async {
    return await http.post(Uri.parse(url + 'eventos'), body: evento);
  }

  static Future editarEvento(Evento evento) async {
    return await http.put(Uri.parse(url + 'eventos/'+evento.id.toString()), body: evento);
  }

  static Future deletarEvento(Evento evento) async {
    return await http.put(Uri.parse(url + 'eventos/'+evento.id.toString()));
  }
}
