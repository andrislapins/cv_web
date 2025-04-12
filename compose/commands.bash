
gradle -v

docker compose down --volumes --remove-orphans
docker compose down --volumes --remove-orphans && docker compose up
docker compose down --volumes --remove-orphans && docker compose up --build

clear && docker compose down --volumes --remove-orphans && docker compose -f docker-compose.yml -f docker-compose.temporal.yml -f docker-compose.otel.yml -f docker-compose.grafana.yml up --build


sudo chown -R 35000:35000 ./logs



sudo apt install prometheus-alertmanager
amtool --alertmanager.url=http://localhost:9093/ alert add alertname="demo-alerts" severity="cv-web-telegram-test" job="test-alert" instance="localhost" exporter="none" cluster="test"



docker rmi -f $(docker images -q)
docker system prune -a --volumes


# Check locally ran test results
xdg-open file:///.../vite-react-ts-eslint/cv-web-backend/build/reports/tests/test/index.html