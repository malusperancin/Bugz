namespace Bugz.Models
{
    public class Eventos
    {
        public Eventos(int id,string nome,string data,string lugar,string tipo,string responsavel, Funcionarios[] participantes)
        {
            Id = id;
            Nome = nome;
            Data = data;
            Lugar = lugar;
            Tipo = tipo;
            Responsavel = responsavel;
            Participantes = participantes;
        }

        public Eventos(){}

        public int Id { get; set; }
        public string Nome { get; set; }
        public string Data { get; set; }
        public string Lugar { get; set; }
        public string Tipo { get; set; }
        public string Responsavel { get; set; }
        public Funcionarios[] Participantes { get; set; }
    }
}
