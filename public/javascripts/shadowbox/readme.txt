###########
���Ȱ�����Ҫ���ļ���������Ӧ���ļ��£�
1��shared�ļ���copy��public/images�ļ�����
2��shadowbox.css��ʽ�ļ�copy��public/stylesheets�ļ�����
3��shadowbox�ļ���copy��public/javascripts�ļ�����


Ȼ�����Щ�ļ�Ҫ���뵽��Ŀ���У�
<%= javascript_include_tag 'shadowbox/adapter/shadowbox-base' %>
<%= javascript_include_tag 'shadowbox/shadowbox.js' %>
<%= stylesheet_link_tag 'shadowbox.css'%>
<%= javascript_include_tag 'shadowbox/shadowbox_method.js'%>
<script language='javascript'>
   Shadowbox.loadSkin('classic', '/javascripts/shadowbox/skin');
   Shadowbox.loadLanguage('en', '/javascripts/shadowbox/lang');
   Shadowbox.loadPlayer(['flv', 'html', 'iframe', 'img', 'qt', 'swf', 'wmp'], '/javascripts/shadowbox/player');
</script>

ע��ĵط���shadowbox_method.js����ļ���shadowbox��ʼ�����ļ������Ҫ�޸�shadowbox
��ʼ������ʽ���Ϳ���������ļ������޸ģ�

�����ε��ã�
eg: <%= link_to_function 'detail', "get_shadowbox_page(xxxxxx)"%>"XXX"�����������·����
Ĭ������£�shadowbox����iframe����ʽչʾ��������controller��Ӧ��������ת��һ��yyy.html.erb��ҳ��