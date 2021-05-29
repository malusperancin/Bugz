using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using ProjetoPratica_API.Data;
using Microsoft.EntityFrameworkCore;
using ProjetoPratica_API.Models;
using Microsoft.Data.SqlClient;
using System.Data;
using System;

namespace ProjetoPratica_API.Data
{
    public class Repository : IRepository
    {
        public MoneyroContext Context { get; }
        public Repository(MoneyroContext context)
        {
            this.Context = context;
        }
        public void Add<T>(T entity) where T : class
        {
            //throw new System.NotImplementedException();
            this.Context.Add(entity);
        }
        public void Delete<T>(T entity) where T : class
        {
            //throw new System.NotImplementedException();
            this.Context.Remove(entity);
        }
        public async Task<bool> SaveChangesAsync()
        {
            // Como é tipo Task vai gerar thread, então vamos definir o método como assíncrono (async)
            // Por ser assíncrono, o return deve esperar (await) se tem alguma coisa para salvar no BD
            // Ainda verifica se fez alguma alteração no BD, se for maior que 0 retorna true ou false
            return (await this.Context.SaveChangesAsync() > 0);
        }
        public void Update<T>(T entity) where T : class
        {
            //throw new System.NotImplementedException();
            this.Context.Update(entity);
        }

        public void Entry<T>(T entity) where T : class
        {
            this.Context.Entry(entity).State = EntityState.Detached;
        }

        public async Task<Funcionarios[]> GetAllFuncionarios()
        {
            //throw new System.NotImplementedException();
            //Retornar para uma query qualquer do tipo Aluno
            IQueryable<Funcionarios> consultaUsuarios = (IQueryable<Funcionarios>)this.Context.Funcionarios;
            consultaUsuarios = consultaUsuarios.OrderByDescending(u => u.Id);

            return await consultaUsuarios.ToArrayAsync();
        }
        public async Task<Funcionarios> GetFuncionarioById(int Id)
        {

            //throw new System.NotImplementedException();
            //Retornar para uma query qualquer do tipo Aluno
            IQueryable<Funcionarios> consultaUsuario = (IQueryable<Funcionarios>)this.Context.Funcionarios;
            consultaUsuario = consultaUsuario.OrderBy(u => u.Id).Where(usuario => usuario.Id == Id);
            // aqui efetivamente ocorre o SELECT no BD
            return await consultaUsuario.FirstOrDefaultAsync();
        }

         public List<Funcionarios> SpGetAllFuncionarios()    
        {
            SqlConnection con = new SqlConnection(this.Context.Database.GetDbConnection().ConnectionString);
            con.Open();
            
            SqlCommand cmd = new SqlCommand("comando", con);
            cmd.CommandText = "sp_getAllFuncs ";

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
                    (string)leitor["equipe"]
                    );

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

            while (leitor.Read())
            {
                Equipes dados = new Equipes(
                    (int)leitor["id"],
                    (string)leitor["nome"],
                    (string)leitor["departamento"]
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
            int index = 0;
            Funcionarios part;
            leitor.Read();
            do
            {
                Funcionarios[] participantes = new Funcionarios[4];
                int i = 0;

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
                    part = new Funcionarios(
                    (int)leitor["idParticipante"],
                    null,
                    (string)leitor["nomeParticipante"],
                    null,
                    null,
                    null
                    );
                    participantes[i] = part;
                    idAnterior = (int)leitor["id"];
                    
                    try{
                        leitor.Read();
                        index++;
                        Console.WriteLine((int)leitor["id"]);
                    }
                    catch{
                        break;
                    }
                    i++;
                }
                while ((int)leitor["id"] == idAnterior);

                dados.Participantes = participantes;
                

                even.Add(dados);
                if(leitor.RecordsAffected == index)
                    break;
            }
            while(true);

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
    }
}