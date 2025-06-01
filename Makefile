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
	@echo "🔍 Verificando si rsync está instalado..."
	if ! command -v rsync >/dev/null 2>&1; then \
		echo "⚠️  rsync no está instalado. Instalando..."; \
		sudo apt-get update && sudo apt-get install -y rsync || { echo "❌ Error al instalar rsync"; exit 1; }; \
	fi

	@echo "🧪 Verificando existencia de Laravel..."
	if [ ! -f artisan ]; then \
		echo "📦 Laravel no está instalado. Creando proyecto temporal..."; \
		if ! command -v composer >/dev/null 2>&1; then \
			echo "❌ Composer no está instalado. Instálalo primero."; \
			exit 1; \
		fi; \
		composer create-project laravel/laravel laravel-temp; \
		echo "📂 Moviendo archivos de laravel-temp a raíz..."; \
		rsync -a laravel-temp/ ./ && find laravel-temp -type f -delete && find laravel-temp -type d -empty -delete && rmdir laravel-temp 2>/dev/null || true; \
		echo "🧼 Eliminando .env autogenerado por Laravel..."; \
		rm -f .env; \
	fi

	@echo "📄 Copiando .env.example.local -> .env"
	cp --update=none .env.example.local .env
	cp --update=none .gitignore.example.local .gitignore
	
	@echo "🧩 Insertando UID y GID en .env"
	sed -i '/^HOST_UID=/d' .env
	sed -i '/^HOST_GID=/d' .env
	echo "HOST_UID=$(shell id -u)" >> .env
	echo "HOST_GID=$(shell id -g)" >> .env

	@echo "📦 Instalando dependencias PHP localmente..."
	composer install

	@echo "🐳 Levantando contenedores Docker..."
	docker compose up -d --build
	@echo "🔐 Generando clave APP_KEY..."
	docker compose exec app php artisan key:generate

		@echo "🛠️  Generando tabla de sesiones si SESSION_DRIVER=database"
	if grep -q "^SESSION_DRIVER=database" .env; then \
		if ! find database/migrations -name '*_create_sessions_table.php' | grep -q .; then \
			echo "📥 Creando migración de sesiones..."; \
			docker compose exec app php artisan session:table; \
		else \
			echo "ℹ️  La migración de sesiones ya existe."; \
		fi; \
		echo "📦 Ejecutando migraciones..."; \
		docker compose exec app php artisan migrate; \
	else \
		echo "ℹ️  SESSION_DRIVER no es 'database', se omite la migración de sesiones."; \
	fi