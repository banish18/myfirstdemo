<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);		
class  Setupsite
{
	public function Copylivesite()
	{
		    $remote_file_url = 'http://weh.com/bkp/sitebkp.zip';
			$local_file = 'livesitebkp.zip';
			$copy = copy( $remote_file_url, $local_file );
			if( !$copy ) {
				echo "! failed to copy files ...\n";
			}
			else{
				 echo "! success to copy files ...\n";
			}			
			$remote_file_url = 'http://weh.com/bkp/shop_production.sql';
			$local_file = 'shop_production.sql';
			$copy = copy( $remote_file_url, $local_file );
			if( !$copy ) {
				echo "<br>! failed to copy database...\n";
			}
			else{
				 echo "<br>! success to copy database...\n";
			}
	}
	public function MoveConfigFileRoot()
	{
		$cmd9 = 'mv  app/etc/local.xml local.xml';  
		exec($cmd9,$out9);			
	}
	public function RemoveFolders()
	{
		$cmd10 ='rm -rf downloader lib includes js skin media app';
		echo exec($cmd10,$out10);		
	}
	
	public function UnzipFiles()
	{
		echo "<br> Start uzip the live site files..........";
		$cmd3 = 'unzip livesitebkp.zip -d live';
		exec($cmd3,$out3);				
		echo "<br>end of unzip files";
	}
	public function MoveFolderFiles()
	{		
		$cmd = "mv live/downloader live/includes live/app live/media live/js live/lib live/skin  /home/cloudpanel/htdocs/temp";
		exec($cmd,$out);	
	}
	public function MoveConfigFileEtc()
	{
		$cmd9 = 'mv  local.xml app/etc/local.xml';  
		exec($cmd9,$out9);				
	}
	public function DropDatabaseTables()
	{
		echo "<br> Droping old database";
		$cmd4 = 'mysql -uweh-temp -p6HhAg5Y0YWoz8BLl -Nse "show tables" weh-temp  | while read table; do mysql -uweh-temp -p6HhAg5Y0YWoz8BLl weh-temp -e  "SET FOREIGN_KEY_CHECKS =0; drop table $table; SET FOREIGN_KEY_CHECKS =1;"; done';
		echo exec($cmd4,$out4);				
	}
	public function ImportDb()
	{
		echo "<br>Start Importing livedatabase.....";
		$cmd5 = 'mysql -uweh-temp -p6HhAg5Y0YWoz8BLl weh-temp < shop_production.sql';
		echo exec($cmd5,$out5);		
		echo "<br>Database Imported";
	}
	public function TurncateLogTables()
	{
		echo "<br>Truncate log tables.......";
		$cmd11 = 'mysql -uweh-temp -p6HhAg5Y0YWoz8BLl weh-temp -e "truncate table log_customer"';
		echo exec($cmd11,$out11);		
		$cmd12 = 'mysql -uweh-temp -p6HhAg5Y0YWoz8BLl weh-temp -e "truncate table log_quote"';
		echo exec($cmd12,$out12);	   
		$cmd13 = 'mysql -uweh-temp -p6HhAg5Y0YWoz8BLl weh-temp -e "truncate table log_summary"';
		echo exec($cmd13,$out13);	   
		$cmd14= 'mysql -uweh-temp -p6HhAg5Y0YWoz8BLl weh-temp -e "truncate table log_summary_type"';
		echo exec($cmd14,$out14);	   
		$cmd15 = 'mysql -uweh-temp -p6HhAg5Y0YWoz8BLl weh-temp -e "truncate table log_url";';
		echo exec($cmd15,$out15);	   
		$cmd16 = 'mysql -uweh-temp -p6HhAg5Y0YWoz8BLl weh-temp -e "truncate table log_url_info"';
		echo exec($cmd16,$out16);	   
		$cmd17 = 'mysql -uweh-temp -p6HhAg5Y0YWoz8BLl weh-temp -e "truncate table log_visitor"';
		echo exec($cmd17,$out17);	   
		$cmd18 = 'mysql -uweh-temp -p6HhAg5Y0YWoz8BLl weh-temp -e "truncate table log_visitor_info"';
		echo exec($cmd18,$out18);	   
		$cmd19 = 'mysql -uweh-temp -p6HhAg5Y0YWoz8BLl weh-temp -e "truncate table log_visitor_online"';
		echo exec($cmd19,$out19);
		echo "<br> End of truncate log tables";
				   
	}
	public function UpdateSiteUrl()
	{
		echo "<br> Updateing site Url";
		$cmd6 = 'mysql -uweh-temp -p6HhAg5Y0YWoz8BLl weh-temp -e "UPDATE core_config_data SET value=\"http://temp.weh.com/\" WHERE path=\"web/unsecure/base_url\" AND scope_id=0";';
		echo exec($cmd6,$out6);		
		$cmd7 = 'mysql -uweh-temp -p6HhAg5Y0YWoz8BLl weh-temp -e "UPDATE core_config_data SET value=\"http://temp.weh.com/\" WHERE path=\"web/secure/base_url\" AND scope_id=0";';
		echo exec($cmd7,$out7);		
	}
	public function RemoveZipFiles()
	{
		echo "<br> Remove live zip files";
		$cmd10 ='rm -rf livesitebkp.zip shop_production.sql';
		echo exec($cmd10,$out10);
	}
	
}
$obj = new  Setupsite;
//$obj->Copylivesite();
//$obj->MoveConfigFileRoot();
///$obj->RemoveFolders();
//$obj->UnzipFiles();
$obj->MoveFolderFiles();
$obj->MoveConfigFileEtc();
$obj->DropDatabaseTables();
$obj->ImportDb();
$obj->TurncateLogTables();
$obj->UpdateSiteUrl();
$obj->RemoveZipFiles();

?>

			
			
