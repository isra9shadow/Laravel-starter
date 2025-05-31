.PHONY: up down bash composer artisan test rebuild npm-install npm-dev migrate migrate-fresh seed session \
        config-clear cache-clear config-cache migrate-reset

# Iniciar los contenedores
up:
	docker compose up -d --build

# Detener los contenedores
down:
	docker compose down

# Acceder al contenedor app
bash:
	docker compose exec app bash

# Ejecutar comandos de Composer
composer:
	docker compose exec app composer $(cmd)

# Ejecutar comandos de Artisan
artisan:
	docker compose exec app php artisan $(cmd)

# Ejecutar tests
test:
	docker compose exec app php artisan test

# Reconstruir todo
rebuild:
	docker compose down -v && docker compose up -d --build

# Instalar dependencias NPM
npm-install:
	docker compose exec app npm install

# Ejecutar Vite en modo desarrollo
npm-dev:
	docker compose exec app npm run dev

# Migraciones
migrate:
	docker compose exec app php artisan migrate

migrate-fresh:
	docker compose exec app php artisan migrate:fresh

# Semillas
seed:
	docker compose exec app php artisan db:seed

# Crear tabla de sesiones
session:
	docker compose exec app php artisan session:table

# Limpiar configuración
config-clear:
	docker compose exec app php artisan config:clear

# Limpiar caché
cache-clear:
	docker compose exec app php artisan cache:clear

# Cachear configuración
config-cache:
	docker compose exec app php artisan config:cache

# Atajo para limpiar y volver a migrar desde cero
migrate-reset: config-clear cache-clear config-cache migrate-fresh

cache-all:
	docker compose exec app php artisan cache:clear
	docker compose exec app php artisan config:clear
	docker compose exec app php artisan route:clear
	docker compose exec app php artisan view:clear
