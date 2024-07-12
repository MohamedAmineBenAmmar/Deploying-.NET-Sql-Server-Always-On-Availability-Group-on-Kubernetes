using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;

namespace Backend
{
    [Route("api/weather")]
    [ApiController]
    public class Controller : ControllerBase
    {
        private readonly Repository _repository;
        public Controller(Repository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            try
            {
                var res = await _repository.GetWeather();
                return Ok(res);
            }
            catch (Exception e)
            {
                return StatusCode(500, e);
            }
        }

        [HttpPost]
        public async Task<IActionResult> Add()
        {
            try
            {
                var res = await _repository.AddWeather();
                return Ok(res);
            }
            catch (Exception e)
            {
                return StatusCode(500, e);
            }
        }
    }
}