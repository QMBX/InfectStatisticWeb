# InfectStatisticWeb
某次疫情统计可视化

# 构建和运行
 + #### 运行环境
    Tomcat9.0以上版本, eclipse-jee, Java EE 11, MySQL 8.0

 + #### 如何构建
    0. 配置eclipse，添加Tomcat服务器
    1. 在MySQL中运行`SQL`目录下的最新版本sql文件。
    2. 在eclipse中新建Java项目，将仓库中`Java\src`目录下的文件添加到项目，并将仓库中`Java\jar`下的jar包导入项目中。
    3. 将项目中的`DBUtil.java`文件中的`DBUtil`类的静态成员`loginName`和`password`修改成MySQL的用户名与密码。
    4. 运行FirstCrawler，获取全国数据和各省份数据到MySQL数据库
    5. 在eclipse中新建动态web工程(Dynamic Web Project)，项目名为Web,将仓库中`Web\src`中文件放在项目中`Java Resources`的`src`目录下，将仓库中`Web\WebContent`覆盖项目中的`WebContent`目录
    6. 在Eclipse中将Web项目`Java Resources`中的`src`目录下`util`包中的`DBUtil.java`文件中的`DBUtil`类的静态成员`loginName`和`password`也修改成MySQL的用户名与密码。
    7. 在eclipse中使用Tomcat服务器启动项目后，在浏览器中输入`http://localhost:8080/Web/China`即可访问首页