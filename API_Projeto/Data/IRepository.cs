using System.Collections.Generic;
using System.Threading.Tasks;
using ProjetoPratica_API.Models;
using System;
using System.Linq;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Cors;
using ProjetoPratica_API.Data;

namespace ProjetoPratica_API.Data
{
    public interface IRepository
    {
        // Métodos genéricos
        void Add<T>(T entity) where T : class;
        void Update<T>(T entity) where T : class;
        void Delete<T>(T entity) where T : class;
        void Entry<T>(T entity) where T : class;
        Task<bool> SaveChangesAsync();

        List<Funcionarios> SpGetAllFuncionarios();
        Funcionarios GetFuncionarioById(int id);
        List<Equipes> SpGetEquipes();
        List<Eventos> SpGetEventos();
        Eventos GetEventoById(int idEvento);
        void SpAdicionarEvento(Eventos evento);
        void SpAtualizarEvento(Eventos evento, Eventos antigo);
        List<String> SpGetParticipantes(int idEvento);
        void SpDeleterEvento(int id);
        Task<Lugar[]> GetAllLugares();
        Task<Lugar> GetLugarById(int id);
        Task<Tipo[]> GetAllTipos();
        Task<Tipo> GetTipoById(int id);
    }
}