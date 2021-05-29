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

        Task<Funcionarios[]> GetAllFuncionarios();
        Task<Funcionarios> GetFuncionarioById(int Id);
        List<Funcionarios> SpGetAllFuncionarios();
        List<Equipes> SpGetEquipes();
        List<Eventos> SpGetEventos();
        List<String> SpGetParticipantes(int idEvento);
    }
}