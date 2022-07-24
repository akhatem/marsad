# syntax=docker/dockerfile:1
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /marsad/app/

# Copy csproj and restore as distinct layers
# COPY *.csproj ./
# RUN dotnet restore

# Copy everything else and build
COPY ../marsad/app/ ./
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /marsad/app/
COPY --from=build-env /marsad/app/out .
ENTRYPOINT ["dotnet", "MarsadJazan.Api.dll"]
