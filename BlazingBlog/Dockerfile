# Multi-stage build for .NET 7 Blazor Server app
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src

# copy csproj and restore as a separate layer
COPY ["BlazingBlog.csproj", "./"]
RUN dotnet restore "BlazingBlog.csproj"

# copy everything else and publish
COPY . .
RUN dotnet publish "BlazingBlog.csproj" -c Release -o /app/publish --no-restore

# runtime image
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS runtime
WORKDIR /app
ENV DOTNET_RUNNING_IN_CONTAINER=true
ENV ASPNETCORE_URLS=http://+:80

COPY --from=build /app/publish ./

ENTRYPOINT ["dotnet", "BlazingBlog.dll"]
