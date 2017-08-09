<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>个人客户列表</title>
    <link rel="stylesheet" href="/static/plug/layui/css/layui.css">
</head>
<body>
<div class="layui-form" action="" style="margin: 5px; border: 1px silver">

    <div class="layui-inline">
        <label class="layui-form-label">选择类别</label>
        <div class="layui-input-block">
            <select name="cate_id" lay-verify="required">
                {{range .categorys}}
                <option value="{{.Id}}" >{{.Name}}</option>
                {{end}}
            </select>
        </div>
    </div>

    <div class="layui-inline">
        <label class="layui-form-label">密码</label>
        <div class="layui-input-block">
            <input type="text" name="title" placeholder="请输入标题" autocomplete="on" class="layui-input">
        </div>
    </div>

    <div class=" layui-inline">
        <button class="layui-btn layui-btn-normal  ">
            搜索
        </button>
    </div>

    <div class=" layui-inline" style="float: right">
        <button class="layui-btn " onclick="add()">
            <i class="layui-icon">&#xe608;</i> 添加
        </button>
    </div>

</div>

<table class="layui-table" lay-skin="row">
    <thead>
    <tr>
        <th>标题</th>
        <th>时间</th>
        <td>置顶</td>
        <th>点击量</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    {{range .list}}
    <tr>
        <td>{{.Title}}</td>
        <td>{{.Created}}</td>
        <td>
            {{if .IsTop}}
            <i class="icon-arrow-up" title="置顶"> </i>
            {{else}}
                普通
            {{end}}
        </td>
        <td>
            {{.Views}}
        </td>
        <td>
            <a href="/admin/article?id={{.Id}}" >
                <i class="layui-icon">&#xe642;</i> 修改
            </a>
            <a href="javascript:void(0)" onclick="del({{.Id}})"  >
                <i class="layui-icon">&#x1006;</i> 删除
            </a>
        </td>
    </tr>
    {{end}}
    </tbody>
</table>

<div class="layui-box layui-laypage layui-laypage-default" id="layui-laypage-0">
    {{str2html .pagebar}}
</div>
<script type="text/javascript" src="/static/plug/layui/layui.js"></script>
</body>

<script>

    //Demo
    layui.use('form', function () {
        var form = layui.form();
        var layer = layui.layer;
        //监听提交
        form.on('submit(formDemo)', function (data) {
            layer.msg(JSON.stringify(data.field));
            return false;
        });
    });
    var add = function () {
        location.href = "/admin/article"
    }

    function del(id)
    {
        if(confirm("确定要删除吗？"))
        {
            var url = "/admin/delete.html?id="+id;
            window.location.href=url;
        }
    }

</script>


</html>

