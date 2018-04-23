<?php
require_once "./libs/Smarty.class.php";
$smarty=new Smarty();
//配置模版目录和配置编译目录是必须写的，其他的可以不设置
$smarty->template_dir="./templates";
$smarty->compile_dir="./templates_c";
$smarty->comfig_dir="./configs";
$smarty->caching=false;	//缓存
$smarty->cache_dir="./cache";	//设置缓存目录
$smarty->cache_lifetime=0;	//设置缓存时间0秒
?>
