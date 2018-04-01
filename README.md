# messageBoard

A web messageBoard

java


2018.03
按MVC规范改进，jsp页面只作为表现层。
用户登录由原来使用cookie保存登录状态更改为使用session。
新增Ajax实时判断注册用户名是否占用的动态效果。
Spring以及springMVC全部改为注解方式开发。
由于MyBatis使用了较多关联关系查询，使用注解方式不方便，故仍使用配置式开发。
