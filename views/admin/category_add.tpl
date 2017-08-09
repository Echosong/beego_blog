<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>添加类目</title>
    <link rel="stylesheet" href="/static/plug/layui/css/layui.css">
</head>
<body>
<script type="text/javascript" src="/static/plug/layui/layui.js"></script>
<form class="layui-form" action="/admin/categorysave.html" style="margin:20px" method="post">
    <div class="layui-form-item">
        <label class="layui-form-label">标题：</label>
        <div class="layui-input-block">
            <input name="id" type="hidden" value="{{.cate.Id}}">
            <input type="text" name="name" value="{{.cate.Name}}" required  lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="formDemo">提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</form>
</body>
</html>