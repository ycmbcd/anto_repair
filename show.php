<?php
//开启session
	session_start();
	error_reporting(E_ALL^E_NOTICE^E_WARNING);
	date_default_timezone_set('prc');
	require_once "tpl.class.php";
	require_once "db.php";
	ini_set('memory_limit','1000M');
	$dir = dirname(__FILE__);
	require_once($dir."/pdo/oms.class.php");	//引入pdo
	require_once($dir."/myclass/PHPExcel/PHPExcel.php");//引入PHPExcel	
	$odb = new OmsPdoMySQL();
set_time_limit(0); 
ini_set("memory_limit", "1024M");
@$u_num=$_SESSION['re_u_num'];
	if($u_num==""){
	echo "<script>alert('您还没有登陆，请登陆！');window.location='index.php';</script>";
}else{
	$smarty->assign("u_num",$u_num);
}
//分页类
class Pages{
	public $page_list;
	public $page_num;
	public $oSql;
	public function page($page_list,$page_num,$oSql){
				global $smarty;
				global $db;
				$page_rel=($page_num+$page_list-1)/$page_list;
				$page_rel=(int)$page_rel;//实际分？页
				$smarty->assign("page_rel",$page_rel); //前台显示
				if(!isset($now_page)){
				//第一页查询
					$start=0;
					$end=$start+$page_list;
					$sql="{$oSql} order by id desc limit {$start},{$end};";
					$res=$db->execute($sql);
					$smarty->assign("resu1",$res);
					$smarty->assign("end",$end);
					$now_page=1;//起始页
					$smarty->assign("now_page",$now_page);
					$smarty->assign("end",$end);
				}
				if(isset($_GET['now_page'])){
					$now_page=$_GET['now_page'];
					$page_method=$_GET['page_method'];
					$end=$_GET['end'];
					$oSql=$_GET['oSql'];
					$count=$_GET['count'];
					$page_rel=$_GET['page_rel'];
					$smarty->assign("oSql",$oSql);
					$smarty->assign("count",$count);
					$smarty->assign("page_rel",$page_rel);
						if($now_page<=1 and $page_method=="pre"){
							echo"<script>alert('前面没有数据了！');history.go(-1);</script>";
						}
						if($now_page>=$page_rel and $page_method=="next"){
							echo"<script>alert('后面没有数据了！');history.go(-1);</script>";
						}
						if($page_method=="next" and $now_page<$page_rel){
							$start=$end;
							$sql="{$oSql} order by id desc limit {$start},{$page_list};";
							$res=$db->execute($sql);
							$end=$start+$page_list;
							$smarty->assign("end",$end);
							$smarty->assign("resu1",$res);
							$now_page+=1;
							$smarty->assign("now_page",$now_page);
						}	
						if($page_method=="pre" and $now_page>1){
							$start=$end-(2*$page_list);
							$sql="{$oSql} order by id desc limit {$start},{$page_list};";
							$res=$db->execute($sql);
							$end=$start+$page_list;
							$smarty->assign("end",$end);
							$smarty->assign("resu1",$res);
							$now_page-=1;
							$smarty->assign("now_page",$now_page);
						}
				}
				//jump
				if(isset($_POST['jump'])){
				echo "暂未开发！";die;
					$page_jump=$_POST['page_jump'];
					if($page_jump>$page_rel or $page_jump<1){
						echo"<script>alert('超出范围！');history.go(-1);</script>";
					}else{
					$start=$page_list*($page_jump-1);
					$sql="{$oSql} order by id desc limit {$start},{$page_list};";
					$res=$db->execute($sql);
					$end=$start+$page_list;
					$smarty->assign("end",$end);
					$smarty->assign("resu1",$res);
					$now_page=$page_jump;
					$smarty->assign("now_page",$now_page);
					}
				}
	}
}
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
//展示列表
		$db=new DB();
		$sql="select count(1) from repair_list";//1的效率比*高
		$res=$db->execute($sql);
		foreach ($res as $value); 
		$page_num=$value['count(1)'];
		$smarty->assign("count",$page_num);//输出总数
		$oSql="select * from repair_list";
		$smarty->assign("oSql",$oSql);
		$to_Page=new Pages();
		$to_Page->page($u_count,$page_num,$oSql);
//遍历所有工号至前端
		$db=new DB();
		$sql="select u_num from user;";
		$res=$db->execute($sql);
		$smarty->assign("team",$res);
//---------------------------------------------------------------全功能查询--------------------------------------------------------------------------#
if(isset($_POST['search'])){
	//获取参数
	$the_day=$_POST['the_day'];
	$start_time=$_POST['start_time'];
	$end_time=$_POST['end_time'];
	$send_method=$_POST['send_method'];
	$key_words=$_POST['key_words'];
	$kefu=$_POST['kefu'];
	//返回前端值
	$smarty->assign("the_day",$the_day);
	$smarty->assign("start_time",$start_time);
	$smarty->assign("end_time",$end_time);
	$smarty->assign("send_method",$send_method);
	$smarty->assign("key_words",$key_words);
	$smarty->assign("kefu",$kefu);
	//这是一个牛逼的搜索，在2.0版本中精简了200行代码。
	if($the_day=='all_day'){
		$the_day = "send_day";  //！！！系统后台唯有send_day数据非空！！！2014年12月14日19:52:47 by ycmbcd
		$start_time = "send_day";
		$end_time = "send_day";
	}else{
		if($start_time=='' or $end_time==''){
				echo "<script>alert('请填写正确时间区间！');window.location='show.php';</script>";
				return false;
		}
		$start_time = "'$start_time'";
		$end_time = "'$end_time'";
	}
	if($_POST['send_method']=='no_keywords'){
		$key_words="";
		$send_method = "send_method";
	}
	if($_POST['kefu']=='team'){
		$kefu = ""; //like匹配空
	}
	$db=new DB();
	$sql="select count(1) from repair_list where 1=1 and {$the_day} between {$start_time} and {$end_time} and  ifnull({$send_method},0) like '%{$key_words}%' and ifnull(u_num,0) like '%{$kefu}%';";
	$res=$db->execute($sql);
	foreach ($res as $value); 
	$page_num=$value['count(1)'];
	$smarty->assign("count",$page_num);//输出总数
	$oSql="select * from repair_list where 1=1 and {$the_day} between {$start_time} and {$end_time} and  ifnull({$send_method},0) like '%{$key_words}%' and ifnull(u_num,0) like '%{$kefu}%'";
	$to_Page=new Pages();
	$to_Page->page($u_count,$page_num,$oSql);	
}
//---------------------------------------------------------------全功能导出--------------------------------------------------------------------------#
if(isset($_POST['down'])){
	//获取参数
	$the_day=$_POST['the_day'];
	$start_time=$_POST['start_time'];
	$end_time=$_POST['end_time'];
	$send_method=$_POST['send_method'];
	$key_words=$_POST['key_words'];
	$kefu=$_POST['kefu'];
	//给文件一个名字
	$file_name=$kefu."_".$the_day."_".$send_method."_".date('Ymd_H-i-s',time()).".xlsx";
	//返回前端值
	$smarty->assign("the_day",$the_day);
	$smarty->assign("start_time",$start_time);
	$smarty->assign("end_time",$end_time);
	$smarty->assign("send_method",$send_method);
	$smarty->assign("key_words",$key_words);
	$smarty->assign("kefu",$kefu);
	//验证
	if($the_day=='all_day'){
		$the_day = "send_day";  //！！！系统后台唯有send_day数据非空！！！2014-12-14 by ycmbcd
		$start_time = "send_day";
		$end_time = "send_day";
	}else{
		if($start_time=='' or $end_time==''){
				echo "<script>alert('请填写正确时间区间！');window.location='show.php';</script>";
				return false;
		}
		$start_time = "'$start_time'";
		$end_time = "'$end_time'";
	}
	if($_POST['send_method']=='no_keywords'){
		$key_words="";
		$send_method = "send_method";
	}
	if($_POST['kefu']=='team'){
		$kefu = ""; //like匹配空
	}
    //PHPExcel
	$objPHPExcel = new PHPExcel();
	$objSheet = $objPHPExcel->getActiveSheet();
	$objSheet->setTitle("ANTO售后表");//表名
	$objSheet->setCellValue("A1","售后ID")->setCellValue("B1","メルアド")->setCellValue("C1","注文番号")->setCellValue("D1","オークションID")->setCellValue("E1","店舗")->setCellValue("F1","お客様ID")->setCellValue("G1","ご購入者の電話番号")->setCellValue("H1","ご購入者のテ")->setCellValue("I1","ご購入者の住所
")->setCellValue("J1","1")->setCellValue("k1","2")->setCellValue("L1","ご購入者")->setCellValue("M1","お届け先電話番号")->setCellValue("N1","お届け先のテ")->setCellValue("O1","お届け先住所")->setCellValue("P1","1")->setCellValue("Q1","2")->setCellValue("R1","お届け先名称")->setCellValue("S1","合計金額")->setCellValue("T1","購入送料")->setCellValue("U1","購入手数料")->setCellValue("V1","購入ポイント")->setCellValue("W1","購入クーポン")->setCellValue("X1","購入消費税")->setCellValue("Y1","商品")->setCellValue("Z1","購入金額")->setCellValue("AA1","購入方法")->setCellValue("AB1","発送方法")->setCellValue("AC1","発送番号")->setCellValue("AD1","発送日")->setCellValue("AE1","対応開始日")->setCellValue("AF1","対応方法")->setCellValue("AG1","保証品1")->setCellValue("AH1","保証品2")->setCellValue("AI1","保証品3")->setCellValue("AJ1","保証品4")->setCellValue("AK1","保証品5")->setCellValue("AL1","対応種類")->setCellValue("AM1","対応終了日")->setCellValue("AN1","お支払い方法")->setCellValue("AO1","金額")->setCellValue("AP1","代引金額")->setCellValue("AQ1","出荷方法")->setCellValue("AR1","ミス")->setCellValue("AS1","評価")->setCellValue("AT1","評価種類")->setCellValue("AU1","写真")->setCellValue("AV1","返品")->setCellValue("AW1","返金")->setCellValue("AX1","追跡番号")->setCellValue("AY1","操作员")->setCellValue("AZ1","操作ID")->setCellValue("BA1","备注");//表头值
	$objSheet->getStyle("A1:J1")->getFont()->setSize(12)->setBold(True);//表头字体
	$objSheet->getDefaultStyle()->getFont()->setName("微软雅黑")->setSize(12);//默认字体
	$objPHPExcel->getActiveSheet()->getStyle('A:BA')->getAlignment()->setVertical(PHPExcel_Style_Alignment::VERTICAL_CENTER);//垂直居中
	$objPHPExcel->getActiveSheet()->getStyle('A1:BA1')->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_WHITE);//前景色
	$objSheet->getStyle('A1:BA1')->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
	$objSheet->getStyle('A1:BA1')->getFill()->getStartColor()->setRGB('000000');//背景色
	//$objSheet->getColumnDimension('A')->setWidth(20);//单元格宽
	$objSheet->getDefaultRowDimension()->setRowHeight(18);   //单元格高
	$objSheet->freezePane('A2');//冻结表头
	$objPHPExcel->getActiveSheet()->getStyle('A')->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_LEFT);//左对齐
	//sql
		$sql = "SELECT * from repair_list where 1=1 and {$the_day} between {$start_time} and {$end_time} and  ifnull({$send_method},0) like '%{$key_words}%' and ifnull(u_num,0) like '%{$kefu}%' order by id desc;";
		$res = $db->execute($sql);
		$j=2;
		foreach ($res as $key => $value) {
			$objSheet->setCellValueExplicit("A".$j,$value['id'],PHPExcel_Cell_DataType::TYPE_STRING)->setCellValue("B".$j,$value['email'])->setCellValueExplicit("C".$j,$value['order_id'],PHPExcel_Cell_DataType::TYPE_STRING)->setCellValue("D".$j,$value['good_id'])->setCellValue("E".$j,$value['store'])->setCellValue("F".$j,$value['who_id'])->setCellValue("G".$j,$value['who_phone'])->setCellValue("H".$j,$value['who_code'])->setCellValue("I".$j,$value['who_house'])->setCellValue("J".$j,$value['who_house1'])->setCellValue("K".$j,$value['who_house2'])->setCellValue("L".$j,$value['who_name'])->setCellValue("M".$j,$value['receive_phone'])->setCellValue("N".$j,$value['receive_code'])->setCellValue("O".$j,$value['receive_house'])->setCellValue("P".$j,$value['receive_house1'])->setCellValue("Q".$j,$value['receive_house2'])->setCellValue("R".$j,$value['receive_name'])->setCellValue("S".$j,$value['total_money'])->setCellValue("T".$j,$value['ems_money'])->setCellValue("U".$j,$value['bill'])->setCellValue("V".$j,$value['point'])->setCellValue("W".$j,$value['cheap'])->setCellValue("X".$j,$value['tax'])->setCellValue("Y".$j,$value['goods'])->setCellValue("Z".$j,$value['buy_money'])->setCellValue("AA".$j,$value['buy_method'])->setCellValue("AB".$j,$value['to_method'])->setCellValue("AC".$j,$value['send_num'])->setCellValue("AD".$j,$value['send_day'])->setCellValue("AE".$j,$value['start_day'])->setCellValue("AF".$j,$value['method'])->setCellValue("AG".$j,$value['re_good1'])->setCellValue("AH".$j,$value['re_good2'])->setCellValue("AI".$j,$value['re_good3'])->setCellValue("AJ".$j,$value['re_good4'])->setCellValue("AK".$j,$value['re_good5'])->setCellValue("AL".$j,$value['add_type'])->setCellValue("AM".$j,$value['over_day'])->setCellValue("AN".$j,$value['pay_method'])->setCellValue("AO".$j,$value['money'])->setCellValue("AP".$j,$value['receive_money'])->setCellValue("AQ".$j,$value['send_method'])->setCellValue("AR".$j,$value['is_miss'])->setCellValue("AS".$j,$value['is_bad'])->setCellValue("AT".$j,$value['say_type'])->setCellValue("AU".$j,$value['is_photo'])->setCellValue("AV".$j,$value['is_receive'])->setCellValue("AW".$j,$value['is_money'])->setCellValue("AX".$j,$value['ems'])->setCellValue("AY".$j,$value['u_name'])->setCellValue("AZ".$j,$value['u_num'])->setCellValue("BA".$j,$value['other']);
			$j++;
		}
		$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
		$objWriter->save($dir."/down/".$file_name);	//保存在服务器
		$file="/down/".$file_name;
		echo '<script>window.open("'.$file.'")</script>';
}
//------------------------------------------------------------导出佐川发货单--------------------------------------------------------------
if(isset($_POST['zuochuan'])){
	//下午1点半导出按照对应终了日发货，有时间区间
	$start_time=$_POST['start_time'];
	$end_time=$_POST['end_time'];
	$the_day=$_POST['the_day'];
	if($start_time=='' or $end_time==''){
		echo "<script>alert('请填写正确的【终了日】或【快递日期】区间！');window.location='show.php';</script>";
		return false;
	}
	if($the_day!=='over_day' and $the_day!=='re_date'){
		echo "<script>alert('请选择【终了日】或【快递日期】！');window.location='show.php';</script>";
		return false;
	}

	$file_name="zuochuan_"."_".date('Ymd_H-i-s',time())."_".$u_num.".xlsx";
	$title_day=$start_time."~".$end_time;
	//PHPExcel
	$objPHPExcel = new PHPExcel();
	$objSheet = $objPHPExcel->getActiveSheet();
	$objSheet->setTitle($title_day);//表名
	$objSheet->setCellValue("A1","商品代码")->setCellValue("B1","数量")->setCellValue("C1","电话")->setCellValue("D1","邮编")->setCellValue("E1","地址")->setCellValue("F1","收件人")->setCellValue("I1","代引金額")->setCellValue("K1","配送方式")->setCellValue("M1","售后包裹ID")->setCellValue("N1","邮箱")->setCellValue("O1","")->setCellValue("P1","售后注文番号")->setCellValue("Q1","")->setCellValue("R1","店铺名")->setCellValue("S1","担当者")->setCellValue("T1","保修快递单")->setCellValue("V1","保修快递日期")->setCellValue("U1","保修快递公司")->setCellValue("W1","终了日");//表头值
	$objSheet->getDefaultStyle()->getFont()->setName("微软雅黑")->setSize(12);//默认字体
	$objPHPExcel->getActiveSheet()->getStyle('A:W')->getAlignment()->setVertical(PHPExcel_Style_Alignment::VERTICAL_CENTER);//垂直居中
	$objPHPExcel->getActiveSheet()->getStyle('A1:W1')->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_WHITE);//前景色
	$objSheet->getStyle('A1:W1')->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
	$objSheet->getStyle('A1:W1')->getFill()->getStartColor()->setRGB('363FFB');//背景色
	$objSheet->getStyle('J1')->getFill()->getStartColor()->setARGB('FF3300');
	$objSheet->getStyle('L1')->getFill()->getStartColor()->setARGB('FF3300');
	//$objSheet->getColumnDimension('A')->setWidth(20);//单元格宽
	$objSheet->getDefaultRowDimension()->setRowHeight(18);   //单元格高
	$objSheet->freezePane('A2');//冻结表头
	$objPHPExcel->getActiveSheet()->getStyle('A')->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_LEFT);//左对齐
	
		$sql = "
		SELECT re_good1 as goods_code,receive_phone,receive_code,receive_house,receive_name,id,receive_money,send_method,email,store,u_name,add_type,money,re_express,re_company,re_date,over_day,pack_id from repair_list where {$the_day} between '{$start_time}' and '{$end_time}' union all select re_good2 as goods_code,receive_phone,receive_code,receive_house,receive_name,id,receive_money,send_method,email,store,u_name,add_type,money,re_express,re_company,re_date,over_day,pack_id from repair_list where {$the_day} between '{$start_time}' and '{$end_time}' union all select re_good3 as goods_code,receive_phone,receive_code,receive_house,receive_name,id,receive_money,send_method,email,store,u_name,add_type,money,re_express,re_company,re_date,over_day,pack_id from repair_list where {$the_day} between '{$start_time}' and '{$end_time}' union all select re_good4 as goods_code,receive_phone,receive_code,receive_house,receive_name,id,receive_money,send_method,email,store,u_name,add_type,money,re_express,re_company,re_date,over_day,pack_id from repair_list where {$the_day} between '{$start_time}' and '{$end_time}' union all select re_good5 as goods_code,receive_phone,receive_code,receive_house,receive_name,id,receive_money,send_method,email,store,u_name,add_type,money,re_express,re_company,re_date,over_day,pack_id from repair_list where {$the_day} between '{$start_time}' and '{$end_time}';";
		$res = $db->execute($sql);
		$j=2;
		foreach ($res as $key => $row) {
			$money[$key] = $row['money'];
		}
		array_multisort($money, SORT_DESC, $res);

		$now_item = '';
		$now_money = 0;

		foreach ($res as $key => $value) {
			//如果goods_code为空，跳过
			if($value['goods_code']==""){
				continue;
			}
			// 订单重复总金额跳过
			if($value['id'] == $now_item){
				$now_money = 0;
			}else{
				$now_item = $value['id'];
				$now_money = $value['money'];
			}
			// echo $now_item.'-----'.$now_money.'<hr>';
			//售后id拼接,注文番号
			$oms_id="b".$value['id'];
			$order_id="b".$value['id'];
			$arr=array();
			$arr=explode("*",$value['goods_code']);
			if(isset($arr)){
				$goods_code = $arr[0];
				//如果不是sku，那么跳过
				// if($goods_code==$value['goods_code']){
				// 	continue;
				// }
				$num = $arr[1];
			}
			// 到oms 获取 包裹ID
			// $sql = "SELECT pack_id FROM history_send WHERE order_id = '{$order_id}' AND goods_code = '{$goods_code}'";
			// $res = $odb->getOne($sql);
			// $pack_id = $res['pack_id'];
			$email = $value['email'];
			$result = explode(' ',$email);
			$email = $result[0];
			$objSheet->setCellValue("A".$j,$goods_code);
			$objSheet->setCellValue("B".$j,$num);
			$objSheet->setCellValue("C".$j,$value['receive_phone']);
			$objSheet->setCellValue("D".$j,$value['receive_code']);
			$objSheet->setCellValue("E".$j,$value['receive_house']);
			$objSheet->setCellValue("F".$j,$value['receive_name']);
			$objSheet->setCellValue("I".$j,$value['receive_money']);
			$objSheet->setCellValue("I".$j,$value['receive_money']);
			$objSheet->setCellValue("J".$j,$value['add_type']);
			$objSheet->setCellValue("K".$j,$value['send_method']);
			$objSheet->setCellValue("L".$j,$now_money);
			$objSheet->setCellValue("M".$j,$value['pack_id']);
			$objSheet->setCellValue("N".$j,$email);
			$objSheet->setCellValue("P".$j,$order_id);
			$objSheet->setCellValue("R".$j,$value['store']);
			$objSheet->setCellValue("S".$j,$value['u_name']);
			$objSheet->setCellValue("T".$j,$value['re_express']);
			$objSheet->setCellValue("U".$j,$value['re_company']);
			$objSheet->setCellValue("V".$j,$value['re_date']);
			$objSheet->setCellValue("W".$j,$value['over_day']);
			$j++;
		}
		
		$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
		$objWriter->save($dir."/down/".$file_name);	//保存在服务器
		$file="/down/".$file_name;
		echo '<script>window.open("'.$file.'")</script>';
		//老的佐川表
	// 	//PHPExcel
	// $objPHPExcel = new PHPExcel();
	// $objSheet = $objPHPExcel->getActiveSheet();
	// $objSheet->setTitle($title_day);//表名
	
	// $objSheet->getDefaultStyle()->getFont()->setName("微软雅黑")->setSize(12);//默认字体
	// $objPHPExcel->getActiveSheet()->getStyle('A:BA')->getAlignment()->setVertical(PHPExcel_Style_Alignment::VERTICAL_CENTER);//垂直居中
	// $objPHPExcel->getActiveSheet()->getStyle('A1:BA1')->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_WHITE);//前景色
	// $objSheet->getStyle('A1:BA1')->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
	// $objSheet->getStyle('A1:BA1')->getFill()->getStartColor()->setRGB('363FFB');//背景色
	// //$objSheet->getColumnDimension('A')->setWidth(20);//单元格宽
	// $objSheet->getDefaultRowDimension()->setRowHeight(18);   //单元格高
	// $objSheet->freezePane('A2');//冻结表头
	// $objPHPExcel->getActiveSheet()->getStyle('A')->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_LEFT);//左对齐
	// 	$file_name='old_'.$file_name;
	// 	//sql
	// 	 $sql = "(select u_name,receive_phone,receive_code,receive_house,receive_house1,receive_house2,receive_name,send_method,add_type,over_day,store,goods,money,'','','','','','',re_good1,re_good2,re_good3,re_good4,re_good5,'','','','','','',receive_money from title_1) union all (select u_name,receive_phone,receive_code,receive_house,receive_house1,receive_house2,receive_name,send_method,add_type,over_day,store,goods,money,'','','','','','',re_good1,re_good2,re_good3,re_good4,re_good5,'','','','','','',receive_money from repair_list where over_day between '{$start_time}' and '{$end_time}' order by id desc);";
	// 	 $res = $db->execute($sql);
	// 	 $j=1;
	// 	 foreach ($res as $key => $value) {
	// 		$objSheet->setCellValue("A".$j,$value['u_name'])->setCellValue("B".$j,$value['receive_phone'])->setCellValueExplicit("C".$j,$value['receive_code'],PHPExcel_Cell_DataType::TYPE_STRING)->setCellValue("D".$j,$value['receive_house'])->setCellValue("E".$j,$value['receive_house1'])->setCellValue("F".$j,$value['receive_house2'])->setCellValue("G".$j,$value['receive_name'])->setCellValue("H".$j,$value['send_method'])->setCellValue("I".$j,$value['add_type'])->setCellValue("J".$j,$value['over_day'])->setCellValue("K".$j,$value['store'])->setCellValue("L".$j,$value['goods'])->setCellValue("M".$j,$value['money'])->setCellValue("N".$j,$value[''])->setCellValue("O".$j,$value[''])->setCellValue("P".$j,$value[''])->setCellValue("Q".$j,$value[''])->setCellValue("R".$j,$value[''])->setCellValue("S".$j,$value[''])->setCellValue("T".$j,$value['re_good1'])->setCellValue("U".$j,$value['re_good2'])->setCellValue("V".$j,$value['re_good3'])->setCellValue("W".$j,$value['re_good4'])->setCellValue("X".$j,$value['re_good5'])->setCellValue("Y".$j,$value[''])->setCellValue("Z".$j,$value[''])->setCellValue("AA".$j,$value[''])->setCellValue("AB".$j,$value[''])->setCellValue("AC".$j,$value[''])->setCellValue("AD".$j,$value[''])->setCellValue("AE".$j,$value['receive_money']);
	// 	 	$j++;
	// 	 }
	// 	$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
	// 	$objWriter->save($dir."/down/".$file_name);	//保存在服务器
	// 	$file="/down/".$file_name;
	// 	echo '<script>window.open("'.$file.'")</script>';
}
//Smarty
$smarty->display("show.tpl");
?>
