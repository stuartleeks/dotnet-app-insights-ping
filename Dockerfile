FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /app

COPY dotnet-app-insights-ping.csproj ./
RUN dotnet restore --runtime alpine-x64

COPY . ./
RUN dotnet publish -c Release -o /app/publish \
	--runtime alpine-x64 \
	/p:PublishTrimmed=true \
	/p:TrimMode=Link \
	/p:PublishSingleFile=true
	# --self-contained true \

FROM mcr.microsoft.com/dotnet/runtime-deps:6.0-alpine
WORKDIR /app
COPY --from=build-env /app/publish/dotnet-app-insights-ping /app/dotnet-app-insights-ping
ENTRYPOINT ["/app/dotnet-app-insights-ping"]