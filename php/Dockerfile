# 基础镜像
FROM php:7.4-fpm
# 设置工作目录
WORKDIR /var/www/html/im-server-web
# 拷贝项目代码-源码部署
COPY ../src /var/www/html/im-server-web
# 拷贝配置文件
COPY config.php /var/www/html/im-server-web/application/config/
COPY database.php /var/www/html/im-server-web/application/config/
# 安装常用扩展
RUN docker-php-ext-install mysqli mbstring
# 设置日志目录权限
RUN mkdir -p application/logs && chmod -R 777 application/logs

# 将 PHP 错误输出到 stdout
# RUN { \
#         echo "error_reporting = E_ALL"; \
#         echo "display_errors = On"; \
#         echo "log_errors = On"; \
#         echo "error_log = /proc/self/fd/2"; \
#     } > /usr/local/etc/php/conf.d/docker-php-errors.ini
