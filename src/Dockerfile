FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["src/dotnet-actions-v-pipelines.csproj", "src/"]
COPY ["test/dotnet-actions-v-pipelines-tests.csproj", "test/"]  

COPY . .

RUN dotnet build "src/dotnet-actions-v-pipelines.csproj" -c Release -o /app/build
RUN dotnet build "test/dotnet-actions-v-pipelines-tests.csproj" -c Release

FROM build AS testlayer
ARG BuildId=localhost
LABEL test=${BuildId}
RUN dotnet test --no-build -c Release --results-directory /testresults \
    --logger "junit;LogFileName=test_results.xml" --collect:"XPlat Code Coverage" \
    test/dotnet-actions-v-pipelines-tests.csproj

FROM build AS publish
RUN dotnet publish "src/dotnet-actions-v-pipelines.csproj" --no-restore -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "dotnet-actions-v-pipelines.dll"]
