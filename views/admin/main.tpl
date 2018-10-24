<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="Keywords" content="">
    <meta name="Description" content="">
    <title>后台管理系统</title>
    <link rel="stylesheet" href="/static/plug/layui/css/layui.css">
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon">
</head>

<body>
<!-- 布局容器 -->
<div class="layui-layout layui-layout-admin">
    <!-- 头部 -->
    <div class="layui-header">
        <div class="layui-main">
            <!-- logo -->
            <a href="/" style="color: #c2c2c2; font-size: 18px; line-height: 60px;">后台管理系统</a>
            <!-- 水平导航 -->
            <ul class="layui-nav" style="position: absolute; top: 0; right: 0; background: none;">
                <li class="layui-nav-item">
                    <a href="javascript:;">

                    </a>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">
                        admin,欢迎你！
                    </a>
                    <dl class="layui-nav-child">
                        <dd>
                            <a href="/admin/logout">
                                退出系统
                            </a>
                        </dd>
                    </dl>
                </li>
            </ul>
        </div>
    </div>

    <!--侧边栏 -->
    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <ul class="layui-nav layui-nav-tree " lay-filter="left-nav" style="border-radius: 0;">
            </ul>
        </div>
    </div>

    <!-- 主体 -->
    <div class="layui-body">
        <!-- 顶部切换卡 -->
        <div class="layui-tab layui-tab-brief" lay-filter="top-tab" lay-allowClose="true" style="margin: 0;">
            <ul class="layui-tab-title"></ul>
            <div class="layui-tab-content"></div>
        </div>
    </div>

    <!-- 底部 -->
    <div class="layui-footer" style="text-align: center; line-height: 44px;">
        Copyright © 2012-2016 All Rights Reserved.  前端网(w3cvip.com).保留所有权利    蜀ICP备14031517号-2
    </div>
</div>

<script src="/static/plug/layui/lay/lib/jquery.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="/static/plug/layui/layui.js"></script>
<script type="text/javascript">
    /**
     * 对layui进行全局配置
     */
    layui.config({
        base: '/static/js/'
    });

    layui.use('form', function() {
        var $ = layui.jquery,
            form = layui.form();
    });

    /**
     * 初始化整个系统骨架
     */
    layui.use(['cms'], function() {
        var cms = layui.cms('left-nav', 'top-tab');
        cms.addNav([
            { id: 1, pid: 0, node: '<span style=" font-size: 16px"><i class="layui-icon">&#xe620;</i> 系统管理</span>', url: '#' },
            { id: 7, pid: 1, node: '&nbsp;&nbsp;&nbsp;系统设置', url: '/admin/config.html' },
            { id: 2, pid: 0, node: '<span style=" font-size: 16px"><i class="layui-icon">&#xe63c;</i> 内容管理</span>', url: '#' },
            { id: 3, pid: 2, node: '&nbsp;&nbsp;&nbsp;分类管理', url: '/admin/category.html' },
            { id: 5, pid: 2, node: '&nbsp;&nbsp;&nbsp;博文列表', url: '/admin/index.html' },
            { id: 6, pid: 2, node: '&nbsp;&nbsp;&nbsp;博文添加', url: '/admin/article.html' },
        ], 0, 'id', 'pid', 'node', 'url');
        cms.bind(60 + 41 + 20 + 44); //头部高度 + 顶部切换卡标题高度 + 顶部切换卡内容padding + 底部高度
        cms.clickLI(5);

    });

    function addTab(title, src, id,closeId){
        if(closeId){
//					debugger;
            closeTab(closeId);
        }
        layui.use(['cms'], function() {
            var cms = layui.cms('left-nav', 'top-tab');
            cms.addTab(title,src,id);
        });
    }

    function closeTab(id,refreshId){
        layui.use(['cms'], function() {
            var cms = layui.cms('left-nav', 'top-tab');
            cms.closeTab(id,refreshId);
        });
    }

</script>
</body>

</html>
