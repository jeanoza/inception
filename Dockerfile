FROM ubuntu
RUN apt update && apt install -y python3
WORKDIR /var/www/
COPY ["src/index.html", "."]
CMD [ "python3", "-u", "-m", "http.server" ]