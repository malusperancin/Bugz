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
                var result = await this.Repo.GetFuncionarioById(FuncionarioId);
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }


        [HttpPut("{FuncionarioId}")]
        public async Task<IActionResult> put(int FuncionarioId, Funcionarios model)
        {
            try
            {
                //verifica se existe aluno a ser alterado
                 var func = await this.Repo.GetFuncionarioById(FuncionarioId);
                 if (func == null) return NotFound(); //método do EF

                this.Repo.Entry(func);
                this.Repo.Update(model);
                
                if (await this.Repo.SaveChangesAsync())
                {
                    return Ok();
                }
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
            // retorna BadRequest se não conseguiu alterar
            return BadRequest();
        }

        [HttpDelete("{FuncionarioId}")]
        public async Task<IActionResult> delete(int FuncionarioId)
        {
            try
            {
                //verifica se existe aluno a ser excluído
                var funcionario = await this.Repo.GetFuncionarioById(FuncionarioId);
                if (funcionario == null) return NotFound(); //método do EF
                this.Repo.Delete(funcionario);
                //
                if (await this.Repo.SaveChangesAsync())
                {
                    return Ok();
                }

            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
            return BadRequest();
        }
    }
}
