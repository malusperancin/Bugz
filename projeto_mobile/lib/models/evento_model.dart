import 'package:projeto_mobile/models/funcionario_model.dart';

class Evento {
  int _id;
  String _nome;
  String _data;
  String _lugar;
  String _tipo;
  String _responsavel;
  List<Funcionario> _participantes;

  //Contrutor
  Evento(this._id, this._nome, this._data, this._lugar, this._tipo,
      this._responsavel, this._participantes);

  Evento.SemId(this._nome, this._data, this._lugar, this._tipo,
      this._responsavel, this._participantes);

  int get id => _id;
  String get nome => _nome;
  String get data => _data;
  String get lugar => _lugar;
  String get tipo => _tipo;
  String get responsavel => _responsavel;
  List<Funcionario> get participantes => _participantes;

  set nome(String novoNome) {
    _nome = novoNome;
  }

  set data(String novaData) {
    _data = novaData;
  }

  set lugar(String novoLugar) {
    _lugar = novoLugar;
  }

  set tipo(String novoTipo) {
    _tipo = novoTipo;
  }

  set responsavel(String novoResponsavel) {
    _responsavel = novoResponsavel;
  }

  set participantes(List<Funcionario> novoParticipantes) {
    _participantes = novoParticipantes;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["nome"] = _nome;
    map["data"] = _data;
    map["lugar"] = _lugar;
    map["tipo"] = _tipo;
    map["responsavel"] = _responsavel;
    map["participantes"] = _participantes;

    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  Evento.fromObject(dynamic o) {
    this._id = o["id"];
    this.nome = o["nome"];
    this.data = o["data"];
    this.lugar = o["lugar"];
    this.tipo = o["tipo"];
    this.responsavel = o["responsavel"];

    this.participantes = [];

    for (int i = 0; i < o["participantes"].length; i++)
      this.participantes.add(new Funcionario.fromObject(o["participantes"][i]));
  }
}
