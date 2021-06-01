using System.Collections.Generic;
using System.Threading.Tasks;
using Bugz.Models;
using System;

namespace Bugz.Data
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