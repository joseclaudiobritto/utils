# Clean Architecture Project Generator

This script automates the creation of a **Clean Architecture-based** project structure using .NET. It sets up a solution with four main layers: **Domain, Application, Infrastructure, and API (Presentation)**.

## Prerequisites

Before running the script, ensure you have:

- **.NET SDK** installed
- **Bash shell** (Linux/macOS or WSL on Windows)
- **dotnet CLI** accessible from the terminal

## Usage

Run the script with the following parameters:

```bash
./create_project.sh <ProjectName> <BasePath>
```

### Example:

```bash
./create_project.sh MyProject /home/user/projects
```

This will create a project structure inside `/home/user/projects/MyProject`.

---

## Project Structure

After running the script, the generated project will have the following structure:

```
MyProject
├── MyProject.sln
│
├── MyProject.Domain
│   ├── Entities/
│   ├── ValueObjects/
│   ├── Interfaces/
│   ├── DomainEvents/
│   ├── Exceptions/
│   └── MyProject.Domain.csproj
│
├── MyProject.Application
│   ├── Interfaces/
│   ├── DTOs/
│   ├── Commands/
│   ├── Queries/
│   ├── Handlers/
│   ├── Services/
│   └── MyProject.Application.csproj
│
├── MyProject.Infrastructure
│   ├── Data/
│   ├── Repositories/
│   ├── ExternalServices/
│   ├── Configurations/
│   └── MyProject.Infrastructure.csproj
│
├── MyProject.API
│   ├── Controllers/
│   ├── Middlewares/
│   ├── Extensions/
│   ├── Program.cs
│   └── MyProject.API.csproj
```
