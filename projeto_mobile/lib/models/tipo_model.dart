class Tipo {
   int _id;
   String _nome;

  Tipo(this._id, this._nome);


  int get  id=>_id;
  String get nome => _nome;

  set nome (String novoNome){
    _nome = novoNome;
  }

  Map<String,dynamic> toMap(){
    var map=Map<String,dynamic>();
    map["nome"] = _nome;

    if(_id != null){
      map["id"] = _id;
    }

    return map;
  }

  Tipo.fromObject(dynamic o){
    this._id=o["id"];
    this._nome = o["nome"];
  }
}
