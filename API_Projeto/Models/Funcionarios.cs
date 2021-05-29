using System;

namespace ProjetoPratica_API.Models
{
    public class Funcionarios
    {

        public Funcionarios(int id,string foto,string nome,string departamento,string apelido,string equipe){
        Id = id;
        Foto = foto;
        Nome = nome;
        Departamento = departamento;
        Apelido = apelido;
        Equipe = equipe;
        }

        // [Key]
        //public Usuarios(int id, string nome, string apelido, string email, string celular, DateTime data, int foto)
        public int Id { get; set; }
        public string Foto { get; set; }
        public string Nome { get; set; }
        public string Departamento { get; set; }
        public string Apelido { get; set; }
        public string Equipe { get; set; }

    }
}
