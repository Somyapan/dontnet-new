# Multi-stage build for .NET 7 Blazor Server app
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src

# copy csproj(s) and restore as separate layers
COPY ["BlazingBlog.csproj", "./"]
RUN dotnet restore "BlazingBlog.csproj"

# copy everything else and publish
COPY . .
RUN dotnet publish "BlazingBlog.csproj" -c Release -o /app/publish --no-restore

# runtime image
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS runtime
WORKDIR /app

# copy published app
COPY --from=build /app/publish ./

# copy helper to wait for DB (optional)
COPY wait-for-db.sh .
RUN chmod +x wait-for-db.sh

ENV ASPNETCORE_URLS=http://+:80

# Wait for DB then start the app
ENTRYPOINT ["./wait-for-db.sh", "db", "1433", "dotnet", "BlazingBlog.dll"]
