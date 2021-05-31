using Microsoft.EntityFrameworkCore;
using ProjetoPratica_API.Models;

namespace ProjetoPratica_API.Data
{
    public class MoneyroContext : DbContext
    {
        public MoneyroContext(DbContextOptions<MoneyroContext> options) : base(options)
        {
        }
        public DbSet<Funcionarios> Funcionarios { get; set; }
        public DbSet<Tipo> Tipo { get; set; }
        public DbSet<Lugar> Lugar { get; set; }
    }
}