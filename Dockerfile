FROM microsoft/dotnet:latest
MAINTAINER Alexander van Trijffel

WORKDIR /var/www/netcorekestrelwebapp
ADD . /var/www/netcorekestrelwebapp
RUN dotnet restore

EXPOSE 5555
ENV ASPNETCORE_URLS https://*:5555

ENTRYPOINT ["dotnet", "run"] 

