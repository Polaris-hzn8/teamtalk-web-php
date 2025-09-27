FROM php:7.4-fpm

WORKDIR /var/www/html/im-server-web

# 复制配置文件
COPY php/config.php application/config/
COPY php/database.php application/config/

# 复制项目源码
COPY src/ .

# 安装依赖并编译 PHP 扩展
RUN apt-get update && apt-get install -y --no-install-recommends \
        libpng-dev \
        libjpeg-dev \
        libfreetype6-dev \
        libzip-dev \
        zlib1g-dev \
        libwebp-dev \
        pkg-config \
        zip unzip \
        git \
        libonig-dev; \
    docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp; \
    docker-php-ext-install -j"$(nproc)" gd pdo pdo_mysql mysqli mbstring zip; \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# 设置日志目录
RUN mkdir -p application/logs && chmod -R 777 application/logs

EXPOSE 9000
CMD ["php-fpm"]