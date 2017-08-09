package routers

import (
	"github.com/Echosong/beego_blog/controllers"
	"github.com/astaxie/beego"
)

func init() {

	beego.Router("/", &controllers.BlogController{}, "*:Home")
	beego.Router("/home", &controllers.BlogController{}, "*:Home")
	beego.Router("/article", &controllers.BlogController{}, "*:Article")
	beego.Router("/detail", &controllers.BlogController{}, "*:Detail")
	beego.Router("/about", &controllers.BlogController{}, "*:About")
	beego.Router("/timeline", &controllers.BlogController{}, "*:Timeline")
	beego.Router("/resource", &controllers.BlogController{}, "*:Resource")
	beego.Router("/comment", &controllers.BlogController{}, "post:Comment")

	beego.AutoRouter(&controllers.AdminController{})
}
