###########
首先把所需要的文件拷贝到相应的文件下：
1把shared文件夹copy到public/images文件夹下
2把shadowbox.css样式文件copy到public/stylesheets文件夹下
3把shadowbox文件夹copy到public/javascripts文件夹下


然后把这些文件要引入到项目当中：
<%= javascript_include_tag 'shadowbox/adapter/shadowbox-base' %>
<%= javascript_include_tag 'shadowbox/shadowbox.js' %>
<%= stylesheet_link_tag 'shadowbox.css'%>
<%= javascript_include_tag 'shadowbox/shadowbox_method.js'%>
<script language='javascript'>
   Shadowbox.loadSkin('classic', '/javascripts/shadowbox/skin');
   Shadowbox.loadLanguage('en', '/javascripts/shadowbox/lang');
   Shadowbox.loadPlayer(['flv', 'html', 'iframe', 'img', 'qt', 'swf', 'wmp'], '/javascripts/shadowbox/player');
</script>

注意的地方：shadowbox_method.js这个文件是shadowbox初始化的文件，如果要修改shadowbox
初始化的样式，就可以在这个文件里面修改，

最后，如何调用：
eg: <%= link_to_function 'detail', "get_shadowbox_page(xxxxxx)"%>"XXX"代表的是请求路径。
默认情况下，shadowbox是以iframe的形式展示，所以在controller里应该让它跳转到一个yyy.html.erb的页面