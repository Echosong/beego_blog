layui.define(['layer', 'element', 'fortree'], function(exports) {
	var layer = layui.layer;
	var element = layui.element();
	var fortree = layui.fortree;
	var $ = layui.jquery;

	var nav = null;
	var tab = null;
	var tabcontent = null;
	var tabtitle = null;
	var navfilter = null;
	var tabfilter = null;

	/**
	 * 添加导航
	 */
	function addNav(data, topid, idname, pidname, nodename, urlname) {
		topid = topid || 0;
		idname = idname || 'id';
		pidname = pidname || 'pid';
		nodename = nodename || 'node';
		urlname = urlname || 'url';

		var mytree = new fortree(data, idname, pidname, topid);
		var html = '';

		mytree.forBefore = function(v, k, hasChildren) {
			html += '<li class="layui-nav-item layui-nav-itemed">';
		};

		mytree.forcurr = function(v, k, hasChildren) {
			html += '<a href="javascript:;"' + (v[urlname] ? ' data-url="' + v[urlname] + '" data-id="' + v[idname] + '"' : '') + '>';
			html += v[nodename];
			html += '</a>';
		};

		mytree.callBefore = function(v, k) {
			html += '<dl class="layui-nav-child">';
		};

		mytree.callAfter = function(v, k) {
			html += '</dl>';
		};

		mytree.forAfter = function(v, k, hasChildren) {
			html += '</li>';
		};
		mytree.each();

		nav.append(html);

		element.init('nav(' + navfilter + ')');
	}
	
	function closeTab(id,refreshId){	
		var iframe = tabcontent.find('iframe[data-id=' + id + ']').eq(0);
		if(iframe.length) { //存在 iframe
			//获取iframe身上的tab index
			tabindex = iframe.attr('data-tabindex');
			$("[lay-id='index-" + tabindex + "']").remove();
			$("[data-tabindex='" + tabindex + "']").parent().remove();
		}
		
		if(refreshId){
			var iframe2 = tabcontent.find('iframe[data-id=' + refreshId + ']').eq(0);
			if(iframe2.length){
				tabindex2 = iframe2.attr('data-tabindex');
				var tt=$("[lay-id='index-"+tabindex2+"']").text();
				tt=tt.substring(0,tt.length-1);
				
				addTab(tt,iframe2.attr("src"),refreshId);
			}			
		}
	}

	function addTab(title, src, id) {
		var iframe = tabcontent.find('iframe[data-id=' + id + ']').eq(0);
		var tabindex = (new Date()).getTime();

		if(src != undefined && src != null && id != undefined && id != null) {
			if(iframe.length) { //存在 iframe
				//获取iframe身上的tab index
				tabindex = iframe.attr('data-tabindex');
				$("[lay-id='index-" + tabindex + "']").remove();
				$("[data-tabindex='" + tabindex + "']").parent().remove();
			}
			//显示加载层
			var tmpIndex = layer.load();
			//设置1秒后再次关闭loading
			setTimeout(function() {
				layer.close(tmpIndex);
			}, 1000);
			//拼接iframe
			var iframe = '<iframe onload="layui.layer.close(' + tmpIndex + ')"';
			iframe += ' src="' + src + '" data-id="' + id + '" data-tabindex="' + tabindex + '"';
			iframe += ' style="width: 100%; height: ' + tabcontent.height() + 'px; border: 0px;"';
			iframe += '></iframe>';
			//顶部切换卡新增一个卡片
			element.tabAdd(tabfilter, {
				title: title,
				content: iframe,
				id: 'index-' + tabindex
			});

			//切换到指定索引的卡片
			element.tabChange(tabfilter, 'index-' + tabindex);

			//隐藏第一个切换卡的删除按钮
			tabtitle.find('li').eq(0).find('i').hide();
		}
	}

	/**
	 * 将侧边栏与顶部切换卡进行绑定
	 */
	function bind(height) {
		var height = height || 60 + 41 + 44; //头部高度 顶部切换卡标题高度 底部高度
		/**
		 * iframe自适应
		 */
		$(window).resize(function() {
			//设置顶部切换卡容器度
			tabcontent.height($(this).height() - height);
			//设置顶部切换卡容器内每个iframe高度
			tabcontent.find('iframe').each(function() {
				$(this).height(tabcontent.height());
			});
		}).resize();

		/**
		 * 监听侧边栏导航点击事件
		 */
		element.on('nav(' + navfilter + ')', function(elem) {
			var a = elem.children('a');
			var title = a.text();
			var src = elem.children('a').attr('data-url');
			var id = elem.children('a').attr('data-id');

			addTab(title, src, id);
		});
	}

	/**
	 * 根据索引点击导航栏的某个li
	 */
	function clickLI(index) {
		nav.find('li').eq(index || 0).click();
	}

	/**
	 * 导出接口
	 */
	exports('cms', function(navLayFilter, tabLayFilter) {
		navfilter = navLayFilter;
		tabfilter = tabLayFilter;

		nav = $('.layui-nav[lay-filter=' + navfilter + ']').eq(0);
		tab = $('.layui-tab[lay-filter=' + tabfilter + ']').eq(0);
		tabcontent = tab.children('.layui-tab-content').eq(0);
		tabtitle = tab.children('.layui-tab-title').eq(0);

		var error = '';
		if(nav.length == 0) {
			error += '没有找到导航栏<br>';
		}

		if(tab.length == 0) {
			error += '没有找到切换卡<br>';
		}

		if(error) {
			layer.msg('cms模块初始化失败！<br>' + error);
			return false;
		}

		return {
			addNav: addNav,
			addTab: addTab,
			closeTab:closeTab,
			bind: bind,
			clickLI: clickLI
		};
	});
});
