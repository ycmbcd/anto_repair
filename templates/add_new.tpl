<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>ANALYZA CUSTOMER SERVICE MAINTENANCE LIST</title>
<link href="../style/index.css" type="text/css" rel="stylesheet" />
<script src="../js/jquery.js" type="text/javascript" ></script>
<script src="../js/js.js" type="text/javascript" ></script>
<script type="text/javascript" src="../js/calendar.js" ></script> 

{literal}
<style>#calendarPanel{position:absolute;}</style>
<script>
 $(document).ready(function(){  
            //输入框大小  
            $(":text").css({
				"width":"300px",
				"height":"24px",
	});
  })
 //检查1970年1月1日
$(document).ready(function(){	
 	var one = $("#start_day")[0].value;
	var two = $("#over_day")[0].value;
	if(one == "0000-00-00"){
		$("#start_day").val("");
		}
 	if(two == "0000-00-00"){
		$("#over_day").val("");
		}
 })
//弹框
$(document).ready(function(){
	$("#btn_update").click(function(){
		$("#show_text").html("是否确认更新此订单")
		$("#show_box").css({"background":"#169f00"}).fadeIn(0);
		$("#shade").css({"background":"#6C9"}).fadeIn(0);
		$("#yes").attr("name","update");					
	})
	$("#btn_new").click(function(){
		$("#show_text").html("是否确认新建一个订单")
		$("#show_box").css({"background":"#a40000"}).fadeIn(0);
		$("#shade").css({"background":"#C30"}).fadeIn(0);
		$("#yes").attr("name","add_list");
		
	})				
	$("#no").click(function(){
		$("#show_box").fadeOut(0);
		$("#shade").fadeOut(0);
		$("#yes").attr("name","")
		$("#show_box").css({"background":"#9F9F9F"})
	})				
})
//标题完整字段展现
$(document).ready(function(){
	$("input").each(function(){			
		$(this).mouseover(function(){
			var a = $(this).val()
			timer = setTimeout(function(){
				$("#shower").fadeIn(0)												
				$("#shower").html(a)	
			},100)										
		})										
	})	
})	
</script>
<style>
#shower{
	width:100%;}
</style>
{/literal}
</head>

<body>
<div id="header" class="auto" style="top:0%;"  >
<div id="shower" class="left">ANALYZA CUSTOMER SERVICE MAINTENANCE LIST</div>
</div>

<div class="clear"></div>
<div id="add_list">
<div id="shade"></div>
<form method="post">
	<ul class="left tr">
    	<li>メルアド：</li>
        <li>注文番号：</li>
        <li>オークションID：</li>
        <li>店舗：</li>
        <li>お客様ID：</li>
        <li>ご購入者の電話番号</li>
        <li>ご購入者の郵便番号</li>
        <li>ご購入者の住所</li>
        <li>ご購入者の住所1</li>
        <li>ご購入者の住所2</li>
        <li>ご購入者：</li>
        <li>お届け先電話番号：</li>
        <li>お届け先郵便番号：</li>
        <li>お届け先住所：</li>
        <li>お届け先住所1：</li>
        <li>お届け先住所2：</li>
        <li>お届け先名称：</li>
        <li>合計金額：</li>
        <li>購入送料：</li>
        <li>購入手数料：</li>
        <li>購入ポイント：</li>
        <li>購入クーポン：</li>
        <li>購入消費税：</li>
        <li>商品：</li>
        <li>購入金額：</li>
        <li>購入方法：</li>
        <li>発送方法：</li>
        <li>発送番号：</li>        
    </ul>
    <ul class="left tl" style="width:500px;">
    	<li><input type="text" name="email" value="" /></li>
        <li><input type="text" name="order_id" value=""/></li>
        <li><input type="text" name="good_id" value="" /></li>
        <li><input type="text" name="store" value="" /></li>
        <li><input type="text" name="who_id" value="" /></li>
        <li><input type="text" name="who_phone" value="" /></li>
        <li><input type="text" name="who_code" value="" /></li>
        <li><input type="text" name="who_house" value="" /></li>
        <li><input type="text" name="who_house1" value="" /></li>
        <li><input type="text" name="who_house2" value="" /></li>
        <li><input type="text" name="who_name" value="" /></li>
        <li><input type="text" name="receive_phone" value="" /></li>
        <li><input type="text" name="receive_code" value="" /></li>
        <li><input type="text" name="receive_house" value="" /></li>
        <li><input type="text" name="receive_house1" value="" /></li>
        <li><input type="text" name="receive_house2" value="" /></li>
        <li><input type="text" name="receive_name" value="" /></li>
        <li><input type="text" name="total_money" value="" /></li>
        <li><input type="text" name="ems_money" value="" /></li>
        <li><input type="text" name="bill" value="" /></li>
        <li><input type="text" name="point" value="" /></li>
        <li><input type="text" name="cheap" value="" /></li>
        <li><input type="text" name="tax" value="" /></li>
        <li><input type="text" name="goods" value="" /></li>
        <li><input type="text" name="buy_money" value="" /></li>
        <li><input type="text" name="buy_method" value="" /></li>
        <li><input type="text" name="to_method" value="" /></li>
        <li><input type="text" name="send_num" value="" /></li>
        
    </ul>
    <ul class="left tr">
    	<li>発送日：</li>
        <li>対応開始日：</li>
  		<li>保証品1：</li>
        <li>保証品2：</li>
        <li>保証品3：</li>
        <li>保証品4：</li>
        <li>保証品5：</li>
        <li>対応種類：</li>
        <li>対応終了日：</li>
        <li>お支払い方法：</li>
        <li>金額：</li>
        <li>代引金額：</li>
        <li>出荷方法：</li>
        <li class="blue">ミス：</li>
        <li class="blue">評価：</li>
        <li class="blue">評価種類：</li>
        <li class="blue">写真：</li>
        <li class="blue">返品：</li>
        <li class="blue">返金：</li>
        <li>追跡番号：</li>
        <li>备注：</li>
        <li>操作员：</li>
        <li>操作ID：</li>
        <li>流水ID：</li>
        <li>対応方法：</li>
    </ul>
    <ul class="left tl" style="width:300px;">
    	<li><input type="text" name="send_day" value="" onclick="SelectDate(this,'yyyy-MM-dd')" /></li>
        <li><input type="text" id="start_day" name="start_day" value="" onclick="SelectDate(this,'yyyy-MM-dd')" readonly/></li>
    	<li><input type="text" name="re_good1" value="" /></li>
        <li><input type="text" name="re_good2" value="" /></li>
        <li><input type="text" name="re_good3" value="" /></li>
        <li><input type="text" name="re_good4" value="" /></li>
        <li><input type="text" name="re_good5" value="" /></li>
        <li>
          <select id="s1" name="add_type">
        	<option value ="-">-</option>
            <option value="新規">新規</option>
  			<option value ="保証">保証</option>
  			<option value ="其他">其他</option>
  			<option value="保証返金">保証返金</option>
            <option value="其他返金">其他返金</option>
		</select>
      </li>
        <li><input type="text" name="over_day" id="over_day" value="" onfocus="SelectDate(this,'yyyy-MM-dd')" readonly/></li>
        <li>
          <select id="s2" name="pay_method" >
        	<option value ="-">-</option>
  			<option value ="無料">無料</option>
  			<option value ="代金引換">代金引換</option>
  			<option value="銀行振込">銀行振込</option>
            <option value="着払い">着払い</option>
		</select>
      </li>	
        <li><input type="text" name="money" value="" /></li>
        <li><input type="text" name="receive_money" value="" /></li>
        <li>

        <select id="s3"  name="send_method">
        	<option value ="-">-</option>
  			<option value ="宅配便">宅配便</option>
  			<option value ="メール便">メール便</option>
		</select>
        </li>
        <li><input id="ppt1" onclick="SelectDate(this,'yyyy-MM-dd')" type="text" name="is_miss" value="" /></li>
        <li><input id="ppt2" onclick="SelectDate(this,'yyyy-MM-dd')" type="text" name="is_bad" value=""/></li>
      <li>
        <select id="s0"  name="say_type">
        	<option value ="-">-</option>
  			<option value ="产品质量">产品质量</option>
  			<option value ="货运">货运</option>
            <option value ="对应问题">对应问题</option>
            <option value ="客服MISS">客服MISS</option>
            <option value ="发货MISS">发货MISS</option>
            <option value ="后台MISS">后台MISS</option>
            <option value ="其他">其他</option>
		</select></li>
        <li><input id="ppt3" onclick="SelectDate(this,'yyyy-MM-dd')" type="text" name="is_photo" value=""/></li>
        <li><input id="ppt4" onclick="SelectDate(this,'yyyy-MM-dd')" type="text" name="is_receive" value=""/></li>
        <li><input id="ppt5" onfocus="SelectDate(this,'yyyy-MM-dd')" type="text" name="is_money" value=""/></li>
        <li><input type="text" name="ems" value="" /></li>
        <li><input type="text" name="other" value="" /></li>
        <li><input style="background:#CCC" type="text" value="{$u_name}" name="ok_name" readonly="readonly"/></li>
        <li><input style="background:#CCC" type="text" value="{$u_num}" name="ok_num" readonly="readonly" /></li>
        <li><input style="background:#CCC" type="text" value="系统将自动生成" readonly="readonly" /></li>
        <li><textarea rows="7" name="method"  cols="40" style="resize: none; padding-left:10px; padding-right:10px;"></textarea></li>
    </ul>
    <div class="clear"></div>
    <div class="auto" style="width:200px; margin-top:30px;">
        	<input id="btn_new" type="button" name="" value="新&nbsp;&nbsp;建 " class="sbtn left" style="height:40px;" />
        </div>
 
    	<div id="show_box">
			<div id="show_text"></div>
			<div id="yes_no" class="auto">
			<input type="submit" id="yes" value="yes" name=""/>
			<input type="button" id="no" value="no" />
			</div>
		</div>
</form>
</div>
<div class="clear"></div>
<div id="footer1">
<div style="width:600px;padding-top:4px; padding-left:20px; text-align:left;" class="left">
Powered by ycmbcd & pd
</div>
<div class="right" style="width:600px;height:20px; line-height:20px; font-size:14px;padding-right:20px;">欢迎您：{$u_name} 工号：{$u_num} | <a href="/show.php">返回列表</a> | <a href="logout.php" >退出</a></div>
</div>
</body>
</html>
