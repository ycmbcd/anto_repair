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

<div id="change_pwd">
<form method="post">
<table>
	<tr>
    	<td>工&nbsp;&nbsp;&nbsp;号：</td><td>{$u_num}</td>
    </tr>
    <tr>
        <td>姓&nbsp;&nbsp;&nbsp;名：</td><td><input type="text" name="new_name" value="{$u_name}" /></td>
    </tr>
    <tr>
        <td class="red">原密码：</td><td><input name="ord_pwd" type="password" value="" /></td>
    </tr>
    <tr>
        <td class="blue">新密码：</td><td><input name="new_pwd" type="password" value="" /></td>
    </tr>
    <tr>
        <td class="blue">确&nbsp;&nbsp;&nbsp;认：</td><td><input name="new_pwd1" type="password" value="" /></td>
    </tr>
    <tr>
    	<td colspan="2"><center><input class="sbtn" type="reset" value="重&nbsp;&nbsp;置" />
        <input class="sbtn" type="submit" value="提&nbsp;&nbsp;交" /></center></td>
    </tr>
</table>
</form>
<br />
<center>
<form method="post">
列表每页<input style="width:50px;" class="tr" type="text" name="u_count" value="{$u_count}" />条
<input type="submit" value="确 定" />
<br />
注：不填或者填“0”为默认30条每页
</form>
</center>
</div>

<div id="footer">
<div style="padding:5px 0 0 20px; width:460px;" class="left">
<img class="left" style="border:1px solid #CCC;" src="../images/anto1.jpg" width="50" />
<div style="width:400px;padding-top:4px; text-align:left;" class="right">
&copy; 2014-2020 ANTO Int'l Trade Co.,Ltd. All Rights Reserved.<br />
Powered by ycmbcd & pd
</div>
</div>
<div class="right" style="width:500px;height:46px; line-height:46px; font-size:14px;padding-right:20px;">欢迎您：{$u_name} 工号：{$u_num} | <a href="/add_user.php">系统管理</a> | <a href="/show.php">返回列表</a> | <a href="logout.php" >退出</a></div>
</div>
</body>
</html>
