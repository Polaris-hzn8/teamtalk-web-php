# 基础镜像
FROM php:7.4-fpm
# 设置工作目录
WORKDIR /var/www/html/im-server-web
# 拷贝项目代码-源码部署
COPY src /var/www/html/im-server-web
# 拷贝配置文件
COPY php/config.php /var/www/html/im-server-web/application/config/
COPY php/database.php /var/www/html/im-server-web/application/config/
# 安装系统依赖和PHP扩展
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libzip-dev \
    zip \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd mysqli mbstring pdo pdo_mysql zip
# 设置日志目录权限
RUN mkdir -p application/logs && chmod -R 777 application/logs

