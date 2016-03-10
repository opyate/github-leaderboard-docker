.PHONY: build start update clean

build:
	@docker build -t github-leaderboard .

start:
	@docker run --rm -it \
		-p $${PORT:-8888}:8888 \
		-v $(shell pwd):/tmp/run \
		github-leaderboard ./run.sh 

update:
	@./update-repos.sh ${ARGS}

clean:
	rm -rf .cache config.js
