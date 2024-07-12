using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace Backend
{
    public class Repository
    {
        private readonly AppDb _appDb;
        public Repository(AppDb appDb)
        {
            _appDb = appDb;
        }

        public async Task<List<Model>> GetWeather()
        {
            var weather = await _appDb.Model.ToListAsync();
            return weather;
        }

        public async Task<Model> AddWeather()
        {
            List<string> days = ["Monday", "Tuesdqy", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
            List<string> values = ["Good", "Bad", "Rainy", "Sunny", "Icy"];

            int randomDay = Random.Shared.Next(0, 7); // Generates a random number between 10 and 49           

            int randomValue = Random.Shared.Next(0, 5); // Generates a random number between 10 and 49

            var newItem = new Model { Day = days[randomDay], State = values[randomValue] };
            await _appDb.Model.AddAsync(newItem);
            await _appDb.SaveChangesAsync();
            
            return newItem;
        }
    }
}