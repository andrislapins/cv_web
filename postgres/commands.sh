
openssl genrsa -out server.key 2048
openssl req -new -key server.key -out server.csr -subj "/CN=postgres"
openssl x509 -req -in server.csr -signkey server.key -out server.crt -days 365
chmod 600 server.key
chmod 644 server.crt

SELECT ssl FROM pg_stat_ssl WHERE pid = pg_backend_pid();

docker exec -it postgres psql -U postgres -d cv_web_db