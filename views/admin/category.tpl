<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>类目列表</title>
    <link rel="stylesheet" href="/static/plug/layui/css/layui.css">
</head>
<body>
<div class=" layui-inline" style="float: right; margin: 10px;">
    <button class="layui-btn " onclick="add()">
        <i class="layui-icon">&#xe608;</i> 添加
    </button>
</div>

<table class="layui-table" lay-skin="row">
    <colgroup>
        <col >
        <col>
        <col>
    </colgroup>
    <thead>
    <tr>
        <th>名称</th>
        <th>添加时间</th>
        <th>修改时间</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    {{range $k, $v := .categorys}}
    <tr>
        <td>{{$v.Name}}</td>
        <td>{{$v.Created}}</td>
        <td>{{$v.Updated}}</td>
        <td>
            <a href="/admin/categoryadd.html?id={{$v.Id}}" >
                <i class="layui-icon">&#xe642;</i> 修改
            </a>
            <a href="javascript:void(0)" onclick="del({{$v.Id}})"  >
                <i class="layui-icon">&#x1006;</i> 删除
            </a>
        </td>
        {{end}}
    </tr>
    </tbody>
</table>

<script type="text/javascript" src="/static/plug/layui/layui.js"></script>
</body>
<script>
    function add() {
        location.href = "/admin/categoryadd.html"
    }

    function del(id)
    {
        if(confirm("确定要删除吗？"))
        {
            var url = "/admin/categorydel.html?id="+id;
            window.location.href=url;
        }
    }
</script>
</html>

