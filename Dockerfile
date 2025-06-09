FROM php:8.2-fpm

# Install dependencies dan mysql-client
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip \
    unzip \
    default-mysql-client \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html
COPY . .

# Install Laravel dependencies
RUN composer install --no-dev --optimize-autoloader

# Set permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Copy script init-db.sh dan beri permission executable
COPY init-db.sh /usr/local/bin/init-db.sh
RUN chmod +x /usr/local/bin/init-db.sh

EXPOSE 8000

# Jalankan init-db.sh dulu, lalu Laravel serve
ENTRYPOINT ["/usr/local/bin/init-db.sh"]
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"] 
