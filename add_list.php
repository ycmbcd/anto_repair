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
if($u_num>"1001"){
	echo"<script>alert('您没有权限！');history.go(-1);</script>";
	return false;
}else{
if(isset($_POST['upme'])){
//开始上传文件功能
if(@$_POST['submit']=="yes")

 //由文件上传导致的错误,终止程序执行 ，重新上传
 if ($_FILES['myfile']['error'] > 0) 
    {echo "<script>alert('上传错误！');history.go(-1);</script>";}else
//移动上传文件到uploads目录
   {
     move_uploaded_file($_FILES['myfile']['tmp_name'], "./uploads/data.csv");//移动文件到指定文件夹uploads；
    echo "<script>alert('上传成功，请导入！');window.location='insert.php';</script>";
   }  
}
}
//Smarty
$smarty->display("add_list.tpl");
?>
