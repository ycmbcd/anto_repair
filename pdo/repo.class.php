<?php
//header('content-type:text/html;charset=utf-8');
define("REPO_DB_HOST",'localhost');
define("REPO_DB_USER",'root');
define("REPO_DB_PWD",'ycmbcd');
define("REPO_DB_NAME",'anto_repo');

define("REPO_DB_PORT",'3306');
define("REPO_DB_TYPE",'mysql');
define("REPO_DB_CHARSET",'utf8');
define("REPO_WEB_NAME",'ANTO-OMS');
final class RepoPdoMySQL{
	public static $config=array();	//设置连接参数，配置参数
	public static $link=null;	//保存连接标识符
	public static $pconnect=false;	//是否开启长连接
	public static $dbVersion=null;	//保存数据库版本
	public static $connected=false;	//判断是否连接成功
	public static $PDOStatement=null;	//保存PDOStatement对象
	public static $queryStr=null;	//保存最后执行的操作
	public static $error=null;	//保存错误信息
	// public static $lastInsertId=0;	//保存上一步插入操作的id号
	public static $numRows=0;	//上一步操作产生受影响的记录的条数

	public function __construct($dbConfig=''){
		if(!class_exists("PDO")){
			self::throw_exception('服务器不支持PDO，请先开启。');
			return false;
		}
		if(!is_array($dbConfig)){
			$dbConfig=array(
				'hostname'=>REPO_DB_HOST,
				'username'=>REPO_DB_USER,
				'password'=>REPO_DB_PWD,
				'database'=>REPO_DB_NAME,
				'hostport'=>REPO_DB_PORT,
				'webName'=>REPO_WEB_NAME,
				'dbms'=>REPO_DB_TYPE,
				'dsn'=>REPO_DB_TYPE.":host=".REPO_DB_HOST.";dbname=".REPO_DB_NAME
			);
		}
		if(empty($dbConfig['hostname'])){
			self::throw_exception('没有定义数据库配置。');
			return false;
		};
		self::$config=$dbConfig;
		if(empty(self::$config['params']))self::$config['params']=array();
		if(!isset(self::$link)){
			$configs=self::$config;
			if(self::$pconnect){
				//开启长连接，添加配置数组中
				$configs['params'][constant("PDO::ATTR_PERSISTENT")]=true;
			}
			try{
				self::$link=new PDO($configs['dsn'],$configs['username'],$configs['password'],$configs['params']);
			}catch(PDOException $e){
				self::throw_exception($e->getMessage());
				return false;
			}
			if(!self::$link){
				self::throw_exception('PDO连接错误');
				return false;
			}
			self::$link->exec('SET NAMES '.REPO_DB_CHARSET);
			self::$dbVersion=self::$link->getAttribute(constant("PDO::ATTR_SERVER_VERSION"));
			self::$connected=true;
			unset($configs);
		}
	}

	//得到所有记录
	public static function getAll($sql=null){
		if($sql!==null){
			self::query($sql);
		}
		$result=self::$PDOStatement->fetchAll(constant("PDO::FETCH_ASSOC"));
		return $result;
	}

	//得到一条记录
	public static function getOne($sql=null){
		if($sql!==null){
			self::query($sql);
		}
		$result=self::$PDOStatement->fetch(constant("PDO::FETCH_ASSOC"));
		return $result;
	}

	//执行增删改，返回受影响的记录的条数
	public static function execute($sql=null){
		$link=self::$link;
		if(!$link) return false;
		self::$queryStr=$sql;
		if(!empty(self::$PDOStatement))self::free();
		$result=$link->exec(self::$queryStr);
		self::haveErrorThrowException();
		if($result){
			// self::$lastInsertId=$link->lastInsertId();
			self::$numRows=$result;
			return self::$numRows;
		}else{
			return false;
		}
	}

	//返回最后一条sql语句
	public static function getLastSql(){
		$link=self::$link;
		if(!$link)return false;
		return self::$queryStr;
	}

	//释放结果集
	public static function free(){
		self::$PDOStatement=null;
	}

	public static function query($sql=''){
		$link=self::$link;
		if(!$link) return false;
		//判断之前是否有结果集，如果有的话，释放结果集
		if(!empty(self::$PDOStatement))self::free();
		self::$queryStr=$sql;
		self::$PDOStatement=$link->prepare(self::$queryStr);
		$res=self::$PDOStatement->execute();
		self::haveErrorThrowException();
		return $res;
	}

	public static function haveErrorThrowException(){
		$obj=empty(self::$PDOStatement)?self::$link: self::$PDOStatement;
		$arrError=$obj->errorInfo();
		//print_r($arrError);
		if($arrError[0]!=='00000'){
			self::$error='【SQL错误】'.$arrError[0].' > '.self::$queryStr.'【反馈】'.$arrError[2];
			self::throw_exception(self::$error);
			return false;
		}
		if(self::$queryStr==''){
			self::throw_exception('没有执行SQL语句');
			return false;
		}
	}

	//自定义错误处理
	public static function throw_exception($errorMsg){
		echo $errorMsg.'【站点】'.REPO_WEB_NAME;
	}

	//销毁连接对象，关闭数据库
	public static function close(){
		self::$link=null;
	}
}
