/**
 * 递归遍历树形类
 */
layui.define(function(exports) {
    /**
     * 导出接口
     */
    exports('fortree', function (arr, idname, pidname, topid) {
        var _that     = this; //对象本身
        var _father   = []; //所有顶级节点
        var _children = []; //所有子节点
        var _idname   = idname  || 'id'; //id名称
        var _pidname  = pidname || 'pid'; //父id名称
        var _topid    = topid   || 0; //顶级节点父id

        for(var i in arr) {
            if(arr[i][_pidname] == _topid) {
                _father.push(arr[i]);
            }else{
                _children.push(arr[i]);
            }
        }

        /**
         * 循环之前回调
         */
        this.forBefore  = function(v, k, hasChildren) {};
        /**
         * 循环时回调
         */
        this.forcurr    = function(v, k, hasChildren) {};
        /**
         * 递归之前回调
         */
        this.callBefore = function(v, k) {};
        /**
         * 递归之后回调
         */
        this.callAfter  = function(v, k) {};
        /**
         * 循环之后回调
         */
        this.forAfter   = function(v, k, hasChildren) {};

        /**
         * 获取某个节点的一级子节点
         */
        this.getChildren = function(id) {
            var son = [];

            for(var i in _children) {
                if(_children[i][_pidname] == id) {
                    son.push(_children[i]);
                }
            }

            return son;
        };

        /**
         * 开始循环
         */
        this.each = function(arr) {
            if(arr == undefined) {
                arr = _father;
            }

            for(var i in arr) {
                var children = _that.getChildren(arr[i][_idname]);
                var counter  = children.length;

                _that.forBefore(arr[i], i, counter);
                _that.forcurr(arr[i], i, counter);

                if(counter) {
                    _that.callBefore(arr[i], i);
                    _that.each(children);
                    _that.callAfter(arr[i], i);
                }

                _that.forAfter(arr[i], i, counter);
            }
        }
    });
});