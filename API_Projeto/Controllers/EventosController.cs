using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Cors;
using ProjetoPratica_API.Data;
using ProjetoPratica_API.Models;


namespace ProjetoPratica_API.Controllers
{
    [EnableCors("*")]
    [Route("api/[controller]")]
    [ApiController]
    public class EventosController : Controller
    {
        public IRepository Repo { get; }
        public EventosController(IRepository repo)
        {
            this.Repo = repo;
        }

        [HttpGet]
        public async Task<IActionResult> Get()
        {
            try
            {
                var result =  this.Repo.SpGetEventos();
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpGet("{IdEvento}")]
        public async Task<IActionResult> Get(int IdEvento)
        {
            try
            {
                var result = this.Repo.GetEventoById(IdEvento);
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpPost]
        public async Task<IActionResult> post(Eventos model)
        {
            try
            {
                this.Repo.SpAdicionarEvento(model);
                return Ok();
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
            
            return BadRequest();
        }

        [HttpPut("{EventoId}")]
        public async Task<IActionResult> put(int EventoId, Eventos model)
        {
            try
            {
                //verifica se existe aluno a ser alterado
                var evento = this.Repo.GetEventoById(EventoId);
                if (evento == null) return NotFound(); //método do EF

                this.Repo.SpAtualizarEvento(model, evento);
                
                return Ok();
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
            // retorna BadRequest se não conseguiu alterar
            return BadRequest();
        }

        [HttpDelete("{idEvento}")]
        public async Task<IActionResult> delete(int idEvento)
        {
            try
            {
                //verifica se existe aluno a ser excluído
                var evento = this.Repo.GetEventoById(idEvento);
                if (evento == null) return NotFound(); //método do EF

                this.Repo.SpDeleterEvento(idEvento);
                return Ok();
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
            return BadRequest();
        }
    }
}
