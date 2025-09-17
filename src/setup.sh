#!/bin/bash
# this is a setup scripts for web

PROJECT_PATH=..
SOURCE_PATH=.
SOURCE_CONF=$SOURCE_PATH/cconf

PROJECT_NAME=im-server-web              # 项目名称
PROJECT_SETUP_PATH=/var/www/html        # web代码路径
NGINX_CONF_PATH=/usr/local/nginx/conf/conf.d                                # nginx配置路径
DATABASE_CONF_PATH=$PROJECT_SETUP_PATH/$PROJECT_NAME/application/config # 数据库配置路径

FILE_NGINX_CONF=im.com.conf
FILE_MYSQL_CONF=database.php
FILE_MSFS_CONF=config.php

print_hello() {
    echo "==========================================="
    echo "$1 im web for TeamTalk"
    echo "==========================================="
}

check_user() {
    if [ $(id -u) != "0" ]; then
        echo "Error: You must be root to run this script, please use root to install im_web"
        exit 1
    fi
}

pack_web() {
    echo "[INFO] Packing project..."
    cd $PROJECT_PATH
    rm -rf $PROJECT_NAME $PROJECT_NAME.zip
    cp -ar src $PROJECT_NAME
    zip -r $PROJECT_NAME.zip $PROJECT_NAME
    rm -rf $PROJECT_NAME
    echo "[INFO] Pack finished: $PROJECT_NAME.zip"
}

build_web() {
    echo "[INFO] Starting deployment..."

    # 历史部署移除
    echo "[INFO] Removing old deployment..."
    rm -rf $PROJECT_SETUP_PATH/$PROJECT_NAME/

    # 源代码部署
    echo "[INFO] Copying php project files..."
    sudo mkdir -p $PROJECT_SETUP_PATH/$PROJECT_NAME/
    cp -r ./* "$PROJECT_SETUP_PATH/$PROJECT_NAME/"

    # 更新系统配置
    echo "[INFO] Copying config files..."
    cp $SOURCE_CONF/$FILE_MYSQL_CONF $DATABASE_CONF_PATH/
    cp $SOURCE_CONF/$FILE_MSFS_CONF $DATABASE_CONF_PATH/

    # Nginx相关配置
    echo "[INFO] Updating nginx config..."
    rm -f $NGINX_CONF_PATH/default.conf
    cp $SOURCE_CONF/$FILE_NGINX_CONF $NGINX_CONF_PATH/

    echo "[INFO] Setting permissions..."
    chmod -R 777 $PROJECT_SETUP_PATH/$PROJECT_NAME/

    echo "[INFO] Reloading nginx..."
    systemctl reload nginx.service || systemctl restart nginx.service
    # systemctl stop nginx.service 
    # systemctl start nginx.service

    echo "[INFO] Deployment finished successfully." 
}

print_help() {
    echo "Usage: "
    echo "  $0 check --- check environment"
    echo "  $0 install --- check & run scripts to install"
}

case $1 in
    install)
        print_hello $1
        check_user
        build_web
        ;;
    pack)
        print_hello $1
        check_user
        pack_web
        ;;
    *)
    print_help
    ;;
esac

