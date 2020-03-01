# 数据迁移

数据备份、导入过程中如果出现问题，请发[issues](https://github.com/kentio/ondjblog/issues/new)

## 备份Blog数据
```text
python manage.py dumpdata  >  blog_bak_1.json
```

## 导入数据

```text
python manage.py loaddata blog_bak_1.json
```