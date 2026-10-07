FROM php:8.2-apache[cite: 2]

# Instalar extensiones de MySQL[cite: 2]
RUN docker-php-ext-install pdo pdo_mysql mysqli[cite: 2]

# Habilitar mod_rewrite y solucionar el error de múltiples MPM en Apache
RUN a2enmod rewrite && a2dismod mpm_event mpm_worker && a2enmod mpm_prefork

# Copiar todo el código[cite: 2]
COPY . /var/www/html/[cite: 2]

# Asignar permisos a todo el directorio web[cite: 2]
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html[cite: 2]

# Crear directorios de uploads y asignar permisos[cite: 2]
RUN mkdir -p /var/www/html/uploads/km_inicio \
    && mkdir -p /var/www/html/uploads/km_fin \
    && mkdir -p /var/www/html/uploads/hotel \
    && mkdir -p /var/www/html/uploads/caseta \
    && mkdir -p /var/www/html/uploads/comida \
    && mkdir -p /var/www/html/uploads/estacionamiento \
    && mkdir -p /var/www/html/uploads/gasolina \
    && mkdir -p /var/www/html/uploads/otros \
    && chown -R www-data:www-data /var/www/html/uploads \
    && chmod -R 755 /var/www/html/uploads[cite: 2]

# 👉 .htaccess para servir imágenes[cite: 2]
RUN echo "Options +Indexes" > /var/www/html/uploads/.htaccess \
    && echo "<FilesMatch \"\.(jpg|jpeg|png|gif)$\">" >> /var/www/html/uploads/.htaccess \
    && echo "    Order Allow,Deny" >> /var/www/html/uploads/.htaccess \
    && echo "    Allow from all" >> /var/www/html/uploads/.htaccess \
    && echo "</FilesMatch>" >> /var/www/html/uploads/.htaccess[cite: 2]

EXPOSE 80[cite: 2]
