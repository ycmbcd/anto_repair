<?php
//开启session
	session_start();
	require_once("tpl.class.php");
	require_once("db.php");
//POST_user
if(isset($_POST['u_num'])){
	$u_num=$_POST['u_num'];
	$u_pwd=$_POST['u_pwd'];
	$_SESSION['re_u_num']=$u_num;
	$_SESSION['u_pwd']=$u_pwd;

//查询user数据库
	$db=new DB();
	$sql="select * from user where u_num='{$u_num}' and u_pwd='{$u_pwd}';";
	$res=$db->execute($sql);
	if(empty($res)){
	echo "<script>alert('帐号或密码错误！');window.location='index.php'</script>";
	}else{
		echo"<script>window.location='show.php';</script>";
	}
}

//Smarty
$smarty->display("index.tpl");
?>
