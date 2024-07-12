using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace Backend
{
    public class AppDb : DbContext
    {
        public AppDb(DbContextOptions dbContextOptions)
        : base(dbContextOptions)
        {

        }

        public DbSet<Model> Model { get; set; }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            base.OnModelCreating(builder);


        }
    }
}
