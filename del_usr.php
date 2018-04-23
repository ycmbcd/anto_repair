<?php
require_once "tpl.class.php";
require_once "db.php";
$db=new DB();
if(isset($_GET['del'])){
    $del_usr = $_GET['del'];
    $sql = "DELETE FROM user WHERE u_num = '{$del_usr}'";
    $res = $db->execute($sql);
    echo $del_usr.'已删除。点击 <a href="/add_user.php" style="color:blue;">返回</a>';
}
