<?php
/*** 
**
	Author : Banish
	Usage : Code to unlink array values 
*
*/
$array1 = ["8"];
$array2 = [array("id" => "11","name" => "9","parent_id" => "8"),array("id" => "11","name" => "9","parent_id" => "9")];
foreach($array1 as $key=>$value){
	foreach($array2 as $key2=>$value2){
		if($value2["parent_id"] != $value){
			unset($array2[$key2]);
		}
	}
}
echo "<pre>";print_r(array_values($array2));

/***
    Author : Banish Chandel
	Usage  : Code to set password validation on Lower,upper and number 
**/

$password = "12Dsdg";
$pattern = ' ^.*(?=.{7,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).*$ ';
if(preg_match('/\A(?=[\x20-\x7E]*?[A-Z])(?=[\x20-\x7E]*?[a-z])(?=[\x20-\x7E]*?[0-9])[\x20-\x7E]{3,}\z/' ,$password)){
	echo  "hello";
}
return "hello2";

?>
