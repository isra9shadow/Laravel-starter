.PHONY: up down bash composer artisan test rebuild npm-install npm-dev migrate migrate-fresh seed session \
        config-clear cache-clear config-cache migrate-reset cache-all reset init

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

# Limpiar y volver a migrar desde cero
migrate-reset: config-clear cache-clear config-cache migrate-fresh

# Limpiar todos los tipos de caché
cache-all:
	docker compose exec app php artisan cache:clear
	docker compose exec app php artisan config:clear
	docker compose exec app php artisan route:clear
	docker compose exec app php artisan view:clear

# Limpiar todo el entorno (excepto docker y config del proyecto)
reset:
	@echo "🧨 Eliminando contenedores, volúmenes y redes de Docker..."
	docker compose down -v --remove-orphans
	@echo "🧹 Eliminando archivos del proyecto Laravel..."
	sudo rm -rf app bootstrap config database lang public resources routes storage tests vendor node_modules \
	artisan composer.* package.json phpunit.xml server.php .env vite.config.js tailwind.config.js postcss.config.js package-lock.json
	@echo "🔄 Restaurando archivos versionados..."
	git restore .


# Inicializar proyecto Laravel con entorno Docker
init:
	@if [ ! -f .env ]; then \
		echo "📄 Copiando .env.example -> .env"; \
		cp .env.example .env; \
	fi && \
	if ! grep -q "UID=" .env; then \
		echo "🧩 Añadiendo UID y GID al .env"; \
		echo "" >> .env; \
		echo "UID=$$(id -u)" >> .env; \
		echo "GID=$$(id -g)" >> .env; \
	fi && \
	if [ ! -f artisan ]; then \
		echo "🚀 Creando nuevo proyecto Laravel..."; \
		mkdir -p src && \
		docker compose run --rm app composer create-project laravel/laravel src && \
		mv src/* src/.* . 2>/dev/null || true && \
		rm -rf src; \
	fi && \
	echo "📦 Instalando dependencias..."; \
	docker compose run --rm app composer install && \
	echo "🐳 Levantando contenedores..."; \
	docker compose up -d && \
	echo "🔐 Generando clave de aplicación..."; \
	docker compose exec app php artisan key:generate && \
	echo "🔧 Ajustando permisos..."; \
	docker compose exec app chmod -R 775 storage bootstrap/cache

