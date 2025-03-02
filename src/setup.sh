#!/bin/bash
# this is a setup scripts for web

PHP_WEB=im-server-web
PHP_WEB_SETUP_PATH=/var/www/html        # web代码路径
PHP_NGINX_CONF_PATH=/usr/local/nginx/conf/conf.d
PHP_DB_CONF_PATH=$PHP_WEB_SETUP_PATH/$PHP_WEB/application/config

PHP_DB_CONF=database.php
PHP_MSFS_CONF=config.php
PHP_NGINX_CONF=im.com.conf

print_hello(){
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
    cd ../
    rm -rf $PHP_WEB
    rm -rf $PHP_WEB.zip
    cp -ar src $PHP_WEB
    zip -r $PHP_WEB.zip $PHP_WEB
    rm -rf $PHP_WEB
}

build_web(){
    # 解压源码包
    # if [ -d $PHP_WEB ]; then
    #     echo "$PHP_WEB has existed."
    # else
    #     unzip $PHP_WEB.zip
    #     if [ $? -eq 0 ]; then
    #         echo "unzip $PHP_WEB successed."
    #     else
    #         echo "Error: unzip $PHP_WEB failed."
    #         return 1
    #     fi
    # fi

    # 历史部署移除
    rm -rf $PHP_WEB_SETUP_PATH/$PHP_WEB/

    # 源码部署 Nginx-Web目录
    set -x
    mkdir -p $PHP_WEB_SETUP_PATH
    cp -r ../$PHP_WEB/ $PHP_WEB_SETUP_PATH
    cp ./tools/$PHP_DB_CONF $PHP_DB_CONF_PATH/
    cp ./tools/$PHP_MSFS_CONF $PHP_DB_CONF_PATH/
    set +x

    # 移除 default.conf
    if [ -f $PHP_NGINX_CONF_PATH/default.conf ]; then
        rm $PHP_NGINX_CONF_PATH/default.conf
        echo "remove $PHP_NGINX_CONF_PATH/default.conf successed."
    fi

    # Nginx相关配置
    set -x
    cp ./tools/$PHP_NGINX_CONF $PHP_NGINX_CONF_PATH/
    set +x

    chmod -R 777 $PHP_WEB_SETUP_PATH/$PHP_WEB/

    systemctl stop nginx.service 
    systemctl start nginx.service 
    return 0
}

print_help() {
    echo "Usage: "
    echo "  $0 check --- check environment"
    echo "  $0 install --- check & run scripts to install"
}

case $1 in
    check)
        print_hello $1
        check_user
        ;;
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

