using Bugz.Models;
using Microsoft.EntityFrameworkCore;

namespace Bugz.Data
{
    public class Context : DbContext
    {
        public Context(DbContextOptions<Context> options) : base(options) {}
        public DbSet<Funcionarios> Funcionarios { get; set; }
        public DbSet<Tipo> Tipo { get; set; }
        public DbSet<Lugar> Lugar { get; set; }
    }
}