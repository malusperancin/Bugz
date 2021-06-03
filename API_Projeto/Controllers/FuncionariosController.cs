using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Cors;
using Bugz.Data;
using Bugz.Models;

namespace Bugz.Controllers
{
    [EnableCors("*")]
    [Route("api/[controller]")]
    [ApiController]
    public class FuncionariosController : Controller
    {
        public IRepository Repo { get; }
        public FuncionariosController(IRepository repo)
        {
            this.Repo = repo;
        }


        [HttpGet]
        public async Task<IActionResult> Get()
        {
            try
            {
                var result =  this.Repo.SpGetAllFuncionarios();
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpGet("{FuncionarioId}")]
        public async Task<IActionResult> Get(int FuncionarioId)
        {
            try
            {
                var result = this.Repo.GetFuncionarioById(FuncionarioId);
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }
    }
}
