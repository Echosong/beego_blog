> **⚠️ 历史项目提示（必读）**：本项目基于 **2017 年的 beego v1 + GOPATH 模式**编写，当年在 Go 圈很流行（**566★ / 194 fork**），也是不少人的第一个 Go 项目。但它依赖的 `github.com/astaxie/beego` 已停止维护，**用现代的 `go mod` 直接 clone 大概率跑不起来**。为了方便新同学复现，仓库已提供 **Docker 一键运行**方案（见下方「三分钟跑起来」），无需配置 Go 环境与旧版 GOPATH。想要现代化版本的同学，可以看我的新项目 [轻巧之光 light](https://github.com/Echosong/light)（Spring Boot 低代码）。

# beego_blog

> 基于 **Go + beego v1 + layui** 的个人博客系统：文章、分类、评论、时间轴、单页、资源下载、后台管理，一套完整的「能用的」博客。

[![Stars](https://img.shields.io/github/stars/Echosong/beego_blog?style=flat-square&color=e3b341)](https://github.com/Echosong/beego_blog/stargazers)
[![Forks](https://img.shields.io/github/forks/Echosong/beego_blog?style=flat-square)](https://github.com/Echosong/beego_blog/network/members)
[![License](https://img.shields.io/badge/license-MIT-blue?style=flat-square)](LICENSE)
[![Go](https://img.shields.io/badge/Go-1.16%2B-00ADD8?style=flat-square&logo=go)](https://go.dev)
[![beego](https://img.shields.io/badge/beego-v1.x-00ADD8?style=flat-square)](https://github.com/astaxie/beego)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen?style=flat-square)](https://github.com/Echosong/beego_blog/pulls)

<!-- 把 docs/screenshot-home.png、docs/screenshot-admin.png 换成本仓库 doc 目录里的真实截图路径 -->
![前台首页](doc/screenshot-home.png) 

![后台管理](doc/screenshot-admin.png) 

## 特性

- 🎨 **前台**：首页 / 文章列表 / 文章详情 / 归档时间轴 / 关于我 / 单页 / 资源下载 / 评论区
- 🛠 **后台**：文章、分类、评论、单页、配置、用户管理（`beego.AutoRouter` 自动路由）
- 🧩 **layui 前端**：无需前端构建工具，改完静态文件刷新即生效
- 💬 **评论**：自带评论提交与审核（含 IP 记录）
- 📦 **零改造启动**：内置 `db_beego.sql` 完整建表 + 初始数据
- 🐳 **Docker 支持**：一键拉起 MySQL + 应用，不用装 Go 环境

## 三分钟跑起来（推荐 · Docker）

> 需要 Docker Desktop 或 Docker Engine + Compose。

```bash
git clone https://github.com/Echosong/beego_blog
cd beego_blog
docker compose up -d
```

启动完成后打开：

| 入口 | 地址 | 账号 |
|---|---|---|
| 博客前台 | http://localhost:8099 | — |
| 后台管理 | http://localhost:8099/admin/login | 见下 |

首次启动 MySQL 会自动导入 `db_beego.sql`（初始数据里包含管理员账号，**默认密码请以你导入的数据为准**；数据库表结构见 `db_beego.sql` 中 `tb_user` 表）。建议首次登录后立刻改密码。

停止 / 清空数据：

```bash
docker compose down       # 停止
docker compose down -v    # 停止并删除数据库数据（重置）
```

## 手动安装（GOPATH 老模式）

<details>
<summary>点开查看（如果你确实想用本机 Go 环境跑）</summary>

本项目是 **GOPATH 时代**的工程，没有 `go.mod`，必须放在 `$GOPATH/src/github.com/Echosong/beego_blog` 下：

```bash
# 1. 设置 GOPATH
export GOPATH=/path/to/gopath
mkdir -p $GOPATH/src/github.com/Echosong
cd $GOPATH/src/github.com/Echosong

# 2. 克隆到指定路径
git clone https://github.com/Echosong/beego_blog

# 3. 关闭 module 模式（关键，否则报找不到 astaxie/beego）
export GO111MODULE=off

# 4. 拉取依赖
go get github.com/astaxie/beego
go get github.com/astaxie/beego/orm
go get github.com/go-sql-driver/mysql

# 5. 建库并导入数据
mysql -uroot -p -e "CREATE DATABASE db_beego DEFAULT CHARSET utf8mb4;"
mysql -uroot -p db_beego < db_beego.sql

# 6. 修改 conf/app.conf 里的数据库连接，然后运行
go run main.go
```

**关于 `github.com/astaxie/beego/orm 这个包已经不存在了`**

这是最常见的报错（对应 [#22](https://github.com/Echosong/beego_blog/issues)）。原因与解法：

1. `astaxie/beego` 仓库已迁移到 `beego/beego`，但 **v1 的 tag 仍然存在**，旧源码并没有消失；
2. 真正的原因是 **你开了 module 模式**（Go 1.16+ 默认开启），它不会去 `$GOPATH` 里找包；
3. 解决：`export GO111MODULE=off`，并按上面的目录结构放置代码；
4. 如果你已经在 module 模式下，可以在 `go.mod` 中加一行绕过（不推荐，仅用于学习）：
   ```
   replace github.com/astaxie/beego => github.com/astaxie/beego v1.12.3
   ```
5. 想要生产可用、支持 `go mod` 的版本，请用 [Docker 方案](#三分钟跑起来推荐--docker) 或迁移到 [beego v2](https://github.com/beego/beego)。

</details>

## 目录结构

```
├── conf/            # 配置（app.conf：端口、MySQL 连接、表前缀）
├── controllers/     # 控制器：BlogController（前台）、AdminController（后台）
├── models/          # 数据模型 + models.Init() 初始化 ORM
├── routers/         # 路由注册
├── static/          # 静态资源：css / js / images / plug / ueditor
├── views/           # 模板视图
├── util/            # 工具函数
├── db_beego.sql     # 建表 + 初始数据
├── main.go          # 入口：models.Init() → beego.Run()
└── Dockerfile / docker-compose.yml
```

## 配置说明（`conf/app.conf`）

```ini
appname = beego_blog
httpport = 8099
runmode = dev

dbhost = localhost   # MySQL 地址
dbport = 3306
dbuser = root
dbpassword =
dbname = db_beego
dbprefix = tb_       # 表前缀，默认 tb_
```

> Docker 方案通过环境变量覆盖数据库地址（`dbhost` 等），不需要手改配置文件。

## 常见问题（FAQ）

| 问题 | 原因 / 解法 |
|---|---|
| `cannot find package "github.com/astaxie/beego/orm"` | 开了 module 模式或目录不在 GOPATH 内，见上方「手动安装」第 3、4 点 |
| 启动后页面 404 / 样式丢失 | `runmode = dev` 下确认 `static/` 目录完整；生产环境建议 `runmode = prod` |
| 后台登录入口找不到 | 地址是 `/admin/login`（不是 `/admin`） |
| 想用 Nginx 部署 | 反向代理到 `127.0.0.1:8099`，并把 `static/` 交给 Nginx 直接返回 |
| MySQL 8 连接报错 | 使用 `go-sql-driver/mysql` 1.5+ 并确认 `dbname` 已创建为 `utf8mb4` |

## 我的其他项目

- **[轻巧之光 light](https://github.com/Echosong/light)** —— 基于 Spring Boot 的面向对象建模低代码框架（新项目，欢迎尝鲜）
- **[DSH Desktop](https://github.com/Echosong/dsh-desktop-go)** —— 把 DeepSeek Harness 变成双击即用的 Windows 桌面应用
- **[ES](https://github.com/Echosong/ES)** —— 极简 PHP 框架（核心 400 行）
- **[beego_element_cms](https://github.com/Echosong/beego_element_cms)** —— beego v2 + Vue + Element 的 CMS / 官网方案
- **[wxpay](https://github.com/Echosong/wxpay)** —— 微信支付 PHP SDK（含企业红包）

## 贡献

欢迎提 Issue 和 PR。提问题时请附上：Go 版本、是否开启 module 模式、完整报错日志、MySQL 版本 —— 这样我能更快定位。

## License

[MIT](LICENSE) © Echosong

## 联系

- 邮箱：songfeigang@shhuayi.com
- Issues：https://github.com/Echosong/beego_blog/issues

> 如果这个项目帮你跑通了第一个 Go 博客，欢迎点一个 ⭐ —— 也让我知道该继续维护它。
