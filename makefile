server:
	lsof -t -i tcp:8090 | xargs kill -9
	docker compose up -d