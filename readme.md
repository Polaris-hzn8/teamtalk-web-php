# teamtalk-webadmin-php

---

本项目是teamtalk的web管理平台，由php语言开发

目录结构：

1. application：业务实现
    - config配置类
    - controller控制器
    - view视图
    - model数据模型
2. system：业务支持作为构建项目的基础支持，提供类库、模型、工具类等基础服务
    - core核心框架
    - databases数据库驱动类
    - helpers辅助函数目录
    - libraries工具类
3. ui：静态资源、样式、方法
    - css样式
    - img图片
    - js文件

```
php:.
├─application
│  ├─cache
│  ├─config
│  ├─controllers
│  ├─core
│  ├─errors
│  ├─helpers
│  ├─hooks
│  ├─language
│  │  └─english
│  ├─libraries
│  ├─logs
│  ├─models
│  ├─third_party
│  └─views
│      ├─auth
│      └─base
├─download
├─system
│  ├─core
│  ├─database
│  │  └─drivers
│  │      ├─cubrid
│  │      ├─mssql
│  │      ├─mysql
│  │      ├─mysqli
│  │      ├─oci8
│  │      ├─odbc
│  │      ├─pdo
│  │      ├─postgre
│  │      ├─sqlite
│  │      └─sqlsrv
│  ├─fonts
│  ├─helpers
│  ├─language
│  │  └─english
│  └─libraries
│      ├─Cache
│      │  └─drivers
│      └─javascript
└─ui
    ├─css
    ├─fonts
    └─js
```

项目支持本地部署与容器化部署：
1.本地部署：setup.sh
2.容器化部署：docker