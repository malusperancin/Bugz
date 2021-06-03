class Funcionario {
  int id;
  String foto;
  String nome;
  String departamento;
  String apelido;
  String equipe;

  Funcionario(this.id, this.foto, this.nome, this.departamento, this.apelido, this.equipe);

  Funcionario.fromObject(dynamic o) {
    this.id = o["id"];
    this.foto = o["foto"];
    this.nome = o["nome"];
    this.departamento = o["departamento"];
    this.apelido = o["apelido"];
    this.equipe = o["equipe"];
  }

  Map toJson() => {
    'id': id,
    'foto': foto,
    'nome': nome ,
    'departamento': departamento,
    'apelido': apelido ,
    'equipe': equipe ,
  };
}
