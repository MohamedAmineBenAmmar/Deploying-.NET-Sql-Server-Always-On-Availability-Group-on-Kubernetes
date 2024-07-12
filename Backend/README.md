1- This connection string must be used in dev mode to propagate migrations from the host machine to the database (SQL Server) hosted in K8S
"DefaultConnection": "Server=localhost,1433;Database=AssistantDb;User Id=sa;Password=Welcome@0001234567;Connect Timeout=30;TrustServerCertificate=true;"

2- This connection string is gonna be used to allow the .NET app to communicate with the sql server backend service
"DefaultConnection": "Server=mssql-primary-service.mssql,1433;Database=AssistantDb;User Id=sa;Password=Welcome@0001234567;Connect Timeout=30;TrustServerCertificate=true;"

