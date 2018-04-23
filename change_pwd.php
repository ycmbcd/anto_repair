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
//POST
if(isset($_POST['ord_pwd'])){
	$ord_pwd=$_POST['ord_pwd'];
	$new_pwd=$_POST['new_pwd'];
	$new_pwd1=$_POST['new_pwd1'];
	$new_name=$_POST['new_name'];
	if(($new_pwd==$new_pwd1)&&$new_pwd!==""){
	//查询旧密码
	$db=new DB();
		$sql="select * from user where u_num='$u_num';";
		$res=$db->execute($sql);
		foreach($res as $value);
		$u_pwd=$value['u_pwd'];
	//修改密码
	if($u_pwd==$ord_pwd){
		$db=new DB();
		$sql="update user set u_pwd='{$new_pwd}',u_name='{$new_name}' where u_num='{$u_num}';";
		$res=$db->execute($sql);
		echo"<script>alert('密码修改成功');window.location='show.php'</script>";
	}else{
		echo"<script>alert('填写错误');window.location='change_pwd.php'</script>";
	}
	}else{
		echo"<script>alert('新密码请填写正确！');window.location='change_pwd.php'</script>";
	}
}
	//修改u_count
	if(isset($_POST['u_count'])){
		$u_count=$_POST['u_count'];
		$db=new DB();
		$sql="update user set u_count='{$u_count}' where u_num='{$u_num}';";
		$res=$db->execute($sql);
		if($u_count=="" or $u_count=="0"){
			echo "<script>alert('列表修改为默认【30】条每页！');window.location='show.php'</script>";
		}else{
			echo "<script>alert('列表修改为【{$u_count}】条每页！');window.location='show.php'</script>";
		}
	}
//Smarty
$smarty->display("change_pwd.tpl");
?>
