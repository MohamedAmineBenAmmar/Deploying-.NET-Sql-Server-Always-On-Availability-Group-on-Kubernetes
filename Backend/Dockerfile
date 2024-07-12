# .NET sdk base image
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env

# Setting the work directory inside the container
WORKDIR /app

# Exposing ports
EXPOSE 8080

# Copy the csproj files
COPY *.csproj ./

# Restore all the dependencies for optima application
RUN dotnet restore

# Copy the source code
COPY . ./

# Prepare the application for deployment
# dotnet publish is a comprehensive tool that handles the compilation, dependency resolution, 
# and organization of your.NET application into a deployable state, 
# supporting various deployment scenarios and platforms.
RUN dotnet publish -c Release -o out

# Getting an other base image for the container
FROM mcr.microsoft.com/dotnet/sdk:8.0

# Setting the work directory
WORKDIR /app

# Copying the output from the build-env into the app folder inside this container
COPY --from=build-env /app/out .

# Making the entry point to the container
ENTRYPOINT [ "dotnet", "Backend.dll" ] 