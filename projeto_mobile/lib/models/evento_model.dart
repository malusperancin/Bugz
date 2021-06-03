import 'package:projeto_mobile/models/funcionario_model.dart';

class Evento {
  int id;
  String nome;
  String data;
  String lugar;
  String tipo;
  String responsavel;
  List<Funcionario> participantes = [];

  Evento(this.id, this.nome, this.data, this.lugar, this.tipo, this.responsavel,
      this.participantes);

  Evento.fromObject(dynamic o) {
    this.id = o["id"];
    this.nome = o["nome"];
    this.data = o["data"];
    this.lugar = o["lugar"];
    this.tipo = o["tipo"];
    this.responsavel = o["responsavel"];

    this.participantes = [];

    for (int i = 0; i < o["participantes"].length; i++)
      this.participantes.add(new Funcionario.fromObject(o["participantes"][i]));
  }

  Map toJson() {
    var part = [];
    for(int i = 0; i < this.participantes.length; i++) {
      part.add(this.participantes[i].toJson());
    }

    return {
      'id': id,
      'name': nome,
      'data': data,
      'lugar': lugar,
      'tipo': tipo,
      'responsavel': responsavel,
      'participantes': part
    };
  }
}