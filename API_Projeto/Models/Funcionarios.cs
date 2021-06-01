namespace Bugz.Models
{
    public class Funcionarios
    {
        public Funcionarios(int id,string foto,string nome,string departamento,string apelido,string equipe)
        {
            Id = id;
            Foto = foto;
            Nome = nome;
            Departamento = departamento;
            Apelido = apelido;
            Equipe = equipe;
        }

        public Funcionarios(int id, string nome, string foto)
        {
            Id = id;
            Nome = nome;
            Foto = foto;
        }

        public Funcionarios(){}

        public int Id { get; set; }
        public string Foto { get; set; }
        public string Nome { get; set; }
        public string Departamento { get; set; }
        public string Apelido { get; set; }
        public string Equipe { get; set; }

    }
}
