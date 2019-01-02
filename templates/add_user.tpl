<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>ANALYZA CUSTOMER SERVICE MAINTENANCE LIST</title>
<link href="../style/index.css" type="text/css" rel="stylesheet" />
</head>

<body>
<div id="header" class="auto" style="top:0%;"  >
&nbsp;&nbsp; ANALYZA CUSTOMER SERVICE MAINTENANCE LIST
</div>

<div id="add_user">
<form method="post">
<div style="font-size:20px;">添加新员工：</div>
<table>
	<tr>
    	<td>工&nbsp;&nbsp;号：</td><td><input type="text" name="new_num" value="{$new_num}" /></td>
    
        <td>姓&nbsp;&nbsp;名：</td><td><input type="text" name="new_name" value="" /></td>
    
        <td>密&nbsp;&nbsp;码：</td><td><input type="text" name="new_pwd" value="123456" /></td>
   
        <td><input class="sbtn" type="submit" value="提&nbsp;&nbsp;交" /></td>
    </tr>
</table>
</form>
</div>
<div id="del_list" class="a_width">
<form method="post">
	列表批量删除[包括此条]ID：<input style="width:80px;" type="text" name="del_1" />-<input type="text" style="width:80px;" name="del_2" />
    <input type="submit" name="del" value="删 除" />
</form>
</div>
<div id="list_user" style="margin-bottom:200px;">
{if $resu1}
<table>
	<tr>
    	<td>工号</td>
        <td>姓名</td>
        <td>操作</td>
    </tr>
    {section name=se loop=$resu1}
    <tr>
    	<td>{$resu1[se].u_num}</td>
        <td>{$resu1[se].u_name}</td>
        <!-- <td>{$resu1[se].u_pwd}</td> -->
        <td><a href="/del_usr.php?del={$resu1[se].u_num}" style="display: block;width:50px;text-align:center;height:20px;color:#FFF;background: #bc0000;border:1px solid #dedede;">删 除</a></td>
    </tr>
    {/section}
</table>
{/if}
</div>

<div id="footer">
<div style="padding:5px 0 0 20px; width:460px;" class="left">
<img class="left" style="border:1px solid #CCC;" src="../images/anto1.jpg" width="50" />
<div style="width:400px;padding-top:4px; text-align:left;" class="right">
&copy; 2014-2019 ANTO Int'l Trade Co.,Ltd. All Rights Reserved.<br />
Powered by ycmbcd & pd
</div>
</div>
<div class="right" style="width:500px;height:46px; line-height:46px; font-size:14px;padding-right:20px;">欢迎您：{$u_name} 工号：{$u_num} | <a href="/change_pwd.php">账户管理</a> | <a href="/show.php">返回列表</a> | <a href="logout.php" >退出</a></div>
</div>
</body>
</html>
