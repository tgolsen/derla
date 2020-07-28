.EXPORT_ALL_VARIABLES:
    COMPOSE_PROJECT_NAME=local

-include .env

# Makefile: local environment conveniences
# env - for local, copy .env.example for a typical setup
# init - meant to take you from `git clone` to ready to serve local install
# open - start local server and open site
# start - env & init & open

env:
	cp -n .env.example .env && echo ".env created" || echo ".env exists"

init:
	composer global require hirak/prestissimo
	composer update --prefer-source -vvv
	@-mysql -h ${DB_HOST} -u${DB_USERNAME} -p${DB_PASSWORD} -e "CREATE DATABASE ${DB_DATABASE};"
	php artisan migrate
	npm install
	npm run

open:
	php artisan serve &
	open -a 'Google Chrome' 'http://127.0.0.1:8000'

start: env init open
