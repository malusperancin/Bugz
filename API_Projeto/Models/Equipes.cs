using System;

namespace ProjetoPratica_API.Models
{
    public class Equipes
    {

        public Equipes(int id,string nome,string departamento, Funcionarios[] funcionarios){
            Id = id;
            Nome = nome;
            Departamento = departamento;
            Funcionarios = funcionarios;
        }

        // [Key]
        //public Usuarios(int id, string nome, string apelido, string email, string celular, DateTime data, int foto)
        public int Id { get; set; }
        public string Nome { get; set; }
        public string Departamento { get; set; }

        public Funcionarios[] Funcionarios { get; set; }

    }
}
