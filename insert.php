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
if(isset($_POST['go'])){
	$db=new DB();
	$sql="LOAD DATA INFILE '/opt/web/anto_repair/uploads/data.csv'
INTO TABLE repair_list fields terminated by '\,' optionally enclosed by '\"' lines terminated by '\r\n' ignore 1 lines;";
	$res=$db->execute($sql);
	echo "<script>alert('导入成功！');window.location='show.php';</script>";
}
//Smarty
$smarty->display("insert.tpl");
?>
