<?php
require_once "tpl.class.php";
require_once "db.php";
//开启session
session_start();
@$u_num=$_SESSION['re_u_num'];
	if($u_num==""){
	echo "<script>alert('您还没有登陆，请登陆！');window.location='index.php';</script>";
}else{
	$smarty->assign("u_num",$u_num);
}
//查询员工姓名
	$db=new DB();
	$sql="select u_name from user where u_num='$u_num';";
	$res=$db->execute($sql);
	foreach($res as $value);
	$u_name=$value['u_name'];
	$smarty->assign("u_name",$u_name);
//分配权限
if($u_num=="1000"){
	//查询全体员工
	$db=new DB();
	$sql="select * from user;";
	$res=$db->execute($sql);
	$smarty->assign("resu1",$res);
}else if($u_num=="1001" or $u_num=="1004"){
	//查询员工
	$db=new DB();
	$sql="select * from user where u_num>1000;";
	$res=$db->execute($sql);
	$smarty->assign("resu1",$res);
}else{
	echo"<script>alert('您没有权限！');history.go(-1);</script>";
	return false;
}
//获取最新工号
$db=new DB();
	$sql="select max(u_num) from user;";
	$res=$db->execute($sql);
	foreach($res as $value);
	$max_num=$value['max(u_num)'];
	$new_num=$max_num+1;
	$smarty->assign("new_num",$new_num);
//POST
if(isset($_POST['new_num'])){
@	$new_num=$_POST['new_num'];
@	$new_name=$_POST['new_name'];
@	$new_pwd=$_POST['new_pwd'];
	if($new_num!==""&&$new_name!==""&&$new_pwd!==""){
		//插入新员工
		$db=new DB();
		$sql="insert into user (u_num,u_name,u_pwd)values ('{$new_num}','{$new_name}','{$new_pwd}');";
		$res=$db->execute($sql);
		echo"<script>alert('成功添加{$new_num}员工！');window.location='add_user.php'</script>";
	}else{
		echo"<script>alert('请填写完整！');window.location='add_user.php'</script>";
	}
}
//列表删除
if(isset($_POST['del'])){
	$del_1=$_POST['del_1'];
	$del_2=$_POST['del_2'];
	$max=max($del_1,$del_2);
	$min=min($del_1,$del_2);
	$db=new DB();
		$sql="delete from repair_list where id between {$min} and {$max};";
		$res=$db->execute($sql);
		echo"<script>alert('成功删除[{$del_1}]-[{$del_2}]的内容！');window.location='add_user.php'</script>";
}
//Smarty
$smarty->display("add_user.tpl");
?>
