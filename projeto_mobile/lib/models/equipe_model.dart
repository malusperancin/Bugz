class Equipe {
   int _id;
   String _nome;
   String _departamento;

  Equipe(this._id, this._nome, this._departamento);


  int get  id=>_id;
  String get nome => _nome;
  String get departamento => _departamento;

  set nome (String novoNome){
    _nome = novoNome;
  }
  set departamento (String novoDepartamento){
    _departamento = novoDepartamento;
  }


  Map<String,dynamic> toMap(){
    var map=Map<String,dynamic>();
    map["nome"] = _nome;
    map["departamento"] = _departamento;

    if(_id != null){
      map["id"] = _id;
    }
    return map;
  }

  Equipe.fromObject(dynamic o){
    this._id=o["id"];
    this.nome = o["nome"];
    this.departamento = o["departamento"];
  }

}
