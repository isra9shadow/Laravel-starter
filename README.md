# Laravel Starter con Docker 🐳 + PHP + MySQL + NGINX

Este proyecto es un punto de partida listo para usar Laravel en un entorno Docker profesional, ideal para desarrollo local con PHP 8.2, MySQL 8 y NGINX.

---

## 📁 Estructura de carpetas

```
laravel-starter/
├── docker/               # Configuración de Docker (nginx, php, etc.)
│   ├── nginx/
│   │   └── default.conf
│   └── php/
│       └── Dockerfile
├── src/                  # Código fuente de Laravel (puede clonarse o crearse aquí)
├── .env                  # Variables de entorno del host (UID/GID)
├── .env.example
├── docker-compose.yml
├── Makefile              # Comandos útiles
└── README.md
```

---

## 🚀 Requisitos

- Docker y Docker Compose instalados
- GNU Make (`make`)
- Linux o WSL recomendado (funciona en macOS)

---

## ⚙️ Preparación inicial

1. **Clona este repositorio:**

```bash
git clone https://github.com/tuusuario/laravel-starter.git
cd laravel-starter
```

2. **Crea el archivo `.env`:**

```bash
cp .env.example .env
```

3. **Establece UID y GID (Linux):**

Edita `.env` con los valores de tu usuario:

```dotenv
UID=1000
GID=1000
```

Puedes obtenerlos con:

```bash
echo UID=$(id -u)
echo GID=$(id -g)
```

---

## 📦 Comandos disponibles

Usamos `make` para simplificar la gestión del entorno:

| Comando         | Descripción                                         |
|----------------|-----------------------------------------------------|
| `make build`   | Construye los contenedores (sin bajar volúmenes)    |
| `make rebuild` | Elimina todo y construye desde cero (`down -v`)     |
| `make up`      | Levanta los servicios (`docker compose up -d`)      |
| `make down`    | Detiene y elimina los contenedores                  |
| `make bash`    | Abre una terminal dentro del contenedor de Laravel |
| `make logs`    | Muestra logs de todos los servicios                 |

---

## 🧪 Crear proyecto Laravel desde cero

Desde el contenedor PHP:

```bash
make bash
composer create-project laravel/laravel .
exit
```

Luego, asegúrate de que existan los directorios necesarios:

```bash
mkdir -p src/storage src/bootstrap/cache
chmod -R 775 src/storage src/bootstrap/cache
```

---

## 🌐 Acceder a la app

Una vez levantado con `make up`, accede desde tu navegador:

```
http://localhost:8080
```

---

## 🗄️ Base de datos

- Host: `mysql`
- Usuario: `laravel`
- Contraseña: `laravel`
- Base de datos: `laravel`
- Puerto: `3306`

Configura `.env` dentro de `src/` con estos datos:

```dotenv
DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=laravel
DB_USERNAME=laravel
DB_PASSWORD=laravel
```

---

## ✅ Buenas prácticas

- Nunca edites directamente los archivos dentro del contenedor.
- Usa `src/` como la raíz de tu proyecto Laravel.
- Añade `vendor/` y `.env` al `.gitignore`.
- Puedes usar PHPUnit o Pest para testing; ambos son compatibles.

---

## 🧹 Mantenimiento

Para limpiar y reconstruir el entorno completo:

```bash
make rebuild
```

---

## 📦 Paquetes comunes en Laravel

### 🔐 Autenticación y Seguridad

- **Laravel Breeze**  
  Scaffold simple para autenticación.  
  `composer require laravel/breeze --dev && php artisan breeze:install`

- **Laravel Sanctum**  
  API tokens y autenticación para SPA.  
  `composer require laravel/sanctum`

- **Laravel Passport**  
  Autenticación OAuth2 para APIs REST.  
  `composer require laravel/passport`

---

### 🧪 Testing

- **Pest**  
  Framework de testing más legible.  
  `composer require pestphp/pest --dev`

- **Laravel IDE Helper**  
  Autocompletado en IDEs (PHPStorm, etc.).  
  `composer require --dev barryvdh/laravel-ide-helper`

---

### 🔍 Debug y desarrollo

- **Laravel Debugbar**  
  Barra de depuración.  
  `composer require barryvdh/laravel-debugbar --dev`

- **Clockwork**  
  Alternativa a Debugbar para inspección.  
  `composer require itsgoingd/clockwork --dev`

---

### 🧰 Utilidades

- **Spatie Laravel Permission**  
  Roles y permisos.  
  `composer require spatie/laravel-permission`

- **Laravel Excel**  
  Importación/exportación de Excel.  
  `composer require maatwebsite/excel`

- **Spatie Media Library**  
  Asociar archivos a modelos.  
  `composer require spatie/laravel-medialibrary`

- **Laravel Backup**  
  Backups automáticos.  
  `composer require spatie/laravel-backup`

- **Laravel Sluggable**  
  Slugs automáticos para URLs.  
  `composer require cviebrock/eloquent-sluggable`

---

### 📬 Notificaciones y colas

- **Laravel Horizon**  
  Dashboard de colas con Redis.  
  `composer require laravel/horizon`

- **Laravel Mail Preview**  
  Previsualiza emails localmente.  
  `composer require beyondcode/laravel-mailbox`

---

## 📄 Licencia

Este starter es de uso libre para tus proyectos.

---

## ✍ Autor

Israel ([@isra9shadow](https://github.com/isra9shadow))# Laravel Starter con Docker 🐳 + PHP + MySQL + NGINX

Este proyecto es un punto de partida listo para usar Laravel en un entorno Docker profesional, ideal para desarrollo local con PHP 8.2, MySQL 8 y NGINX.

---

## 📁 Estructura de carpetas

```
laravel-starter/
├── docker/               # Configuración de Docker (nginx, php, etc.)
│   ├── nginx/
│   │   └── default.conf
│   └── php/
│       └── Dockerfile
├── src/                  # Código fuente de Laravel (puede clonarse o crearse aquí)
├── .env                  # Variables de entorno del host (UID/GID)
├── .env.example
├── docker-compose.yml
├── Makefile              # Comandos útiles
└── README.md
```

---

## 🚀 Requisitos

- Docker y Docker Compose instalados
- GNU Make (`make`)
- Linux o WSL recomendado (funciona en macOS)

---

## ⚙️ Preparación inicial

1. **Clona este repositorio:**

```bash
git clone https://github.com/tuusuario/laravel-starter.git
cd laravel-starter
```

2. **Crea el archivo `.env`:**

```bash
cp .env.example .env
```

3. **Establece UID y GID (Linux):**

Edita `.env` con los valores de tu usuario:

```dotenv
UID=1000
GID=1000
```

Puedes obtenerlos con:

```bash
echo UID=$(id -u)
echo GID=$(id -g)
```

---

## 📦 Comandos disponibles

Usamos `make` para simplificar la gestión del entorno:

| Comando         | Descripción                                         |
|----------------|-----------------------------------------------------|
| `make build`   | Construye los contenedores (sin bajar volúmenes)    |
| `make rebuild` | Elimina todo y construye desde cero (`down -v`)     |
| `make up`      | Levanta los servicios (`docker compose up -d`)      |
| `make down`    | Detiene y elimina los contenedores                  |
| `make bash`    | Abre una terminal dentro del contenedor de Laravel |
| `make logs`    | Muestra logs de todos los servicios                 |

---

## 🧪 Crear proyecto Laravel desde cero

Desde el contenedor PHP:

```bash
make bash
composer create-project laravel/laravel .
exit
```

Luego, asegúrate de que existan los directorios necesarios:

```bash
mkdir -p src/storage src/bootstrap/cache
chmod -R 775 src/storage src/bootstrap/cache
```

---

## 🌐 Acceder a la app

Una vez levantado con `make up`, accede desde tu navegador:

```
http://localhost:8080
```

---

## 🗄️ Base de datos

- Host: `mysql`
- Usuario: `laravel`
- Contraseña: `laravel`
- Base de datos: `laravel`
- Puerto: `3306`

Configura `.env` dentro de `src/` con estos datos:

```dotenv
DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=laravel
DB_USERNAME=laravel
DB_PASSWORD=laravel
```

---

## ✅ Buenas prácticas

- Nunca edites directamente los archivos dentro del contenedor.
- Usa `src/` como la raíz de tu proyecto Laravel.
- Añade `vendor/` y `.env` al `.gitignore`.
- Puedes usar PHPUnit o Pest para testing; ambos son compatibles.

---

## 🧹 Mantenimiento

Para limpiar y reconstruir el entorno completo:

```bash
make rebuild
```

---

## 📦 Paquetes comunes en Laravel

### 🔐 Autenticación y Seguridad

- **Laravel Breeze**  
  Scaffold simple para autenticación.  
  `composer require laravel/breeze --dev && php artisan breeze:install`

- **Laravel Sanctum**  
  API tokens y autenticación para SPA.  
  `composer require laravel/sanctum`

- **Laravel Passport**  
  Autenticación OAuth2 para APIs REST.  
  `composer require laravel/passport`

---

### 🧪 Testing

- **Pest**  
  Framework de testing más legible.  
  `composer require pestphp/pest --dev`

- **Laravel IDE Helper**  
  Autocompletado en IDEs (PHPStorm, etc.).  
  `composer require --dev barryvdh/laravel-ide-helper`

---

### 🔍 Debug y desarrollo

- **Laravel Debugbar**  
  Barra de depuración.  
  `composer require barryvdh/laravel-debugbar --dev`

- **Clockwork**  
  Alternativa a Debugbar para inspección.  
  `composer require itsgoingd/clockwork --dev`

---

### 🧰 Utilidades

- **Spatie Laravel Permission**  
  Roles y permisos.  
  `composer require spatie/laravel-permission`

- **Laravel Excel**  
  Importación/exportación de Excel.  
  `composer require maatwebsite/excel`

- **Spatie Media Library**  
  Asociar archivos a modelos.  
  `composer require spatie/laravel-medialibrary`

- **Laravel Backup**  
  Backups automáticos.  
  `composer require spatie/laravel-backup`

- **Laravel Sluggable**  
  Slugs automáticos para URLs.  
  `composer require cviebrock/eloquent-sluggable`

---

### 📬 Notificaciones y colas

- **Laravel Horizon**  
  Dashboard de colas con Redis.  
  `composer require laravel/horizon`

- **Laravel Mail Preview**  
  Previsualiza emails localmente.  
  `composer require beyondcode/laravel-mailbox`

---

## 📄 Licencia

Este starter es de uso libre para tus proyectos.

---

## ✍ Autor

Israel ([@isra9shadow](https://github.com/isra9shadow))