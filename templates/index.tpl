<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>ANALYZA CUSTOMER SERVICE MAINTENANCE LIST</title>
<link href="../style/index.css" type="text/css" rel="stylesheet" />
<link href="../style/scroll.css" type="text/css" rel="stylesheet" />
<script src="../js/jquery.js" type="text/javascript" ></script>
<script src="../js/jquery.ticker.js" type="text/javascript"></script>
{literal}
<style>

</style>
<script type="text/javascript">
    $(function () {
        $('#js-news').ticker();
    });
</script>
{/literal}
</head>

<body>
<div id="weather">
<iframe allowtransparency="true" frameborder="0" width="1000" height="98" scrolling="no" src="http://tianqi.2345.com/plugin/widget/index.htm?s=2&amp;z=1&amp;t=1&amp;v=0&amp;d=5&amp;bd=0&amp;k=000000&amp;f=&amp;q=1&amp;e=1&amp;a=1&amp;c=58362&amp;w=875&amp;h=98&amp;align=center"></iframe>
</div>
<ul id="js-news" class="js-hidden">
    <li class="news-item" >【2017-06-26】修复佐川订单导出后，多个相同商品无法显示完整的bug。</li>
    <li class="news-item" >【2016-07-04】新增库存管理系统佐川发货单。</li>
    <li class="news-item" >【2016-04-19】优化交互界面。</li>
	<li class="news-item" >【2015-11-27】增加注文番号最大长度，支持同捆订单。</li>
    <li class="news-item" >【2015-10-26】导出表格为xlsx格式，兼容中文office并改善界面。</li>
	<li class="news-item" >【2015-01-09】修复备注区标点符号与下载表的兼容性问题。</li>
	<li class="news-item" >【2014-12-17】重新设计了强大的搜索栏（biger than biger）。</li>
	<li class="news-item" >【2014-12-14】修复了佐川发货单导出为空的bug</li>
	<li class="news-item" >【2014-12-10】新增天气功能....(⊙o⊙)</li>
	<li class="news-item" >【2014-12-09】增强编辑页的界面友好。</li>
	<li class="news-item" >【2014-12-09】关键字搜索新增“收件人地址&店铺”，删除“写真”。</li>
    	<li class="news-item" >【2014-12-04】所有导出表单新增列名....^_^</li>
</ul>
<div id="header" class="auto" style="top:0%">
&nbsp;&nbsp; ANALYZA CUSTOMER SERVICE MAINTENANCE LIST
</div>
<div id="log" class="auto">
<div id="logo" class="left"><img src="../images/anto.jpg" width="200" /></div>

    <form onkeyup="log()" method="post" class="right">
    	<table style="margin-top:20px;">
        	<tr>
            	<td style="color:#666;font-size:14px; font-weight:bold;">担当 ID：</td>
                <td><input style="width:120px;height:20px; font-weight:bold;font-size:16px; color:#C00;" type="text" id="anto_number" name="u_num" /></td>
            </tr>
            <tr style="height:10px;"></tr>
            <tr>
            	<td style="color:#666;font-size:14px; font-weight:bold;">Password：</td>
                <td><input style="width:120px;height:20px;font-size:16px; font-weight:bold; color:#C00;" type="password" id="pwd" name="u_pwd" /></td>
            </tr>
            <tr style="height:20px;"></tr>
            <tr>
                <td colspan="2" align="center"><input style="border-radius: 8px;
    font-size: 18px;width:140px;height:38px; background:#FFF;cursor:pointer;" type="submit" value="ログイン" onmouseover="this.className='login_button_hover'" onmouseout="this.className='login_button'" class="login_button"/>&nbsp;&nbsp;</td>
            </tr>
        </table>
    </form>
  </div>
<div id="footer">
<div style="padding-top:8px;"></div>
<div style="padding-right:10px;width:600px; text-align:left; padding-left:10px;" class="left">
&copy; 2014-2021 ANTO Int'l Trade Co.,Ltd. All Rights Reserved.<br />
Powered by ycmbcd & pd
</div>
</div>
</body>
</html>
