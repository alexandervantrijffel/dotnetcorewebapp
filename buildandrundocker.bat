docker build -t dotnetcorewebapp .
docker run --rm -ti --name dotnetcorewebapp -p 5555:5555 dotnetcorewebapp