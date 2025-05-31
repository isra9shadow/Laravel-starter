FROM php:8.2-fpm

# Dependencias de sistema
RUN apt-get update && apt-get install -y \
    zip unzip git curl libzip-dev libonig-dev libxml2-dev libpq-dev libpng-dev \
    && docker-php-ext-install pdo pdo_mysql zip

# Instalar extensión phpredis
RUN pecl install redis \
    && docker-php-ext-enable redis

# Instalar Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Instalar Node.js y npm
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# Fijar directorio de trabajo
WORKDIR /var/www
