FROM php:8.2-apache

# 1. Esto fuerza a Railway a ignorar el caché viejo y construir desde cero
ENV CACHE_BUSTER=1

# 2. Instalar extensiones de MySQL
RUN docker-php-ext-install pdo pdo_mysql mysqli

# 3. Limpieza extrema: Borramos cualquier rastro de MPM y forzamos SOLO prefork
RUN rm -f /etc/apache2/mods-enabled/mpm_*.load \
    && rm -f /etc/apache2/mods-enabled/mpm_*.conf \
    && a2enmod mpm_prefork rewrite

# 4. Copiar todo tu código
COPY . /var/www/html/

# 5. Crear directorios de uploads y asignar permisos a Apache
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
