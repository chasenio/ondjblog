[![Codacy Badge](https://api.codacy.com/project/badge/Grade/af55ba73133e475593c72c88e55c3dbd)](https://app.codacy.com/manual/kentio/ondjblog?utm_source=github.com&utm_medium=referral&utm_content=kentio/ondjblog&utm_campaign=Badge_Grade_Dashboard)
# 使用 docker-compose 部署 [DjangoBlog](https://github.com/liangliangyy/DjangoBlog)[![Build Status](https://travis-ci.com/kentio/ondjblog.svg?branch=master)](https://travis-ci.com/kentio/ondjblog)

感谢[liangliangyy](https://github.com/liangliangyy)一直坚持不懈的更新和维护

使用docker-compose部署DjangoBlog、mariadb、nginx，免去繁琐的环境配置过程

重要：如果不具备Django migrate的知识，请不要盲目迁移数据，仅建议全新安装使用此方案，数据[方法](/docs/Migrate.md)

**前提：安装docker和docker-compose**
- [docker-compose](https://docs.docker.com/compose/install/)
- [docker](https://docs.docker.com/install/)

## 开始

```text
git clone https://github.com/kentio/ondjblog.git
```
or fork
```text
git clone https://github.com/<github username>/ondjblog.git
```


## 配置`.env_file`:
这个配置包含数据库账号，和Django运行的`SECRET_KEY`; `SECRET_KEY`可以为您的WEB服务提供基本的安全保障， [详见](https://docs.djangoproject.com/en/2.2/ref/settings/#std:setting-SECRET_KEY)

建议使用随机没有规则的字符, 并且不要使用他人`SECRET_KEY`。

```text
MYSQL_ROOT_PASSWORD=<your root password>    # 数据库的root密码
MYSQL_USER=djangoblog
MYSQL_PASSWORD=<your djangoblog password>    # 此blog使用的数据库账号
MYSQL_HOST=data    # 如果你使用自己的数据库请改成数据库地址,否则请不到改
BLOG_SECRET_KEY=<your djangoblog SECRET_KEY>    # Blog的`SECRET_KEY`
DOMAIN_NAME=<your domain name>    # 您的域名
```

如果将来域名发生变更请及时更改`DOMAIN_NAME`，然后`docker-compose up -d`

## 配置域名
配置文件是`blog.conf`, 请把文件中的`example.com` 改成您自己的域名。

```text
...
server {
        server_name example.com ;  < --- here
        root /var/www/DjangoBlog/;
...
```

注意: 以上提到的配置是必须的。

# 启动
```text
docker-compose up -d
```
即可。
查看服务日志
```text
docker-compose logs -f 
```
日志中如果出现：
```text
django.db.utils.OperationalError: (2003, "Can't connect to MySQL server on 'data' ([Errno 111] Connection refused)")
```
在数据库启动后把blog服务进行重启：
```text
docker-compose restart blog
```
出现下面的日志表示Blog服务成功创建数据表， 可以尝试访问你Blog
```text
blog_1   |     - Create model Comment
blog_1   | Migrations for 'oauth':
blog_1   |   oauth/migrations/0001_initial.py
blog_1   |     - Create model OAuthConfig
blog_1   |     - Create model OAuthUser
blog_1   | Operations to perform:
blog_1   |   Apply all migrations: accounts, admin, auth, blog, comments, contenttypes, oauth, owntracks, servermanager, sessions, sites
blog_1   | Running migrations:
blog_1   |   Applying contenttypes.0001_initial... OK
blog_1   |   Applying contenttypes.0002_remove_content_type_name... OK
blog_1   |   Applying auth.0001_initial... OK
blog_1   |   Applying auth.0002_alter_permission_name_max_length... OK
blog_1   |   Applying auth.0003_alter_user_email_max_length... OK
blog_1   |   Applying auth.0004_alter_user_username_opts... OK
blog_1   |   Applying auth.0005_alter_user_last_login_null... OK
blog_1   |   Applying auth.0006_require_contenttypes_0002... OK
blog_1   |   Applying auth.0007_alter_validators_add_error_messages... OK
blog_1   |   Applying auth.0008_alter_user_username_max_length... OK
blog_1   |   Applying auth.0009_alter_user_last_name_max_length... OK
blog_1   |   Applying accounts.0001_initial... OK
blog_1   |   Applying admin.0001_initial... OK
blog_1   |   Applying admin.0002_logentry_remove_auto_add... OK
blog_1   |   Applying admin.0003_logentry_add_action_flag_choices... OK
blog_1   |   Applying blog.0001_initial... OK
blog_1   |   Applying comments.0001_initial... OK
blog_1   |   Applying oauth.0001_initial... OK
blog_1   |   Applying owntracks.0001_initial... OK
blog_1   |   Applying servermanager.0001_initial... OK
blog_1   |   Applying sessions.0001_initial... OK
blog_1   |   Applying sites.0001_initial... OK
blog_1   |   Applying sites.0002_alter_domain_unique... OK
blog_1   | 
blog_1   | 0 static files copied to '/DjangoBlog/collectedstatic', 735 unmodified.
blog_1   | Compressing... done
blog_1   | Compressed 4 block(s) from 26 template(s) for 0 context(s).
blog_1   | init done.
```

# 创建用户
请替换为自己的用户名以及邮箱
```text
docker exec -it ondjblog_blog_1 python manage.py createsuperuser --user=<your user name> --email=<your email>
```
输入密码后，出现`Superuser created successfully.`用户就成功创建了

接下来就可以管理Blog了！

# 其它
- Blog的所有的数据都在宿主机的`/opt/obdjblog/`，建议定期备份此目录的数据
- clone 后您的数据修改请不要push，可以fork之后并设置为私有, 保存好自己配置