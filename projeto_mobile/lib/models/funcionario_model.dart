class Funcionario {
  int _id;
  String _foto;
  String _nome;
  String _departamento;
  String _apelido;
  String _equipe;
  bool isSelected = false;

  Funcionario(
      this._foto, this._nome, this._departamento, this._apelido, this._equipe);

  Funcionario.ComId(this._id, this._foto, this._nome, this._departamento,
      this._apelido, this._equipe);

  int get id => _id;
  String get foto => _foto;
  String get nome => _nome;
  String get departamento => _departamento;
  String get apelido => _apelido;
  String get equipe => _equipe;

  set foto(String novaFoto) {
    _foto = novaFoto;
  }

  set nome(String novoNome) {
    _nome = novoNome;
  }

  set departamento(String novoDepartamento) {
    _departamento = novoDepartamento;
  }

  set apelido(String novoApelido) {
    _apelido = novoApelido;
  }

  set equipe(String novaEquipe) {
    _equipe = novaEquipe;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["foto"] = _foto;
    map["nome"] = _nome;
    map["departamento"] = _departamento;
    map["apelido"] = _apelido;
    map["equipe"] = _equipe;

    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  Funcionario.fromObject(dynamic o) {
    this._id = o["id"];
    this.foto = o["foto"];
    this.nome = o["nome"];
    this.departamento = o["departamento"];
    this.apelido = o["apelido"];
    this.equipe = o["equipe"];
  }
}
