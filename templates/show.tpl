<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>ANALYZA CUSTOMER SERVICE MAINTENANCE LIST</title>
<link href="../style/index.css" type="text/css" rel="stylesheet" />
<script src="../js/jquery.js" type="text/javascript" ></script> 
<script src="../js/jquery.textSearch-1.0.js" type="text/javascript" ></script> 
<script type="text/javascript" src="../js/calendar.js" ></script> 
<link href="./style/font-awesome.min.css" rel="stylesheet" />
<!--[if IE]>
<link href="./style/font-awesome-ie7.min.css" rel="stylesheet" />
<![endif]-->
{literal}
<style>#calendarPanel{position:fixed;}</style>
<script type="text/javascript">
$(document).ready(function(){
	$("#calendarPanel").css({
		"posion":"fixed"
	})
    
})
//u_count
$(document).ready(function(){
	var count=document.getElementById("u_count").innerHTML;
	if(count==""){
		document.getElementById("u_count").innerHTML="30";
	}
})
//检索传值
 $(document).ready(function(){	    		
	var ss1 = $("#ss1").val();	
	$("#s1 [value='"+ss1+"']").attr("selected","selected");	    		
 })
 $(document).ready(function(){	    		
	var ss2 = $("#ss2").val();	
	$("#s2 [value='"+ss2+"']").attr("selected","selected");	    		
 })
 $(document).ready(function(){	    		
	var ss3 = $("#ss3").val();	
	$("#s3 [value='"+ss3+"']").attr("selected","selected");	    		
 })
  $(document).ready(function(){	    		
	var ss4= $("#ss4").val();	
	$("#s4 [value='"+ss4+"']").attr("selected","selected");	    		
 })
//显，隐
$(document).ready(function() {
	$("#s1").change(function(){
		var os1_value = $("#s1").val();
		if(os1_value!=="all_day"){
			$("#dayday").show(300);
		}else{
			$("#dayday").hide(300);
		}	
	})
    $("#s2").change(function(){
		var os2_value = $("#s2").val();
		if(os2_value!=="no_keywords"){
			$("#s3").show(300);
		}else{
			$("#s3").hide(300);
		}	
	})
        var vs1=$("#s1").val();
	var vs2=$("#s2").val();
	if(vs1!=="all_day"){
		$("#dayday").show();
	}
	if(vs2!=="no_keywords"){
		$("#s3").show();
	}
});

//标记
$(document).ready(function(){
		$("#sbtn").click(function(){
			$(".onbge td div").textSearch($("#sss").val());					  
		})
})
//移动黄色背景
$(document).ready(function() {
	$(".onbge").hover(function() {
		$(this).addClass("onbg");
	}, function() {
		$(this).removeClass("onbg");
	});
});
//show 标题浮动
$(document).scroll(function(){
	var top = $(document).scrollTop();
	if(top>1){			
		$("#biubiu").css({"top":top+30+"px","background":"red"});
	}else{
		$("#biubiu").css({"top":"30px","background":"yellow"});
	}	
})
//标题完整字段展现
$(document).ready(function(){
	$("table tr td div a").each(function(){			
		$(this).mouseover(function(){
			var a = $(this).html()
			timer = setTimeout(function(){
				$("#shower").fadeIn(0)												
				$("#shower").html(a)	
			},100)										
		})										
	})
		
})		
//点击绿色背景
$(document).ready(function(){
	$(".onbge").each(function(){
		$(this).click(function(){
		var a = $(this).hasClass("light");			   	  	
			if(a){
				$(this).removeClass("light")
			}else{
				$(this).addClass("light");
			}			   	  				   	  	
		})
	})			
})
//message提示
function alert_message(e){
    $("#message_txt").text(e);
    //message
    $("#message_box").animate({width:"600",opacity: "1"},500).delay(3000).animate({width:"300",opacity: "0"},500);
}
function alert_error(e){
    $("#error_txt").text(e);
    //message
    $("#error_box").animate({width:"600",opacity: "1"},500).delay(3000).animate({width:"300",opacity: "0"},500);
}
</script>
{/literal}
</head>

<body>
<div id="header" class="auto" style="top:0%;" >
<div id="shower" class="left">ANALYZA CUSTOMER SERVICE MAINTENANCE LIST</div>
<div class="right" id="nav_right">

<!--message弹框-->
<div id="message_box"><div id="message_logo" class="icon-bell-alt"></div><div id="message_txt"></div><div class="clearfix"></div></div>
<!--/message弹框-->
<!--error弹框-->
<div id="error_box"><div id="error_logo" class=" icon-ban-circle"></div><div id="error_txt"></div><div class="clearfix"></div></div>
<!--/error弹框-->
<form method="post" action="show.php" class="right">
<table>
	<tr>
        <td>
        <input type="hidden" id="ss1" value="{$the_day}"  />
        <select id="s1"  name="the_day">
            <option value ="all_day">所有日</option>
            <option value ="send_day">発送日</option>
            <option value ="start_day">開始日</option>
            <option value ="over_day">終了日</option>
            <option value ="re_date">快递日期</option>
	    </select>
        </td>
        <td>
        <div id="dayday">
        日 期:
        <input name="start_time" style="width:80px;" type="text" onclick="SelectDate(this,'yyyy-MM-dd')" value="{$start_time}" readonly/>
        -
        <input name="end_time" style="width:80px;" type="text" onclick="SelectDate(this,'yyyy-MM-dd')" value="{$end_time}" readonly/>
        </div>
        </td>
        <td>
        <input type="hidden" id="ss2" value="{$send_method}"  />
        <select id="s2" style="width:80px;"  name="send_method">
        	<option value="no_keywords">无关键字</option>
            <option value ="email">メルアド</option>
        	<option value ="id">ID</option>
            <option value ="order_id">注文番号</option>
  			<option value ="good_id">オーク..(拍卖ID)</option>
            <option value ="who_id">お客様ID</option>
            <option value ="who_name">ご購入者</option>
            <option value ="receive_phone">收件人电话</option>
            <option value ="receive_code">收件人邮编</option>
            <option value ="receive_house">收件人地址</option>
            <option value ="receive_house1">收件人地址1</option>
            <option value ="receive_house2">收件人地址2</option>
            <option value ="receive_name">收件人名称</option>
            <option value ="send_num">発送番号</option>
            <option value ="goods">商品</option>
            <option value ="store">店舗</option>
            <option value ="is_miss">ミス</option>
            <option value ="is_bad">評価</option>
            <option value ="is_receive">返品</option>
            <option value ="is_money">返金</option>
            <option value="other">备注</option>
		</select>
        </td>
        <td><input style="width:200px;" id="s3" name="key_words" type="text" value="{$key_words}" /></td>
        <td>
        <input type="hidden" id="ss4" value="{$kefu}"  /> 
        <select id="s4"  name="kefu"> 
        	<option value ="team">工号</option>
        	{if $team}
        		{section name=se loop=$team}
  			<option value ="{$team[se].u_num}">{$team[se].u_num} </option> 
  			{/section}
  		{/if}
		</select>
        </td>
        <td><input type="submit" name="search" value="检索"/></td>
        <td><input type="submit" name="down" value="导出"/></td>
        <td><input type="submit" name="zuochuan" value="佐川" /> | </td>
        <td><button style="background:#ffc;"><a href="add_new.php">新增</a></button></td>
    </tr>
</table>
</form>
</div>
</div>
<div class="clear"></div>
<div id="box">
<table id="biao">
	<tr id="biubiu">
    	<td class="bg_a"><span style="width:56px; display:block; overflow:hidden;">ID</span></td>
        <td class="bg_a"><div style="width:44px; overflow:hidden;">操作员</div></td>
        <td class="bg_a"><div style="width:86px; overflow:hidden;">対応開始日</div></td>
    	<td class="bg_a"><div style="width:40px; overflow:hidden;">メルアド</div></td>
    	<td class="bg_a"><div style="width:80px; overflow:hidden;">注文番号</div></td>
        <td class="bg_a"><div style="width:40px;font-size:12px; overflow:hidden;">オークションID</div></td>
        <td class="bg_a"><div style="width:40px; overflow:hidden;">店舗</div></td>
        <td class="bg_a"><div style="width:80px; overflow:hidden;">お客様ID</div></td>
        <td class="bg_a"><div style="width:5px; overflow:hidden;">ご購入者の電話番号</div></td>
        <td class="bg_a"><div style="width:5px; overflow:hidden;">ご購入者のテ</div></td>
        <td class="bg_a"><div style="width:5px; overflow:hidden;">ご購入者の住所</div></td>
        <td class="bg_a"><div style="width:5px; overflow:hidden;">1</div></td>
        <td class="bg_a"><div style="width:5px; overflow:hidden;">2</div></td>
        <td class="bg_a"><div style="width:5px; overflow:hidden;">ご購入者</div></td>
        <td class="bg_a"><div style="width:110px; overflow:hidden;">お届け先電話番号</div></td>
        <td class="bg_a"><div style="width:70px; overflow:hidden;">お届け先のテ</div></td>
        <td class="bg_a"><div style="width:120px; overflow:hidden;">お届け先住所</div></td>
        <td class="bg_a"><div style="width:20px; overflow:hidden;">1</div></td>
        <td class="bg_a"><div style="width:20px; overflow:hidden;">2</div></td>
        <td class="bg_a"><div style="width:70px;font-size:12px; overflow:hidden;">お届け先名称</div></td>
        <td class="bg_a"><div style="width:5px; overflow:hidden;">合計金額</div></td>
        <td class="bg_a"><div style="width:5px; overflow:hidden;">購入送料</div></td>
        <td class="bg_a"><div style="width:5px; overflow:hidden;">購入手数料</div></td>
        <td class="bg_a"><div style="width:5px; overflow:hidden;">購入ポイント</div></td>
        <td class="bg_a"><div style="width:5px; overflow:hidden;">購入クーポン</div></td>
        <td class="bg_a"><div style="width:5px; overflow:hidden;">購入消費税</div></td>
        <td class="bg_a"><div style="width:230px; overflow:hidden;">商品</div></td>
        <td class="bg_a"><div style="width:5px; overflow:hidden;">購入金額</div></td>
        <td class="bg_a"><div style="width:5px; overflow:hidden;">購入方法</div></td>
        <td class="bg_a"><div style="width:5px; overflow:hidden;">発送方法</div></td>
	<td class="bg_a"><div style="width:5px; overflow:hidden;">発送番号</div></td>
        <td class="bg_a"><div style="width:86px; overflow:hidden;">発送日</div></td>
        <td class="bg_a"><div style="width:86px; overflow:hidden;">対応方法</div></td>
        <td class="bg_a"><div style="width:50px; overflow:hidden;">保証品1</div></td>
        <td class="bg_a"><div style="width:50px; overflow:hidden;">保証品2</div></td>
        <td class="bg_a"><div style="width:50px; overflow:hidden;">保証品3</div></td>
        <td class="bg_a"><div style="width:50px; overflow:hidden;">保証品4</div></td>
        <td class="bg_a"><div style="width:50px; overflow:hidden;">保証品5</div></td>
        <td class="bg_a"><div style="width:50px; overflow:hidden;">対応種類</div></td>
        <td class="bg_a"><div style="width:86px; overflow:hidden;">対応終了日</div></td>
        <td class="bg_a"><div style="width:50px; overflow:hidden;">お支払い方法</div></td>
        <td class="bg_a"><div style="width:58px; overflow:hidden;">金額</div></td>
        <td class="bg_a"><div style="width:58px; overflow:hidden;">代引金額</div></td>
        <td class="bg_a"><div style="width:50px; overflow:hidden;">出荷方法</div></td>
        <td class="bg_a"><div style="width:40px; overflow:hidden;">ミス</div></td>
        <td class="bg_a"><div style="width:40px; overflow:hidden;">評価</div></td>
        <td class="bg_a"><div style="width:40px; overflow:hidden;">評価種類</div></td>
        <td class="bg_a"><div style="width:40px; overflow:hidden;">写真</div></td>
        <td class="bg_a"><div style="width:40px; overflow:hidden;">返品</div></td>
        <td class="bg_a"><div style="width:40px; overflow:hidden;">返金</div></td>
        <td class="bg_a"><div style="width:80px; overflow:hidden;">追跡番号</div></td>
        <td class="bg_a"><div style="width:44px; overflow:hidden;">操作员</div></td>
        <td class="bg_a"><div style="width:40px; overflow:hidden;">操作ID</div></td>
        <td class="bg_a"><div style="width:60px; overflow:hidden;">备注</div></td>
    </tr>    

    <!--A组-->
{if $resu1}  
    {section name=se loop=$resu1}
    <tr class="onbge">
    	<td style="color:#CF0; background:#333;font-size:12px;"><span style="width:56px; display:block; overflow:hidden;">{$resu1[se].id}</span></td>
        <td><div style="width:44px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].u_name}</a></div></td>
        <td><div style="width:86px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].start_day}</a></div></td>
    	<td><div style="width:40px; overflow:hidden;"><a href="mailto:{$resu1[se].email}">{$resu1[se].email}</a></div></td>
        <td><div style="width:80px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].order_id}</a></div></td>
        <td><div style="width:40px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].good_id}</a></div></td>
        <td><div style="width:40px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].store}</a></div></td>
        <td><div style="width:80px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].who_id}</a></div></td>
        <td><div style="width:5px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].who_phone}</a></div></td>
        <td><div style="width:5px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].who_code}</a></div></td>
        <td><div style="width:5px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].who_house}</a></div></td>
        <td><div style="width:5px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].who_house1}</a></div></td>
        <td><div style="width:5px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].who_house2}</a></div></td>
        <td><div style="width:5px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].who_name}</a></div></td>
        <td><div style="width:110px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].receive_phone}</a></div></td>
        <td><div style="width:70px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].receive_code}</a></div></td>
        <td><div style="width:120px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].receive_house}</a></div></td>
        <td><div style="width:20px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].receive_house1}</a></div></td>
        <td><div style="width:20px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].receive_house2}</a></div></td>
        <td><div style="width:70px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].receive_name}</a></div></td>
        <td><div style="width:5px; text-align:right; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].total_money}</a></div></td>
        <td><div style="width:5px; text-align:right; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].ems_money}</a></div></td>

        <td><div style="width:5px; text-align:right; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].bill}</a></div></td>
        <td><div style="width:5px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].point}</a></div></td>
        <td><div style="width:5px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].cheap}</a></div></td>
        <td><div style="width:5px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].tax}</a></div></td>
        <td><div style="width:230px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].goods}</a></div></td>
        <td style="text-align:right;"><div style="width:5px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].buy_money}</a></div></td>
        <td><div style="width:5px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].buy_method}</a></div></td>
        <td><div style="width:5px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].to_method}</a></div></td>
        <td><div style="width:5px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].send_num}</a></div></td>
        <td><div style="width:86px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].send_day}</a></div></td>
        <td><div style="width:86px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].method}</a></div></td>
        <td><div style="width:50px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].re_good1}</a></div></td>
        <td><div style="width:50px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].re_good2}</a></div></td>
        <td><div style="width:50px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].re_good3}</a></div></td>
        <td><div style="width:50px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].re_good4}</a></div></td>
        <td><div style="width:50px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].re_good5}</a></div></td>
        <td><div style="width:50px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].add_type}</a></div></td>
        <td><div style="width:86px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].over_day}</a></div></td>
        <td><div style="width:50px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].pay_method}</a></div></td>
        <td><div style="width:58px; text-align:right; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].money}</a></div></td>
        <td><div style="width:58px; text-align:right; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].receive_money}</a></div></td>
        <td><div style="width:50px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].send_method}</a></div></td>
        <td><div style="width:40px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].is_miss}</a></div></td>
        <td><div style="width:40px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].is_bad}</a></div></td>
        <td><div style="width:40px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].say_type}</a></div></td>
        <td><div style="width:40px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].is_photo}</a></div></td>
        <td><div style="width:40px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].is_receive}</a></div></td>
        <td><div style="width:40px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].is_money}</a></div></td>
        <td><div style="width:80px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].ems}</a></div></td>
        <td><div style="width:44px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].u_name}</a></div></td>
        <td><div style="width:40px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$u_num}">{$resu1[se].u_num}</a></div></td>
        <td style="background:#FAFFE8;"><div style="width:60px; overflow:hidden;"><a href="./change_list.php?id={$resu1[se].id}&u_num={$resu1[se].u_num}">{$resu1[se].other}</a></div></td>
    </tr>
    {/section}
 
</table>
{/if}
</div>

<div class="clear"></div>
<div id="footer1">
<div style="width:170px;padding-top:4px; padding-left:20px; text-align:left;" class="left">
Powered by ycmbcd & pd
</div>
<div class="right" style="height:22px; line-height:20px; font-size:14px;padding-right:20px;">
<form method="post" class="left">
<table style="color:#E7E7E7;">
	<tr>
    	<td><span style="color:cf0">共{$count}条</span> , </td>
    	<td>当前 {$now_page} / {$page_rel} 页
    <a href="show.php?now_page={$now_page}&end={$end}&page_method=pre&count={$count}&page_rel={$page_rel}&oSql={$oSql}">上一页</a>
    <a href="show.php?kefyu={$kefu}&key_words={$key_words}&now_page={$now_page}&end={$end}&page_method=next&count={$count}&page_rel={$page_rel}&oSql={$oSql}">下一页</a>
    每页<span id="u_count">{$u_count}</span>条
    </td>
    	<td><input name="page_jump" style="width:20px;" type="text" />页<input name="jump" type="submit" value="Go" /></td>
    	<td>关键字:</td>
    	<td><input id="sss" style="width:100px;" type="text" value="{$key_words}" /></td>
        <td><input id="sbtn" type="button" value="标 记"/></td>
    </tr>
</table>
</form>
&nbsp;| 欢迎您：{$u_name} | 工号：{$u_num} | <a href="/add_list.php">数据添加</a> | <a href="/change_pwd.php">账户管理</a> | <a href="logout.php" >退出</a>
</div>

</div>
</div>
</body>
</html>
