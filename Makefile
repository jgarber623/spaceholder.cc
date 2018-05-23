build:
	docker build -t spaceholder.cc .

run: build
	docker run --rm -it -v $(shell pwd):/app -p 9393:9393 --name spaceholder.cc spaceholder.cc

shell:
	docker exec -it spaceholder.cc /bin/bash
