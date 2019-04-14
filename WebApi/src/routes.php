<?php


header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Credentials: true');
header('Access-Control-Allow-Methods: GET, PUT, POST, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: X-Requested-With, Content-Type, Accept, Origin, Authorization');
header("Access-Control-Allow-Headers: Content-Type, application/json; charset=UTF-8");

use Slim\Http\Request;
use Slim\Http\Response;

// Routes

$app->get('/[{name}]', function (Request $request, Response $response, array $args) {
    // Sample log message
    $this->logger->info("Slim-Skeleton '/' route");

    // Render index view
    return $this->renderer->render($response, 'index.phtml', $args);
});

// get license
$app->post('/api/GetLicense', function ($request, $response, $args) {
    $input = $request->getParsedBody();
    $apiKey = $input['AppToken'];

    if($apiKey == '9738bbd44fc469aa3f61922a5576c31e'){
        $json['status']='success';
		$json['reason']='';
    }
    else{
        $json['status']='fail';
		$json['reason']='No License Found';
    }

    return $this->response->withJson($json);
});

// get all todos
$app->post('/api/GetAllItems', function ($request, $response, $args) {
    //$input = $request->getParsedBody();
    //echo $input['Name'];
    $sth = $this->db->prepare("SELECT * FROM items");
   $sth->execute();
   $todos['status'] = 'success';
   $response = $sth->fetchAll();

   $todos['data']=array();

   $length = count($response);				
    for($row =0; $row < $length; $row ++){
        $tmp=array();
        $tmp['id']=strip_tags($row);
        $tmp['itemName']=strip_tags($response[$row]['itemName']);
        $tmp['itemDescription']=strip_tags($response[$row]['itemDescription']);
        $tmp['itemType']=strip_tags($response[$row]['itemType']);
        $tmp['itemQty']=0;
        $tmp['itemPrice']=floatval($response[$row]['itemPrice']);
        array_push($todos['data'], $tmp);
    }

   return $this->response->withJson($todos);
});

// register user
$app->post('/api/Register', function ($request, $response, $args) {
    
    $input = $request->getParsedBody();
    $name = $input['Name'];
    $gender = $input['Gender'];
    $email = $input['Email'];
    $mobile = $input['Mobile'];
    $password = md5($input['Password']);
    $address = json_encode($input['Address']);
    $isOTPsend = false;

    $resp['status'] = 'success';
    $OTPName = '';
    $OTPNumber = '';

    // check whether mobile and email already present or not
    $validate = $this->db->prepare("select * from userRegistrations where Mobile=?");
    $validate->execute([$mobile]);
    $respUser = $validate->fetchAll();
    
    $randomNumber = GenerateOTP(); // generate random number
    
    if(count($respUser) > 0){
        
        // Check whether Number is validated or not.
        if($respUser[0]['isVerified'] == 0){
            $resp['status'] = 'success';
            $resp['reason'] = 'OTPWINDOW';
            $resp['OTP'] = $randomNumber;
            
            $isOTPsend = true;
            $OTPName = $respUser[0]['Name'];
            $OTPNumber = $respUser[0]['Mobile'];
            
            $resp['OTPNumber'] = $OTPNumber;
        }
        else{
            $resp['status'] = 'fail';
            $resp['reason'] = 'Mobile number already registered';
        }
    }
    else{
        $sql = "insert into userRegistrations (Name,Gender,Email,Mobile,Password,Address) VALUES (?,?,?,?,?,?)";
        $dbInsert = $this->db->prepare($sql);
        
        if($dbInsert->execute([$name,$gender,$email,$mobile,$password,$address])){
            $resp['status'] = 'success';
            $resp['reason'] = 'OTPWINDOW'; //'Registration Successfull';
            $resp['OTP'] = $randomNumber;
            
            $isOTPsend = true;
            $OTPName = $name;
            $OTPNumber = $mobile;
            
            $resp['OTPNumber'] = $OTPNumber;
        }
        else
        {
            $resp['status'] = 'fail';
            $resp['reason'] = 'Registration Failed.';
        }
    }
    
    if($isOTPsend){
        // Send OTP via SMS
        $user['number'] = $OTPNumber;
        $user['name'] = $OTPName;
        $user['OTP'] = $randomNumber;
        $resp['apiResponse'] = SendSMSToUser($user);
        // SMS send End
    }
   
   return $this->response->withJson($resp);
});

// register user
$app->post('/api/Login', function ($request, $response, $args) {
    
    $input = $request->getParsedBody();
    $mobile = $input['Mobile'];
    $gender = $input['Gender'];
    $password = md5($input['Password']);
    
    $resp['status'] = 'success';
   

    // check whether user already present or not
    $validate = $this->db->prepare("select * from userRegistrations where Mobile=? AND Password=? AND Gender=?");
    $validate->execute([$mobile, $password, $gender]);
    $user = $validate->fetchAll();  
    
    if(count($user) > 0){
        $resp = getUserDetails($user);        
    }
    else{
        $resp['status'] = 'fail';
        $resp['reason'] = 'Invalid User or Password';
    }   
   
   return $this->response->withJson($resp);
});

// Generate OTP
$app->post('/api/GenerateOTP', function ($request, $response, $args) {
    
    $input = $request->getParsedBody();
    $OTPNumber = $input['Number'];
    $OTPName = $input['Name'];   
    
    $randomNumber = GenerateOTP(); // generate random number 
    // response will be sent back to user on mobile
    $resp['status'] = 'success';
    $resp['reason'] = 'OTPWINDOW';
    $resp['OTP'] = $randomNumber;
    $resp['Mobile'] = $OTPNumber;
    
    // Send OTP via SMS
    $user['number'] = $OTPNumber;
    $user['name'] = $OTPName;
    $user['OTP'] = $randomNumber;
    $resp['apiResponse'] = SendSMSToUser($user);
    // SMS send End       
   
   return $this->response->withJson($resp);
});

// Validate OTP
$app->post('/api/ValidateOTP', function ($request, $response, $args) {
    
    $input = $request->getParsedBody();
    $number = str_replace(' ', '', $input['number']);
    $status = 1;
    
    $sqlUpdate = "UPDATE userRegistrations SET isVerified =? WHERE Mobile=?";
    $dbUpdate = $this->db->prepare($sqlUpdate);
    
    if($dbUpdate->execute([$status, $number])){
        $resp['status'] = 'success';
        $resp['reason'] = 'OTP verified successfully'; //'Registration Successfull';
    }
    else
    {
        $resp['status'] = 'fail';
        $resp['reason'] = 'OTP verification failed';
    }
   
   return $this->response->withJson($resp);
});

// PlaceOrder
$app->post('/api/PlaceOrder', function ($request, $response, $args) {

    date_default_timezone_set("Asia/Calcutta");
    $serverDateTime = date('Y-m-d H:i:s');
    
    $input = $request->getParsedBody();
    $orderDetails['Items'] = $input['orderDetails'];       
    $orderDetails['finalAmount'] = $input['finalAmount'];
    $orderDetails['clientId'] = $input['clientId'];
    
    $resp['status'] = 'success';    
    
    $sql = "insert into orders (clientId,orderItems, date) VALUES (?,?,?)";
    $dbInsert = $this->db->prepare($sql);
    
    if($dbInsert->execute([$input['clientId'], json_encode($orderDetails), $serverDateTime])){
        $id = $this->db->lastInsertId();
        $resp['status'] = 'success';
        $resp['reason'] = 'Order Placed Successfully. Your Order Id is : '.$id;
        $resp['id'] = $id;     
    }
    else
    {
        $resp['status'] = 'fail';
        $resp['reason'] = 'Failed to place an Order';
    }   
   
   return $this->response->withJson($resp);
});

// Get all Orders
$app->post('/api/GetOrders', function ($request, $response, $args) {

    date_default_timezone_set("Asia/Calcutta");
    $serverDateTime = date('Y-m-d H:i:s');
    
    $input = $request->getParsedBody();
    $clientId = $input['clientId'];
    
    $resp['status'] = 'success';    
    
    $sql = "SELECT * from orders WHERE clientId=? order by id desc";
    $dbSelect = $this->db->prepare($sql);
    $dbSelect->execute([$clientId]);
    $orders = $dbSelect->fetchAll();  
    $count = count($orders);

    $resp['orders']=array();
    
    if($count > 0){

        for($i = 0; $i < $count; $i++){
            $tmp=array();
            $tmp['collection']= json_decode($orders[$i]['orderItems']);
            $tmp['date']=$orders[$i]['date'];
            $tmp['id']=$orders[$i]['id'];
            
            array_push($resp['orders'], $tmp);
        }        
        $resp['reason'] = '';             
    }
    else{
        $resp['status'] = 'fail';
        $resp['reason'] = 'No Orders Found. Seems you have not ordered anything yet';
    }   
   
   return $this->response->withJson($resp);
});

// Get all Orders
$app->post('/api/UpdateDetails', function ($request, $response, $args) {
        
    $input = $request->getParsedBody();
    $clientId = $input['clientId'];    
    $updateId = $input['updateId'];

    if($updateId == 'address'){
        $address = json_encode($input['address']);
        // address update case
        $sql = "UPDATE userRegistrations SET Address=? WHERE id=?";
        $dbUpdate = $this->db->prepare($sql);
        if($dbUpdate->execute([$address, $clientId])){
            // update success. Now get new details
            // check whether user already present or not
            $userSelect = $this->db->prepare("select * from userRegistrations where id=?");
            $userSelect->execute([$clientId]);
            $user = $userSelect->fetchAll();
            
            if(count($user) > 0){
                $resp = getUserDetails($user);
                $resp['reason'] = 'Address Updated Successfully';
            }
            else{
                $resp['status'] = 'fail';
                $resp['reason'] = 'Failed to update Address';
            }  
        }
    }
    else if($updateId == 'password'){
        $pwd = md5($input['pwd']);
        // password update case
        $sql = "UPDATE userRegistrations SET Password=? WHERE id=?";
        $dbUpdate = $this->db->prepare($sql);
        if($dbUpdate->execute([$pwd, $clientId])){
            // update success 
            $resp['status'] = 'success';
            $resp['reason'] = 'Password Updated Successfully';             
        }
        else{
            $resp['status'] = 'fail';
            $resp['reason'] = 'Failed to update password'; 
        }
    } 
    
   
   return $this->response->withJson($resp);
});

// Catch-all route to serve a 404 Not Found page if none of the routes match
// NOTE: make sure this route is defined last
$app->map(['GET', 'POST', 'PUT', 'DELETE', 'PATCH'], '/{routes:.+}', function($req, $res) {
    $handler = $this->notFoundHandler; // handle using the default Slim page not found handler
    return $handler($req, $res);
});

function getUserDetails($user){
    
    $resp['status'] = 'success';
    $resp['reason'] = 'Login Successfull';
    $resp['userObj']['Id'] = $user[0]['id'];
    $resp['userObj']['Name'] = $user[0]['Name'];
    $resp['userObj']['Gender'] = $user[0]['Gender'];
    $resp['userObj']['Email'] = $user[0]['Email'];
    $resp['userObj']['Mobile'] = $user[0]['Mobile'];
    $resp['userObj']['Address'] = json_decode($user[0]['Address']);
    $resp['userObj']['isVerified'] = $user[0]['isVerified'];
    
    return $resp;
}


function SendSMSToUser($user){

    $numbers = $user['number']; // A single number or a comma-seperated list of numbers
    $message = 'Dear '.$user['name'].', Your OTP is : '.$user['OTP'];
    $authKey = "184076AssX3ib4Fw2l5a0deecb";
    
    $curl = curl_init();
    curl_setopt_array($curl, array(
    CURLOPT_URL => "http://api.msg91.com/api/sendhttp.php?country=91&sender=MSGIND&route=4&mobiles=".$numbers."&authkey=".$authKey."&message=".$message,
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_ENCODING => "",
    CURLOPT_MAXREDIRS => 10,
    CURLOPT_TIMEOUT => 30,
    CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
    CURLOPT_CUSTOMREQUEST => "GET",
    CURLOPT_SSL_VERIFYHOST => 0,
    CURLOPT_SSL_VERIFYPEER => 0,
    ));

    $result = curl_exec($curl);
    $err = curl_error($curl);

    curl_close($curl);

    if ($err) {
    //echo "cURL Error #:" . $err;
    } else {
    //return $result;
    }
}

function SendSMSToUserTextLocal($user){
    // Authorisation details.
    $username = "aki.ghanekar@gmail.com";
    $hash = "9c5215761c56c3d68266f6c5eebcfe52aad8d3b648c3a7000daacf8abe10e10c";
    // Config variables. Consult http://api.textlocal.in/docs for more info.
    $test = "0";
    // Data for text message. This is the text message data.
	$sender = "TXTLCL"; // This is who the message appears to be from.
	$numbers = $user['number']; // A single number or a comma-seperated list of numbers
	$message = 'Dear '.$user['name'].', Your OTP is : '.$user['OTP'];
	// 612 chars or less
	// A single number or a comma-seperated list of numbers
	$message = urlencode($message);
	$data = "username=".$username."&hash=".$hash."&message=".$message."&sender=".$sender."&numbers=".$numbers."&test=".$test;
	$ch = curl_init('http://api.textlocal.in/send/?');
	curl_setopt($ch, CURLOPT_POST, true);
	curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
	$result = curl_exec($ch); // This is the result from the API
	curl_close($ch);
	
	return $result;
}

function GenerateOTP(){
    return substr(mt_rand(), 0, 4);
}