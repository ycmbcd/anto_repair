<?php
session_start();
//开启session
@$u_num=$_SESSION['re_u_num'];
	if($u_num==""){
	echo "<script>alert('您还没有登陆，请登陆！');window.location='index.php';</script>";
}else{
	$smarty->assign("u_num",$u_num);
}
require_once "tpl.class.php";
require_once "db.php";
date_default_timezone_set('prc');

//查询员工姓名及分页数
	$db=new DB();
	$sql="select u_name,u_count from user where u_num='$u_num';";
	$res=$db->execute($sql);
	foreach($res as $value);
	$u_name=$value['u_name'];
	$u_count=$value['u_count'];
	if($u_count=="" or $u_count=="0"){
		$u_count=30;
	}
	$smarty->assign("u_name",$u_name);
	$smarty->assign("u_count",$u_count);
//关键字检索
if(isset($_POST['key_search'])){
	$search_type=$_POST['search_type'];
	$key_words=$_POST['key_words'];
	$send_method=$_POST['send_method'];
	$db=new DB();
	$sql="select count(1) from repair_list where {$send_method} like '%{$key_words}%';";
	$res=$db->execute($sql);
	foreach ($res as $value); 
	$page_num=$value['count(1)'];
	$db=new DB();
	$sql="select count(1) from repair_list where {$send_method} like '%{$key_words}%' and u_num={$u_num};";
	$res=$db->execute($sql);
	foreach ($res as $value); 
	$page_num2=$value['count(1)'];
	$smarty->assign("send_method",$send_method);//输出方法
	$smarty->assign("key_words",$key_words);//输出关键字
	$smarty->assign("search_type",$search_type);//输出关键字
	if($search_type=="all"){
				$page_rel=($page_num+$u_count-1)/$u_count;
				$page_rel=(int)$page_rel;//实际分？页
				if(!isset($now_page)){
				//第一页查询
					$start=0;
					$end=$start+$u_count;
					$sql="select * from repair_list where {$send_method} like '%{$key_words}%' order by id desc limit {$start},{$end};";
					$res=$db->execute($sql);
					$smarty->assign("resu1",$res);
					$smarty->assign("end",$end);
					$now_page=1;//起始页
					$smarty->assign("now_page",$now_page);
					$smarty->assign("end",$end);
					$smarty->assign("count",$page_num); //返回总数
					$smarty->assign("page_rel",$page_rel); //返回实际多少页
				}
	}else if($search_type=="mine"){
				$page_rel=($page_num2+$u_count-1)/$u_count;
				$page_rel=(int)$page_rel;//实际分？页
				if(!isset($now_page)){
				//第一页查询
					$start=0;
					$end=$start+$u_count;
					$sql="select * from repair_list where {$send_method} like '%{$key_words}%' and u_num={$u_num} order by id desc limit {$start},{$end};";
					$res=$db->execute($sql);
					$smarty->assign("resu1",$res);
					$smarty->assign("end",$end);
					$now_page=1;//起始页
					$smarty->assign("now_page",$now_page);
					$smarty->assign("end",$end);
					$smarty->assign("count",$page_num2); //返回总数
					$smarty->assign("page_rel",$page_rel); //返回实际多少页
	}
				
}
}

if(isset($_GET['now_page'])){
					$send_method=$_GET['send_method']; //获得搜索类型
					$smarty->assign("send_method",$send_method);		//返回搜索类型
					$now_page=$_GET['now_page']; //获得当前页
					$key_words=$_GET['key_words']; //获得关键字
					$page_method=$_GET['page_method']; 		//上一页 or 下一页
					$search_type=$_GET['search_type'];		//所有 or 我的
					$smarty->assign("key_words",$key_words);		//返回关键字
					$smarty->assign("search_type",$search_type);	 //返回 所有 or 我的
					$end=$_GET['end'];	 //获得最终页
					$count=$_GET['count'];	//获得总数
					$page_rel=$_GET['page_rel']; //获得实际分多少页
					if($search_type=="all"){
						if($now_page<=1 and $page_method=="pre"){
							echo"<script>alert('前面没有数据了！');history.go(-1);</script>";
						}
						if($now_page>=$page_rel and $page_method=="next"){
							echo"<script>alert('后面没有数据了！');history.go(-1);</script>";
						}
						if($page_method=="next" and $now_page<$page_rel){
							$start=$end;
							$sql="select * from repair_list where {$send_method} like '%{$key_words}%' order by id desc limit {$start},{$u_count};";
							$res=$db->execute($sql);
							$end=$start+$u_count;
							$smarty->assign("end",$end);
							$smarty->assign("resu1",$res);
							$now_page+=1;
							$smarty->assign("now_page",$now_page);
							$smarty->assign("count",$count); //返回总数
							$smarty->assign("page_rel",$page_rel); //返回实际多少页
						}	
						if($page_method=="pre" and $now_page>1){
							$start=$end-(2*$u_count);
							$sql="select * from repair_list where {$send_method} like '%{$key_words}%' order by id desc limit {$start},{$u_count};";
							$res=$db->execute($sql);
							$end=$start+$u_count;
							$smarty->assign("end",$end);
							$smarty->assign("resu1",$res);
							$now_page-=1;
							$smarty->assign("now_page",$now_page);
							$smarty->assign("count",$count); //返回总数
							$smarty->assign("page_rel",$page_rel); //返回实际多少页
						}
					}
					else if($search_type=="mine"){
						if($now_page<=1 and $page_method=="pre"){
							echo"<script>alert('前面没有数据了！');history.go(-1);</script>";
						}
						if($now_page>=$page_rel and $page_method=="next"){
							echo"<script>alert('后面没有数据了！');history.go(-1);</script>";
						}
						if($page_method=="next" and $now_page<$page_rel){
							$start=$end;
							$sql="select * from repair_list where {$send_method} like '%{$key_words}%' and u_num={$u_num} order by id desc limit {$start},{$u_count};";
							$res=$db->execute($sql);
							$end=$start+$u_count;
							$smarty->assign("end",$end);
							$smarty->assign("resu1",$res);
							$now_page+=1;
							$smarty->assign("now_page",$now_page);
							$smarty->assign("count",$count); //返回总数
							$smarty->assign("page_rel",$page_rel); //返回实际多少页
						}	
						if($page_method=="pre" and $now_page>1){
							$start=$end-(2*$u_count);
							$sql="select * from repair_list where {$send_method} like '%{$key_words}%' and u_num={$u_num} order by id desc limit {$start},{$u_count};";
							$res=$db->execute($sql);
							$end=$start+$u_count;
							$smarty->assign("end",$end);
							$smarty->assign("resu1",$res);
							$now_page-=1;
							$smarty->assign("now_page",$now_page);
							$smarty->assign("count",$count); //返回总数
							$smarty->assign("page_rel",$page_rel); //返回实际多少页
						}
					}
				}
//jump
				if(isset($_POST['jump'])){
				echo "暂未开发！";
				/*	$page_jump=$_POST['page_jump'];
					if($page_jump>$page_rel or $page_jump<1){
						echo"<script>alert('超出范围！');history.go(-1);</script>";
					}else{
					$start=$u_count*($page_jump-1);
$sql="select * from repair_list where {$send_method} like '%{$key_words}%' order by id desc limit {$start},{$u_count};";
					$res=$db->execute($sql);
					$end=$start+$u_count;
					$smarty->assign("end",$end);
					$smarty->assign("resu1",$res);
					$now_page=$page_jump;
					$smarty->assign("now_page",$now_page);
					}*/
				}
//关键字导出
if(isset($_POST['key_down'])){
	$key_words=$_POST['key_words'];
	$send_method=$_POST['send_method'];
	$search_type=$_POST['search_type'];
	if($search_type=="all"){
	$db=new DB();
	$file_name="keyword_"."{$send_method}"."_".date('Y-m-d_H:i:s',time())."_".$u_num.".csv";
	$sql="(select * from title_1) union all (select * from repair_list where {$send_method} like '%{$key_words}%' order by id desc into outfile '/opt/anto/anto_repair/uploads/{$file_name}' character set latin1 fields terminated by '\,' optionally enclosed by '\"' lines terminated by '\r\n');";
	$res=$db->execute($sql);
	$file="/opt/anto/anto_repair/uploads/".$file_name;
				if(is_file($file)) {
						header("Content-Type: application/force-download");
						header("Content-Disposition: attachment; filename=".basename($file));
						readfile($file);
						exit;
				}else{
						echo "文件不存在！";
						exit;
				}
	$smarty->assign("resu1",$res);
	$smarty->assign("key_words",$key_words);
	}else if($search_type=="mine"){
	$db=new DB();
	$file_name="keyword_"."{$send_method}"."_".date('Y-m-d_H:i:s',time())."_".$u_num.".csv";
	$sql="(select * from title_1) union all (select * from repair_list where {$send_method} like '%{$key_words}%' and u_num={$u_num} order by id desc into outfile '/opt/anto/anto_repair/uploads/{$file_name}' character set latin1 fields terminated by '\,' optionally enclosed by '\"' lines terminated by '\r\n');";
	$res=$db->execute($sql);
	$file="/opt/anto/anto_repair/uploads/".$file_name;
				if(is_file($file)) {
						header("Content-Type: application/force-download");
						header("Content-Disposition: attachment; filename=".basename($file));
						readfile($file);
						exit;
				}else{
						echo "文件不存在！";
						exit;
				}
	$smarty->assign("resu1",$res);
	$smarty->assign("key_words",$key_words);
	}
}
//Smarty
$smarty->display("key_words.tpl");
?>
