package controllers

import (
	"github.com/Echosong/beego_blog/models"
	"github.com/Echosong/beego_blog/util"
	"time"
)

type BlogController struct {
	baseController
}

func (c *BlogController) list()  {
	var (
		page       int
		pagesize   int = 6
		offset     int
		list       []*models.Post
		hosts      [] *models.Post
		cateId int
		keyword    string
	)

	categorys := [] *models.Category{}
	c.o.QueryTable( new(models.Category).TableName()).All(&categorys)
	c.Data["cates"] = categorys

	if page, _ = c.GetInt("page"); page < 1 {
		page = 1
	}
	offset = (page - 1) * pagesize
	query := c.o.QueryTable(new(models.Post).TableName())

	if c.actionName == "resource" {
		query = query.Filter("types", 0)
	}else{
		query = query.Filter("types", 1)
	}

	if cateId, _ = c.GetInt("cate_id"); cateId != 0 {
		query =  query.Filter("category_id", cateId)
	}
	keyword = c.Input().Get("keyword")
	if keyword != "" {
		query = query.Filter("title__contains", keyword)
	}
	query.OrderBy("-views").Limit(10, 0).All(&hosts)

	if c.actionName == "home" {
		query = query.Filter("is_top", 1)
	}
	count, _ := query.Count()
	c.Data["count"] = count
	query.OrderBy( "-created").Limit(pagesize, offset).All(&list)

	c.Data["list"] = list
	c.Data["pagebar"] = util.NewPager(page, int(count), pagesize,"/"+c.actionName, true).ToString()
	c.Data["hosts"] = hosts
}

/**
首页
*/
func (c *BlogController) Home()  {
	c.list()
	c.TplName= c.controllerName+"/home.html"
}

/**
列表页面
 */
func (c *BlogController) Article() {
	c.list()
	c.TplName = c.controllerName+ "/article.html"
}

/**
详情
 */
func (c *BlogController) Detail()  {
	if id, _ := c.GetInt("id"); id != 0{
		post := models.Post{Id:id}
		c.o.Read(&post)
		c.Data["post"] = post
		comments := [] *models.Comment{}
		query := c.o.QueryTable(new(models.Comment).TableName()).Filter("post_id", id)
		query.All(&comments)
		c.Data["comments"] = comments

		categorys := [] *models.Category{}
		c.o.QueryTable( new(models.Category).TableName()).All(&categorys)
		c.Data["cates"] = categorys
		var hosts      [] *models.Post
		querys := c.o.QueryTable(new(models.Post).TableName()).Filter("types", 1)
		querys.OrderBy("-views").Limit(10, 0).All(&hosts)
		c.Data["hosts"] = hosts

	}
	c.TplName = c.controllerName+ "/detail.html"
}

/**
关于我们
 */
func (c *BlogController) About()  {
	post := models.Post{Id:1}
	c.o.Read(&post)
	c.Data["post"] = post
	c.TplName = c.controllerName + "/about.html"
}

//时间线
func (c *BlogController) Timeline()  {
	c.TplName = c.controllerName + "/timeline.html"
}

//资源
func (c *BlogController) Resource()  {
	c.list()
	c.TplName = c.controllerName + "/resource.html"
}

//插入评价
func (c *BlogController) Comment() {
	Comment := models.Comment{}
	Comment.Username = c.GetString("username")
	Comment.Content = c.GetString("content")
	Comment.Ip = c.getClientIp()
	Comment.PostId, _ = c.GetInt("post_id")
	Comment.Created = time.Now()
	if _, err := c.o.Insert(&Comment); err != nil {
		c.History("发布评价失败" + err.Error(), "")
	}else{
		c.History("发布评价成功", "")
	}
}
