FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 8080

ENV ASPNETCORE_URLS=http://+:8080

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["GCR-lab.csproj", "./"]
RUN dotnet restore "GCR-lab.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "GCR-lab.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "GCR-lab.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "GCR-lab.dll"]
