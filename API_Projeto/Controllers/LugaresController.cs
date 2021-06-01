using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Cors;
using Bugz.Data;

namespace Bugz.Controllers
{
    [EnableCors("*")]
    [Route("api/[controller]")]
    [ApiController]
    public class LugaresController : Controller
    {
        public IRepository Repo { get; }
        public LugaresController(IRepository repo)
        {
            this.Repo = repo;
        }


        [HttpGet]
        public async Task<IActionResult> Get()
        {
            try
            {
                var result =  await this.Repo.GetAllLugares();
                
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpGet("{LugarId}")]
        public async Task<IActionResult> Get(int LugarId)
        {
            try
            {
                var result = await this.Repo.GetLugarById(LugarId);
                if(result == null) return NotFound();

                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }
    }
}
