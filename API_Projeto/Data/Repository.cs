using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Bugz.Models;
using Microsoft.Data.SqlClient;
using System.Data;
using System;

namespace Bugz.Data
{
    public class Repository : IRepository
    {
        public Context Context { get; }
        public Repository(Context context)
        {
            this.Context = context;
        }
        public void Add<T>(T entity) where T : class
        {
            this.Context.Add(entity);
        }
        public void Delete<T>(T entity) where T : class
        {
            this.Context.Remove(entity);
        }

        public async Task<bool> SaveChangesAsync()
        {
            return (await this.Context.SaveChangesAsync() > 0);
        }

        public void Update<T>(T entity) where T : class
        {
            this.Context.Update(entity);
        }

        public void Entry<T>(T entity) where T : class
        {
            this.Context.Entry(entity).State = EntityState.Detached;
        }

        public async Task<Funcionarios[]> GetAllFuncionarios()
        {
            IQueryable<Funcionarios> consultaUsuarios = (IQueryable<Funcionarios>)this.Context.Funcionarios;
            consultaUsuarios = consultaUsuarios.OrderByDescending(u => u.Id);

            return await consultaUsuarios.ToArrayAsync();
        }

        public Funcionarios GetFuncionarioById(int id)
        {
            List<Funcionarios> funcionarios = SpGetAllFuncionarios();
            var result = funcionarios.Find(fun => fun.Id == id);
            return result;
        }

        public void SpAdicionarEvento(Eventos evento)
        {
            SqlConnection con = new SqlConnection(this.Context.Database.GetDbConnection().ConnectionString);
            con.Open();
            
            SqlCommand cmd = new SqlCommand("comando", con);

            cmd.CommandText = $"sp_addEvento '{evento.Nome}', '{evento.Data}', '{evento.Lugar}', '{evento.Tipo}', {Convert.ToInt32(evento.Responsavel)}";

            SqlDataReader leitor = cmd.ExecuteReader();
            cmd.CommandText = "";

            while(leitor.Read())
                for(int i = 0; i < evento.Participantes.Length; i++)
                    cmd.CommandText += $"insert into ParticipanteEvento values ({evento.Participantes[i].Id}, {(decimal)leitor["id"]})";

            leitor.Close();
            cmd.ExecuteNonQuery();

            con.Close();
        }

        public List<Funcionarios> SpGetAllFuncionarios()    
        {
            SqlConnection con = new SqlConnection(this.Context.Database.GetDbConnection().ConnectionString);
            con.Open();
            
            SqlCommand cmd = new SqlCommand("comando", con);
            cmd.CommandText = "sp_getAllFuncs";

            SqlDataReader leitor = cmd.ExecuteReader();

            var result = new List<Funcionarios>();

            while (leitor.Read())
            {
                Funcionarios dados = new Funcionarios(
                    (int)leitor["id"],
                    (string)leitor["foto"],
                    (string)leitor["nome"],
                    (string)leitor["departamento"],
                    (string)leitor["apelido"],
                    (string)leitor["equipe"]);

                result.Add(dados);
            }

            con.Close();
            return result;
        }

        public List<Equipes> SpGetEquipes()    
        {
            SqlConnection con = new SqlConnection(this.Context.Database.GetDbConnection().ConnectionString);
            con.Open();
            
            SqlCommand cmd = new SqlCommand("comando", con);
            cmd.CommandText = "sp_getEquipes ";

            SqlDataReader leitor = cmd.ExecuteReader();

            var result = new List<Equipes>();
            var funcionarios = SpGetAllFuncionarios();

            while (leitor.Read())
            {
                Equipes dados = new Equipes(
                    (int)leitor["id"],
                    (string)leitor["nome"],
                    (string)leitor["departamento"],
                    funcionarios.FindAll(func => func.Equipe == (string)leitor["nome"]).ToArray()
                );

                result.Add(dados);
            }

            con.Close();
            return result;
        }

        public List<Eventos> SpGetEventos()    
        {
            SqlConnection con = new SqlConnection(this.Context.Database.GetDbConnection().ConnectionString);
            con.Open();
            
            SqlCommand cmd = new SqlCommand("comando", con);
            cmd.CommandText = "sp_getEventos ";

            SqlDataReader leitor = cmd.ExecuteReader();

            var even = new List<Eventos>();
            int idAnterior = 1;
            
            leitor.Read();

            for(int i = 0;i < leitor.RecordsAffected;)
            {
                List<Funcionarios> participantes = new List<Funcionarios>();

                Eventos dados = new Eventos(
                    (int)leitor["id"],
                    (string)leitor["nome"],
                    (string)leitor["data"],
                    (string)leitor["lugar"],
                    (string)leitor["tipo"],
                    (string)leitor["nomeResponsavel"],
                    null
                );

                do
                {
                    Funcionarios part = new Funcionarios(
                        (int)leitor["idParticipante"],
                        (string)leitor["nomeParticipante"],
                        (string)leitor["fotoParticipante"]
                    );
                    
                    participantes.Add(part);

                    idAnterior = (int)leitor["id"];
                    
                    try{
                        leitor.Read();
                        i++;
                    }
                    catch{
                        break;
                    }
                }
                while (i < leitor.RecordsAffected && (int)leitor["id"] == idAnterior);

                dados.Participantes = participantes.ToArray();
                even.Add(dados);
            }

            con.Close();
            return even;
        }

        public List<String> SpGetParticipantes(int idEvento)    
        {
            SqlConnection con = new SqlConnection(this.Context.Database.GetDbConnection().ConnectionString);
            con.Open();
            
            SqlCommand cmd = new SqlCommand("comando", con);
            cmd.CommandText = "sp_getParticipantesByIdEvento " + idEvento;

            SqlDataReader leitor = cmd.ExecuteReader();

            var part = new List<String>();

            while (leitor.Read())
            {
                part.Add((string)leitor["nome"]);
            }

            con.Close();
            return part;
        }

        public Eventos GetEventoById(int idEvento)
        {
            List<Eventos> eventos = SpGetEventos();
            Eventos evento = eventos.Find(e => e.Id == idEvento);
            return evento;
        }

        public void SpAtualizarEvento(Eventos evento, Eventos antigo)
        {
            SqlConnection con = new SqlConnection(this.Context.Database.GetDbConnection().ConnectionString);
            con.Open();
            
            SqlCommand cmd = new SqlCommand("comando", con);

            cmd.CommandText = $"sp_updateEvento {evento.Id}, '{evento.Nome}', '{evento.Data}', '{evento.Lugar}', '{evento.Tipo}', {Convert.ToInt32(evento.Responsavel)}";
            cmd.ExecuteNonQuery();

            cmd.CommandText = "";

            var novosPar = evento.Participantes.ToList<Funcionarios>();
            var antigosPar = antigo.Participantes.ToList<Funcionarios>();

            for(int i = 0; i < antigo.Participantes.Length; i++)
                novosPar.Remove(novosPar.Find(p => p.Id == antigo.Participantes[i].Id));

            for(int i = 0; i < evento.Participantes.Length; i++)
                antigosPar.Remove(antigosPar.Find(p => p.Id == evento.Participantes[i].Id));

            for (int i = 0; i < novosPar.Count; i++){
                cmd.CommandText = $"insert into ParticipanteEvento values ({novosPar[i].Id}, {evento.Id}) ";
                cmd.ExecuteNonQuery();
            }

            for (int i = 0; i < antigosPar.Count; i++){
                cmd.CommandText = $"delete from ParticipanteEvento where idParticipante={antigosPar[i].Id} ";
                cmd.ExecuteNonQuery();
            }
    
            con.Close();
        }
      
        public void SpDeleterEvento(int id)
        {
            SqlConnection con = new SqlConnection(this.Context.Database.GetDbConnection().ConnectionString);
            con.Open();
            
            SqlCommand cmd = new SqlCommand("comando", con);

            cmd.CommandText = $"delete from ParticipanteEvento where idEvento = {id}";
            cmd.ExecuteNonQuery();

            cmd.CommandText = $"delete from Evento where id = {id}";
            cmd.ExecuteNonQuery();
        }
        
        public async Task<Lugar[]> GetAllLugares()
        {
            IQueryable<Lugar> consultaLugares = (IQueryable<Lugar>)this.Context.Lugar;
            consultaLugares = consultaLugares.OrderBy(l => l.Id);

            return await consultaLugares.ToArrayAsync();
        }

        public async Task<Lugar> GetLugarById(int id)
        {
            IQueryable<Lugar> consultaLugar = (IQueryable<Lugar>)this.Context.Lugar;
            consultaLugar = consultaLugar.OrderBy(l => l.Id).Where(lugar => lugar.Id == id);
            return await consultaLugar.FirstOrDefaultAsync();
        }

        public async Task<Tipo[]> GetAllTipos()
        {
            IQueryable<Tipo> consultaTipos = (IQueryable<Tipo>)this.Context.Tipo;
            consultaTipos = consultaTipos.OrderBy(t => t.Id);
            return await consultaTipos.ToArrayAsync();
        }

        public async Task<Tipo> GetTipoById(int id)
        {
            IQueryable<Tipo> consultaTipo = (IQueryable<Tipo>)this.Context.Tipo;
            consultaTipo = consultaTipo.OrderBy(t => t.Id).Where(tipo => tipo.Id == id);;
            return await consultaTipo.FirstOrDefaultAsync();
        }
    }
}