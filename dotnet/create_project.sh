#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <ProjectName> <BasePath>"
    exit 1
fi

PROJECT_NAME=$1
BASE_PATH=$2
PROJECT_DIR="$BASE_PATH/$PROJECT_NAME"

mkdir -p "$PROJECT_DIR" || { echo "Error creating directory $PROJECT_DIR"; exit 1; }
cd "$PROJECT_DIR" || exit 1

echo "Creating solution $PROJECT_NAME..."
dotnet new sln -n "$PROJECT_NAME"

echo "Creating Domain project..."
dotnet new classlib -n "$PROJECT_NAME.Domain"
dotnet sln add "$PROJECT_NAME.Domain/$PROJECT_NAME.Domain.csproj"
mkdir -p "$PROJECT_NAME.Domain/Entities"
mkdir -p "$PROJECT_NAME.Domain/ValueObjects"
mkdir -p "$PROJECT_NAME.Domain/Interfaces"
mkdir -p "$PROJECT_NAME.Domain/DomainEvents"
mkdir -p "$PROJECT_NAME.Domain/Exceptions"
rm "$PROJECT_NAME.Domain/Class1.cs"

echo "Creating Application project..."
dotnet new classlib -n "$PROJECT_NAME.Application"
dotnet sln add "$PROJECT_NAME.Application/$PROJECT_NAME.Application.csproj"
mkdir -p "$PROJECT_NAME.Application/Interfaces"
mkdir -p "$PROJECT_NAME.Application/DTOs"
mkdir -p "$PROJECT_NAME.Application/Commands"
mkdir -p "$PROJECT_NAME.Application/Queries"
mkdir -p "$PROJECT_NAME.Application/Handlers"
mkdir -p "$PROJECT_NAME.Application/Services"
rm "$PROJECT_NAME.Application/Class1.cs"


echo "Creating Infrastructure project..."
dotnet new classlib -n "$PROJECT_NAME.Infrastructure"
dotnet sln add "$PROJECT_NAME.Infrastructure/$PROJECT_NAME.Infrastructure.csproj"
mkdir -p "$PROJECT_NAME.Infrastructure/Data"
mkdir -p "$PROJECT_NAME.Infrastructure/Repositories"
mkdir -p "$PROJECT_NAME.Infrastructure/ExternalServices"
mkdir -p "$PROJECT_NAME.Infrastructure/Configurations"
rm "$PROJECT_NAME.Infrastructure/Class1.cs"

echo "Creating API project..."
dotnet new webapi -n "$PROJECT_NAME.API"
dotnet sln add "$PROJECT_NAME.API/$PROJECT_NAME.API.csproj"
mkdir -p "$PROJECT_NAME.API/Controllers"
mkdir -p "$PROJECT_NAME.API/Middlewares"
mkdir -p "$PROJECT_NAME.API/Extensions"
touch "$PROJECT_NAME.API/Program.cs"

echo "Adding project references..."
dotnet add "$PROJECT_NAME.API/$PROJECT_NAME.API.csproj" reference "$PROJECT_NAME.Application/$PROJECT_NAME.Application.csproj"
dotnet add "$PROJECT_NAME.Application/$PROJECT_NAME.Application.csproj" reference "$PROJECT_NAME.Domain/$PROJECT_NAME.Domain.csproj"
dotnet add "$PROJECT_NAME.Infrastructure/$PROJECT_NAME.Infrastructure.csproj" reference "$PROJECT_NAME.Domain/$PROJECT_NAME.Domain.csproj"
dotnet add "$PROJECT_NAME.Infrastructure/$PROJECT_NAME.Infrastructure.csproj" reference "$PROJECT_NAME.Application/$PROJECT_NAME.Application.csproj"

echo "Project structure for '$PROJECT_NAME' created successfully in $PROJECT_DIR"
