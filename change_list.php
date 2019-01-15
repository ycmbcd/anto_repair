<?php
//开启session
session_start();
require_once "tpl.class.php";
require_once "./pdo/repo.class.php";
require_once "db.php";
@$u_num=$_SESSION['re_u_num'];
	if($u_num==""){
	echo "<script>alert('您还没有登陆，请登陆！');window.location='index.php';</script>";
}else{
	$smarty->assign("u_num",$u_num);
}
$rdb = new RepoPdoMySQL();

// sku 套装查询
if(isset($_GET['search_pack'])){
	$search_pack = addslashes($_GET['search_pack']);
	$sql = "SELECT goods_code FROM pack_table WHERE pack_name = '{$search_pack}'";
	$res = $rdb->getAll($sql);
	echo json_encode($res);
	return false;
}
if(isset($_GET['search_sku'])){
	$search_sku = addslashes($_GET['search_sku']);
	$sql = "SELECT goods_code FROM goods_type WHERE goods_code like '%{$search_sku}%' LIMIT 20";
	$res = $rdb->getAll($sql);
	echo json_encode($res);
	return false;
}

//查询OMS信息
if(isset($_GET['oms_order_id'])){
	$oms_order_id = addslashes($_GET['oms_order_id']);
	$odb = new ODB();
	//查询平台店铺
	$sql = "SELECT station FROM history_send where order_id = '{$oms_order_id}'";
	$res = $odb->execute($sql);

	if(empty($res)){
		//查询发货区平台店铺
		$sql = "SELECT station FROM send_table where order_id = '{$oms_order_id}'";
		$res = $odb->execute($sql);
		if(empty($res)){
			echo json_encode('no');
			return false;
		}
	}

	foreach ($res as $value) {
		$now_station = $value['station'];
		$now_list = $value['station']."_response_list";
	}
	$sql = "SELECT * FROM $now_list where order_id = '{$oms_order_id}'";
	$res1 = $odb->execute($sql);
	foreach ($res1 as $val) {
		$oms_id = $val['id'];
	}
	// 查询操作日志
	$sql = "SELECT * FROM oms_log where station = '{$now_station}' AND oms_id = '{$oms_id}' ORDER BY id desc";
	$res2 = $odb->execute($sql);
	$final_res['res1'] = $res1;
	$final_res['res2'] = $res2;
	echo json_encode($final_res);
	
	return false;
};

//查询员工姓名
	$db=new DB();
	$sql="select u_name from user where u_num='$u_num';";
	$res=$db->execute($sql);
	foreach($res as $value);
	$u_name=$value['u_name'];
	$smarty->assign("u_name",$u_name);
//权限控制
if(isset($_GET['id'])){
	$u_num=$_GET['u_num'];
	$id=$_GET['id'];
	$db=new DB();
	$sql="select u_num from repair_list where id='{$id}';";
	$res=$db->execute($sql);
	foreach($res as $value);
	$s_num=$value['u_num'];
	//if($u_num==$s_num or $u_num==1000 or $u_num==1001 or $s_num=="" or $s_num==0 or $s_num==1000 or $s_num==1001){
	//查询列表
	$db=new DB();
	$sql="select * from repair_list where id='{$id}';";
	$res=$db->execute($sql);

	$res[0]['who_name'] =  preg_replace('/\[.*?\]/', '', $res[0]['who_name']);
	$res[0]['receive_name'] =  preg_replace('/\[.*?\]/', '', $res[0]['receive_name']);
	$smarty->assign("resu1",$res);
//	}else{
//			echo "<script>alert('这不是你的数据！系统将退回开始页！');window.location='show.php'</script>";
//			return false;
//	}
}
//POST
if(isset($_POST['update'])){
	$email=$_POST['email'];
	$order_id=$_POST['order_id'];
	$good_id=$_POST['good_id'];
	$store=$_POST['store'];
	$who_id=$_POST['who_id'];
	$who_phone=$_POST['who_phone'];
	$who_code=$_POST['who_code'];
	$who_house=$_POST['who_house'];
	$who_house1=$_POST['who_house1'];
	$who_house2=$_POST['who_house2'];
	$who_name=$_POST['who_name'];
	$receive_phone=$_POST['receive_phone'];
	$receive_code=$_POST['receive_code'];
	$receive_house=$_POST['receive_house'];
	$receive_house1=$_POST['receive_house1'];
	$receive_house2=$_POST['receive_house2'];
	$receive_name=$_POST['receive_name'];
	$total_money=$_POST['total_money'];
	$ems_money=$_POST['ems_money'];
	$bill=$_POST['bill'];
	$point=$_POST['point'];
	$cheap=$_POST['cheap'];
	$tax=$_POST['tax'];
	$goods=$_POST['goods'];
	$buy_money=$_POST['buy_money'];
	$buy_method=$_POST['buy_method'];
	$to_method=$_POST['to_method'];
	$send_num=$_POST['send_num'];
	$send_day=$_POST['send_day'];
	$start_day=$_POST['start_day'];
	$re_good1=$_POST['re_good1'];
	$re_good2=$_POST['re_good2'];
	$re_good3=$_POST['re_good3'];
	$re_good4=$_POST['re_good4'];
	$re_good5=$_POST['re_good5'];
	$add_type=$_POST['add_type'];
	$over_day=$_POST['over_day'];
	$pay_method=$_POST['pay_method'];
	$money=$_POST['money'];
	$receive_money=$_POST['receive_money'];
	$send_method=$_POST['send_method'];
	$is_miss=$_POST['is_miss'];
	$is_bad=$_POST['is_bad'];
	$say_type=$_POST['say_type'];
	$is_photo=$_POST['is_photo'];
	$is_receive=$_POST['is_receive'];
	$is_money=$_POST['is_money'];
	$ems=$_POST['ems'];
	$other=$_POST['other'];
	$method=$_POST['method'];
	$want_date=$_POST['want_date'];
	$want_time=$_POST['want_time'];
	
	$db=new DB();
	$sql="update repair_list set email='{$email}',order_id='{$order_id}',good_id='{$good_id}',store='{$store}',who_id='{$who_id}',who_phone='{$who_phone}',who_code='{$who_code}',who_house='{$who_house}',who_house1='{$who_house1}',who_house2='{$who_house2}',who_name='{$who_name}',receive_phone='{$receive_phone}',receive_code='{$receive_code}',receive_house='{$receive_house}',receive_house1='{$receive_house1}',receive_house2='{$receive_house2}',receive_name='{$receive_name}',total_money='{$total_money}',ems_money='{$ems_money}',bill='{$bill}',point='{$point}',cheap='{$cheap}',tax='{$tax}',goods='{$goods}',buy_money='{$buy_money}',buy_method='{$buy_method}',to_method='{$to_method}',send_num='{$send_num}',send_day='{$send_day}',start_day='{$start_day}',method='{$method}',re_good1='{$re_good1}',re_good2='{$re_good2}',re_good3='{$re_good3}',re_good4='{$re_good4}',re_good5='{$re_good5}',add_type='{$add_type}',over_day='{$over_day}',pay_method='{$pay_method}',money='{$money}',receive_money='{$receive_money}',send_method='{$send_method}',is_miss='{$is_miss}',is_bad='{$is_bad}',say_type='{$say_type}',is_photo='{$is_photo}',is_receive='{$is_receive}',is_money='{$is_money}',ems='{$ems}',other='{$other}',u_name='{$u_name}',u_num='{$u_num}',want_date = '{$want_date}',want_time='{$want_time}' where id='{$id}';";
		$res=$db->execute($sql);
		$smarty->display("change_list.tpl");
		echo"<script>$(\"#shade\").css({\"background\":\"#6C9\"}).fadeIn(0);;alert_message('".$id." 更新成功！');</script>";
		return false;
}
//新增
if(isset($_POST['add_list'])){
	$email=$_POST['email'];
	$order_id=$_POST['order_id'];
	$good_id=$_POST['good_id'];
	$store=$_POST['store'];
	$who_id=$_POST['who_id'];
	$who_phone=$_POST['who_phone'];
	$who_code=$_POST['who_code'];
	$who_house=$_POST['who_house'];
	$who_house1=$_POST['who_house1'];
	$who_house2=$_POST['who_house2'];
	$who_name=$_POST['who_name'];
	$receive_phone=$_POST['receive_phone'];
	$receive_code=$_POST['receive_code'];
	$receive_house=$_POST['receive_house'];
	$receive_house1=$_POST['receive_house1'];
	$receive_house2=$_POST['receive_house2'];
	$receive_name=$_POST['receive_name'];
	$total_money=$_POST['total_money'];
	$ems_money=$_POST['ems_money'];
	$bill=$_POST['bill'];
	$point=$_POST['point'];
	$cheap=$_POST['cheap'];
	$tax=$_POST['tax'];
	$goods=$_POST['goods'];
	$buy_money=$_POST['buy_money'];
	$buy_method=$_POST['buy_method'];
	$to_method=$_POST['to_method'];
	$send_num=$_POST['send_num'];
	$send_day=$_POST['send_day'];
	$start_day=$_POST['start_day'];
	$re_good1=$_POST['re_good1'];
	$re_good2=$_POST['re_good2'];
	$re_good3=$_POST['re_good3'];
	$re_good4=$_POST['re_good4'];
	$re_good5=$_POST['re_good5'];
	$add_type=$_POST['add_type'];
	$over_day=$_POST['over_day'];
	$pay_method=$_POST['pay_method'];
	$money=$_POST['money'];
	$receive_money=$_POST['receive_money'];
	$send_method=$_POST['send_method'];
	$is_miss=$_POST['is_miss'];
	$is_bad=$_POST['is_bad'];
	$say_type=$_POST['say_type'];
	$is_photo=$_POST['is_photo'];
	$is_receive=$_POST['is_receive'];
	$is_money=$_POST['is_money'];
	$ems=$_POST['ems'];
	$other=$_POST['other'];
	$method=$_POST['method'];
	$db=new DB();
	//获得总数
	$sql="select id from repair_list order by id desc limit 0,1;";//1的效率比*高
	$res=$db->execute($sql);
	foreach($res as $value);
	$end_count=$value['id'];
	$end_count+=1;
	$sql="INSERT into repair_list values ('{$end_count}','{$email}','{$order_id}','{$good_id}','{$store}','{$who_id}','{$who_phone}','{$who_code}','{$who_house}','{$who_house1}','{$who_house2}','{$who_name}','{$receive_phone}','{$receive_code}','{$receive_house}','{$receive_house1}','{$receive_house2}','{$receive_name}','{$total_money}','{$ems_money}','{$bill}','{$point}','{$cheap}','{$tax}','{$goods}','{$buy_money}','{$buy_method}','{$to_method}','{$send_num}','{$send_day}','{$start_day}','{$method}','{$re_good1}','{$re_good2}','{$re_good3}','{$re_good4}','{$re_good5}','{$add_type}','{$over_day}','{$pay_method}','{$money}','{$receive_money}','{$send_method}','{$is_miss}','{$is_bad}','{$say_type}','{$is_photo}','{$is_receive}','{$is_money}','{$ems}','{$u_name}','{$u_num}','{$other}','','','','','','','');";
		$res=$db->execute($sql);
		echo"<script>alert('新增一条！系统将退回开始页！');window.location='show.php'</script>";
}
//Smarty
$smarty->display("change_list.tpl");
?>
