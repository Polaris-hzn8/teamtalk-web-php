# readme

---

TeamTalk整套服务提供模块部署脚本和一键部署方案，主要模块有NGINX，PHP，MYSQL，REDIS，IM_WEB，IM_SERVER，其中IM_WEB，IM_SERVER为自主开发模块，其余模块均为开源解决方案，各个模块需要手动改动的地方如下：

### IM_WEB 

```
在conf目录下包含了config.php, database.php, im.com.conf三个配置文件,其中im.com.conf为NGINX所需要的配置文件,建议不改动
config.php文件主要配置了msfs服务器的地址，修改$config['msfs_url']参数即可
dababase.php文件主要配置了链接MARIADB所需要的参数,根据自己的需求修改'hostname','username','password'这三个参数。
如果使用的是现有的nginx+php环境,可以修改setup.sh中的 PHP_WEB_SETUP_PATH为nginx放置web代码的路径,
并且将PHP_NGINX_CONF_PATH修改为nginx配置文件的路径然后执行setup.sh脚本即可
```













