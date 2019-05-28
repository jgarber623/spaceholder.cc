.PHONY: build, deploy, install

.DEFAULT_GOAL := install

build:
	@echo '=> Building and submitting image to Google Cloud Registry...'
	gcloud builds submit --tag gcr.io/${PROJECT_ID}/spaceholder-cc-web

deploy:
	@echo '=> Deploying container to Google Cloud Run...'
	gcloud beta run deploy --image gcr.io/${PROJECT_ID}/spaceholder-cc-web

install:
	@echo '=> Installing Ruby dependencies with Bundler...'
	bundle install
	@echo '=> Installing Node dependencies with npm...'
	npm install
