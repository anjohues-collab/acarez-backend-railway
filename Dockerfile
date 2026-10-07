FROM php:8.2-apache

# Instalar extensiones de MySQL
RUN docker-php-ext-install pdo pdo_mysql mysqli

# Habilitar mod_rewrite únicamente (mpm_prefork ya viene activo por defecto)
RUN a2enmod rewrite

# Copiar todo el código
COPY . /var/www/html/

# Crear directorios de uploads y asignar permisos a Apache
RUN mkdir -p /var/www/html/uploads/km_inicio \
    /var/www/html/uploads/km_fin \
    /var/www/html/uploads/hotel \
    /var/www/html/uploads/caseta \
    /var/www/html/uploads/comida \
    /var/www/html/uploads/estacionamiento \
    /var/www/html/uploads/gasolina \
    /var/www/html/uploads/otros \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

EXPOSE 80
