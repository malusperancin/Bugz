import 'package:projeto_mobile/models/funcionario_model.dart';

class Equipe {
   int _id;
   String _nome;
   String _departamento;
   List<Funcionario> _funcionarios;

  Equipe(this._id, this._nome, this._departamento, this._funcionarios);


  int get  id=>_id;
  String get nome => _nome;
  String get departamento => _departamento;
  List<Funcionario> get funcionarios => _funcionarios;

  set nome (String novoNome){
    _nome = novoNome;
  }

  set departamento (String novoDepartamento){
    _departamento = novoDepartamento;
  }

  set funcionarios (List<Funcionario> novosFuncionarios){
    _funcionarios = novosFuncionarios;
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
