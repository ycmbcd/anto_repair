<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>ANALYZA CUSTOMER SERVICE MAINTENANCE LIST</title>
<link href="../style/index.css" type="text/css" rel="stylesheet" />
<script src="../js/jquery.js" type="text/javascript" ></script>
<script src="../js/js.js" type="text/javascript" ></script>
<script type="text/javascript" src="../js/calendar.js" ></script> 
<link href="./style/font-awesome.min.css" rel="stylesheet" />
<!--[if IE]>
<link href="./style/font-awesome-ie7.min.css" rel="stylesheet" />
<![endif]-->
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
//解决textarea符号冲突
function psp(){		
		var pspval = document.getElementById("textarea").value;													
		var str =  pspval.replace(/,/g,"，");					
		str =  str.replace(/'/g,"‘");
		str =  str.replace(/"/g,"“");	
		str =  str.replace(/\./g,"。");									
		document.getElementById("textarea").value=str;						
};	
function nds(){		
		var pspval = document.getElementById("textarea").value;													
		var str =  pspval.replace(/\n/g,"▉");									
		document.getElementById("textarea").value=str;						
};	
function wii(){		
		var pspval = document.getElementById("textarea").value;													
		var str =  pspval.replace(/\▉/g,"\n");									
		document.getElementById("textarea").value=str;						
};	
//message提示
function alert_message(e){
    $("#message_txt").text(e);
    //message
    $("#message_box").delay(100).animate({width:"600",opacity: "1"},400).delay(1500).animate({width:"300",opacity: "0"},400,function(){window.history.back(-1)});
}
function alert_error(e){
    $("#error_txt").text(e);
    //message
    $("#error_box").delay(700).animate({width:"600",opacity: "1"},500).delay(4000).animate({width:"300",opacity: "0"},500);
}
// 查看oms信息
function look_oms(){
    var order_id = $('#oms_order_id').val();
    
    $(".shadow_box").show();
    $.ajax({
        type:"GET",
        url:"/change_list.php",
        dataType: 'json',
        data: "oms_order_id="+order_id,
        success:function(data){
            console.log(data);
            var html = "";
            var html2 = "";
            if(data === 'no'){
                $("#oms_info").html('<div style="font-size:24px;color:#CF0"> <新OMS> 查无此单，请到 <旧OMS> 中查询！</div>');
                $("#oms_log").html('');
                return false;
            }
            $.each(data['res1'],function(index,json){
              html += '<tr><td align="right" width=20%>平台：</td><td class="info_val">'+json.station+'</td></tr>\
                    <tr><td align="right">店铺：</td><td class="info_val">'+json.store+'</td></tr>\
                    <tr><td align="right">购买时间：</td><td class="info_val">'+json.purchase_date+'</td></tr>\
                    <tr><td align="right">发货方式：</td><td class="info_val">'+json.send_method+'</td></tr>\
                    <tr><td align="right">发货仓：</td><td class="info_val">'+json.repo_status+'</td></tr>\
                    <tr><td align="right">快递公司：</td><td class="info_val">'+json.express_company+'</td></tr>\
                    <tr><td align="right">快递日期：</td><td class="info_val">'+json.express_day+'</td></tr>\
                    <tr><td align="right">快递单号：</td><td class="info_val">'+json.oms_order_express_num+'</td></tr>\
                    <tr><td align="right">客人备注：</td><td class="info_val">'+json.buyer_others+'</td></tr>\
                    <tr><td align="right">担当备注：</td><td class="info_val">'+json.order_note+'</td></tr>\
                    <tr><td align="right">指定配送日期：</td><td class="info_val">'+json.want_date+'</td></tr>\
                    <tr><td align="right">指定配送时间：</td><td class="info_val">'+json.want_time+'</td></tr>\
              ';
            });
            $.each(data['res2'],function(index,json){
              html2 += '<tr><td class="info_val">'+json.do_time+'</td><td class="info_val">'+json.who_name+'</td><td class="info_val">'+json.who_do+'</td></tr>\
              ';
            });
              html2 = '<tr><td class="info_val">时 间</td><td class="info_val">操作人</td><td class="info_val">操作日志</td></tr>'+html2;
            $("#oms_info").html(html);
            $("#oms_log").html(html2);
        } 
    });
}
function close_btn(){
    $(".shadow_box").hide();
}
</script>
<style>
#oms_order_id{
    width:200px !important;
    height: 18px !important;
}
#shower{
	width:100%;}
.shadow_box{
    width:100%;
    height: 100%;
    position: fixed; 
    background: rgba(0,0,0,0.6);
    display: none;
}
.close_btn{
    width:80px;
    height: 30px;
    background: #bc1d0b;
    color:#FFF;
    font-size:16px;
    text-align:center;
    line-height: 30px;
    border: 1px solid #2a2a2a;
    cursor: pointer;
    position: fixed;
    right:140px;
    bottom: 100px;
}
.close_btn:hover{
    background: #cf0;
    color:#333;
}
.tt{
    width:1000px;
    margin-top:10px;
    margin-left: 140px;
    color:#CF0;
    background: rgba(3,3,3,0.6);
}
.tt tr{
    height: 30px;
}
.tt td{
    border: 1px solid #525252;
    height: 20px;
    font-size: 14px;
}
.info_val{
    padding:6px 20px;
}
#oms_log{
    color: #dedede;
}
</style>
{/literal}
</head>
<div class="shadow_box">
    <div style="position: absolute;overflow: auto;height: 600px;">
        <table style="height: 300px;" id="oms_info" class="tt"></table>
        <table id="oms_log" class="tt"></table>
    </div>

    <div class="close_btn" onclick="close_btn()">关 闭</div>
</div>
<body onLoad="wii()">
<div id="header" class="auto" style="top:0%;"  >
<div id="shower" class="left">ANALYZA CUSTOMER SERVICE MAINTENANCE LIST</div>
</div>
<!--message弹框-->
<div id="message_box"><div id="message_logo" class="icon-bell-alt"></div><div id="message_txt"></div><div class="clearfix"></div></div>
<!--/message弹框-->
<!--error弹框-->
<div id="error_box"><div id="error_logo" class=" icon-ban-circle"></div><div id="error_txt"></div><div class="clearfix"></div></div>
<!--/error弹框-->
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
        <li>ご購入者の電話番号：</li>
        <li>ご購入者の郵便番号：</li>
        <li>ご購入者の住所：</li>
        <li>ご購入者の住所1：</li>
        <li>ご購入者の住所2：</li>
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
        <li>保修快递单号：</li>        
        <li>保修快递公司：</li>        
        <li>保修快递日期：</li>        
        <li>去信状态：</li>        
        <li>包裹ID：</li>        
    </ul>
{if $resu1}
	{section name=se loop=$resu1}
    <ul class="left tl" style="width:500px;">
    	<li><input type="text" name="email" value="{$resu1[se].email}" /> <a href="mailto:{$resu1[se].email}"><span class=" icon-envelope-alt"></span></a></li>
        <li><input type="text" name="order_id" value="{$resu1[se].order_id}"/></li>
        <li><input type="text" name="good_id" value="{$resu1[se].good_id}" /></li>
        <li><input type="text" name="store" value="{$resu1[se].store}" /></li>
        <li><input type="text" name="who_id" value="{$resu1[se].who_id}" /></li>
        <li><input type="text" name="who_phone" value="{$resu1[se].who_phone}" /></li>
        <li><input type="text" name="who_code" value="{$resu1[se].who_code}" /></li>
        <li><input type="text" name="who_house" value="{$resu1[se].who_house}" /></li>
        <li><input type="text" name="who_house1" value="{$resu1[se].who_house1}" /></li>
        <li><input type="text" name="who_house2" value="{$resu1[se].who_house2}" /></li>
        <li><input type="text" name="who_name" value="{$resu1[se].who_name}" /></li>
        <li><input type="text" name="receive_phone" value="{$resu1[se].receive_phone}" /></li>
        <li><input type="text" name="receive_code" value="{$resu1[se].receive_code}" /></li>
        <li><input type="text" name="receive_house" value="{$resu1[se].receive_house}" /></li>
        <li><input type="text" name="receive_house1" value="{$resu1[se].receive_house1}" /></li>
        <li><input type="text" name="receive_house2" value="{$resu1[se].receive_house2}" /></li>
        <li><input type="text" name="receive_name" value="{$resu1[se].receive_name}" /></li>
        <li><input type="text" name="total_money" value="{$resu1[se].total_money}" /></li>
        <li><input type="text" name="ems_money" value="{$resu1[se].ems_money}" /></li>
        <li><input type="text" name="bill" value="{$resu1[se].bill}" /></li>
        <li><input type="text" name="point" value="{$resu1[se].point}" /></li>
        <li><input type="text" name="cheap" value="{$resu1[se].cheap}" /></li>
        <li><input type="text" name="tax" value="{$resu1[se].tax}" /></li>
        <li><input type="text" name="goods" value="{$resu1[se].goods}" /></li>
        <li><input type="text" name="buy_money" value="{$resu1[se].buy_money}" /></li>
        <li><input type="text" name="buy_method" value="{$resu1[se].buy_method}" /></li>
        <li><input type="text" name="to_method" value="{$resu1[se].to_method}" /></li>
        <li><input type="text" name="send_num" value="{$resu1[se].send_num}" /></li>
        <li>{$resu1[se].re_express}</li>
        <li>{$resu1[se].re_company}</li>
        <li>{$resu1[se].re_date}</li>
        <li>{$resu1[se].re_mail}</li>
        <li>{$resu1[se].pack_id|default:'-'}</li>
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
        <li>配送指定日期：</li>
        <li>配送指定时间：</li>
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
    	<li><input type="text" name="send_day" value="{$resu1[se].send_day}" onclick="SelectDate(this,'yyyy-MM-dd')" /></li>
        <li><input type="text" id="start_day" name="start_day" value="{$resu1[se].start_day}" onclick="SelectDate(this,'yyyy-MM-dd')" readonly/></li>
    	<li><input type="text" name="re_good1" value="{$resu1[se].re_good1}" /></li>
        <li><input type="text" name="re_good2" value="{$resu1[se].re_good2}" /></li>
        <li><input type="text" name="re_good3" value="{$resu1[se].re_good3}" /></li>
        <li><input type="text" name="re_good4" value="{$resu1[se].re_good4}" /></li>
        <li><input type="text" name="re_good5" value="{$resu1[se].re_good5}" /></li>
        <li><input type="hidden" value="{$resu1[se].add_type}" id="ss1"  />
        <select id="s1" name="add_type"  style="background:#FFFFF1;">
        	<option value ="-">-</option>
            <option value="新規">新規</option>
  			<option value ="保証">保証</option>
  			<option value ="其他">其他</option>
  			<option value="保証返金">保証返金</option>
            <option value="其他返金">其他返金</option>
            <option value="返品表">返品表</option>
		</select>
        </li>
        <li><input type="text" name="over_day" id="over_day" value="{$resu1[se].over_day}" onfocus="SelectDate(this,'yyyy-MM-dd')" readonly/></li>
        <li>
        <input type="hidden" value="{$resu1[se].pay_method}" id="ss2" />
        <select id="s2" name="pay_method"  style="background:#FFFFF1;" >
        	<option value ="-">-</option>
  			<option value ="無料">無料</option>
  			<option value ="代金引換">代金引換</option>
  			<option value="銀行振込">銀行振込</option>
            <option value="着払い">着払い</option>
		</select>
        </li>	
        <li><input type="text" name="money" value="{$resu1[se].money}" /></li>
        <li><input type="text" name="receive_money" value="{$resu1[se].receive_money}" /></li>
        <li>
        <input type="hidden" value="{$resu1[se].send_method}" id="ss8" />
        <select id="s8"  name="send_method"  style="background:#FFFFF1;">
        	<option value ="-">-</option>
  			<option value ="宅配便">宅配便</option>
            <option value ="DM便">DM便</option>
            <option value ="ネコポス">ネコポス</option>
            <option value ="メール便">メール便</option>
  			<option value ="着払い">着払い</option>
		</select>
        </li>
        <li>
            <input id="want_date" onclick="SelectDate(this,'yyyy-MM-dd')" readonly type="text" name="want_date" value="{$resu1[se].want_date}"/>
        </li>
        <li>
        <input type="hidden" value="{$resu1[se].want_time}" id="ss9" />
        <select id="s9"  name="want_time"  style="background:#FFFFF1;">
            <option value ="">-</option>
            <option value ="09:00～12:00">09:00～12:00</option>
            <option value ="12:00～14:00">12:00～14:00</option>
            <option value ="14:00～16:00">14:00～16:00</option>
            <option value ="16:00～18:00">16:00～18:00</option>
            <option value ="18:00～20:00">18:00～20:00</option>
            <option value ="20:00～21:00">20:00～21:00</option>
        </select>
        </li>
        <li><input id="ppt1" onclick="SelectDate(this,'yyyy-MM-dd')" type="text" name="is_miss" value="{$resu1[se].is_miss}" /></li>
        <li><input id="ppt2" onclick="SelectDate(this,'yyyy-MM-dd')" type="text" name="is_bad" value="{$resu1[se].is_bad}"/></li>
      <li>
        <input type="hidden" value="{$resu1[se].say_type}" id="ss0" />
        <select id="s0"  name="say_type"  style="background:#FFFFF1;">
        	<option value ="-">-</option>
  			<option value ="产品质量">产品质量</option>
  			<option value ="货运">货运</option>
            <option value ="对应问题">对应问题</option>
            <option value ="客服MISS">客服MISS</option>
            <option value ="发货MISS">发货MISS</option>
            <option value ="后台MISS">后台MISS</option>
            <option value ="其他">其他</option>
		</select></li>
        <li><input id="ppt3" onclick="SelectDate(this,'yyyy-MM-dd')" type="text" name="is_photo" value="{$resu1[se].is_photo}"/></li>
        <li><input id="ppt4" onclick="SelectDate(this,'yyyy-MM-dd')" type="text" name="is_receive" value="{$resu1[se].is_receive}"/></li>
        <li><input id="ppt5" onfocus="SelectDate(this,'yyyy-MM-dd')" type="text" name="is_money" value="{$resu1[se].is_money}"/></li>
        <li><input type="text" name="ems" value="{$resu1[se].ems}" /></li>
        <li><input type="text" name="other" value="{$resu1[se].other}" /></li>
        <li><input class="cccc" type="text" value="{$resu1[se].u_name}" name="ok_name" readonly="readonly"/></li>
        <li><input class="cccc" type="text" value="{$resu1[se].u_num}" name="ok_num" readonly="readonly" /></li>
        <li><input class="cccc" type="text" value="{$resu1[se].id}" readonly="readonly" /></li>
        <li><textarea  id="textarea" onKeyUp="psp()" rows="14" name="method"  cols="45" style="background:#FFFFF1;resize: none; padding-left:10px; padding-right:10px;">{$resu1[se].method}</textarea></li>
    </ul>
    <div class="clear"></div>
    <div class="auto" style="width:200px; margin-top:30px;">
        	<input id="btn_new" type="button"  value="新&nbsp;&nbsp;建 " class="sbtn left" style="height:40px;" />
    		<input id="btn_update" type="button"   value="更&nbsp;&nbsp;新 " class="sbtn right" style="height:40px;" />
        </div>
    {/section}
    	<div id="show_box">
			<div id="show_text"></div>
			<div id="yes_no" class="auto">
			<input type="submit" id="yes" onMouseOut="wii()" onMouseOver="nds()" value="Yes" name=""/>
			<input type="button" id="no" onMouseOut="wii()" onMouseOver="nds()" value="No" />
			</div>
		</div>
</form>
{/if}
</div>
<div class="clear"></div>
<div id="footer1">
<div style="width:400px;padding-top:4px; padding-left:20px; text-align:left;" class="left">
Powered by ycmbcd & pd
</div>
<div class="right" style="width:620px;height:20px; line-height:20px; font-size:14px;padding-right:10px;">
    <input placeholder="注文番号" type="text" id="oms_order_id" />
    <a href="#" onclick="look_oms()">→ 查询oms</a> | 
    欢迎您：{$u_name} 工号：{$u_num} | <a href="/show.php">返回列表</a> | <a href="logout.php" >退出</a></div>
</div>
</body>
</html>
