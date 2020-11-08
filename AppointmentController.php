<?php
namespace App\Http\Controllers\Api;

use Illuminate\Support\Facades\Response;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Hash;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use App\AppointmentList;
use App\AppointmentRequest;
use App\CartItem;
use App\ProcedureReview;
use App\Procedure;
use App\DoctorTimeslot;
use App\Doctors;
use App\NoteCommentData;
use App\MobileNotification;
use App\OperationList;
use App\Product;
use App\Service;
use App\SubService;
use App\HairTransplantReport;
use App\User;
use App\ReferralData;
use App\ReferralPoint;
use App\DoctorAssistant;
use App\ReferralPointsData;
use Auth;
use Illuminate\Support\Facades\Input;
use Illuminate\Support\Facades\Mail;
use File;
use Config;
use DB;
use Image;
use Validator;
use App\SmsApi;
use App\AssistantProcedureRecords;
use App\Mail\SendOtpMail;
use DateTime;
use DateInterval;
use LaravelFCM\Message\Topics;
use LaravelFCM\Message\OptionsBuilder;
use LaravelFCM\Message\PayloadDataBuilder;
use LaravelFCM\Message\PayloadNotificationBuilder;
use FCM;
use App\Mail\AppointmentCancelMail;
use App\Mail\AppointmentRescheduleMail;

class AppointmentController extends Controller
{
    /**
     * Create a new controller instance.
     * @return void
    */
    
	public $successStatus = 200;
	public $errorStatus = 401;
	
	public function __Construct(REQUEST $request){
		$this->flag = 1;
		$this->languages = Config::get('app.languages');
		if(!in_array($request->lang,$this->languages)){
			$this->flag = 0;
		}
	}
	
	/*
	 * get time slots
	 * @return timeSlots
	 * */
	 
	public function getTimeslots(Request $request){
		$user_id 	= $request->user_id;
		$date 	 	= $request->date;
		
		$DoctorTimeslots = DoctorTimeslot::all()->toArray();
		$timeArr = [];
		if($DoctorTimeslots){
			foreach($DoctorTimeslots as $DoctorTimeslot){
				$startTime 	= explode(" ",$DoctorTimeslot['start_time']);
				$endTime 	= explode(" ",$DoctorTimeslot['end_time']);
				$timeArr[] = array('time' => $DoctorTimeslot['start_time'].' to '.$DoctorTimeslot['end_time'],'from_time' => $startTime[0],'to_tome' => $endTime[0]);
			}
		}
		if(!empty($timeArr)){
			return response()->json(['status'=>true, 'data' => $timeArr], $this->successStatus); 	
		}else{
			return response()->json(['status'=>false, 'data' => 'No Data Available'], $this->successStatus);
		}
	}
	
	/*
	 * save appointment details
	 * @return dataArray
	 * */
	 
	public function saveAppointmentdetail(Request $request){
		$appointmentDatetime 	= $request->datetime;
		$latitude 				= $request->latitude;
		$longitude 				= $request->longitude;
		$service_id 			= $request->service_id;
		$user_id 				= $request->user_id;
		$timeSlot               = date('H:i a',strtotime($appointmentDatetime));
		/* Check if same user id,service_id and status=0 are exists or not */
		$AppointmentList = AppointmentList::where('user_id',$user_id)->where('service_id',$service_id)->where('status','0')->first();
		if($AppointmentList){
			return response()->json(['status'=>true, 'message' => 'Your request has been under doctor confirmation. We will update you soon!','appointment_id' => $AppointmentList->id], $this->successStatus);
		}
		/* Get clinic details which comes under 5 km of user's current location */
		$clinicDetails        	= Doctors::select(DB::raw('id,user_id,clinic_name,clinic_address,clinic_name,clinic_name,clinic_name, ( 6367 * acos( cos( radians('.$latitude.') ) * cos( radians( latitude ) ) * cos( radians( longitude ) - radians('.$longitude.') ) + sin( radians('.$latitude.') ) * sin( radians( latitude ) ) ) ) AS distance'))
			->having('distance', '<', 50)
			->orderBy('distance')
			->with('user')
			->where('skills', 'like', '%1%')->get()->toArray();
		if(!empty($clinicDetails)){
			$todateTime = date('Y-m-d',strtotime($appointmentDatetime)).' '.$request->to_time;
			$AppointmentList = new AppointmentList;
			$AppointmentList->user_id 			= $request->user_id;
			$AppointmentList->doctor_id 		= '0';
			$AppointmentList->service_id 		= $service_id;
			$AppointmentList->appointment_date 	= $appointmentDatetime;
			$AppointmentList->appointment_to_date 	= $todateTime;
			$AppointmentList->save();
			foreach($clinicDetails as $clinicDetail){
				$AppointmentRequest 				= new AppointmentRequest;
				$AppointmentRequest->appointment_id = $AppointmentList->id;
				$AppointmentRequest->doctor_id 		= $clinicDetail['id'];
				$AppointmentRequest->service_id 	= $service_id;
				$AppointmentRequest->request_date 	= $appointmentDatetime;
				$AppointmentRequest->request_time 	= $timeSlot;
				$AppointmentRequest->save();
				$service = new Doctors;
				$serviceA = $service->service($service_id);
				$serviceName = 'N/A';
				if(!empty($serviceA)){
					$serviceName = $serviceA->service_name;
				}
				/* appointment request email to all doctors whoese under distance */
				//$email = $clinicDetail['user']['email'];
				$email = "dottechnologies123@gmail.com";
				$name  = $clinicDetail['user']['name'];
				$link  = url('/').'/api/user/confirm-request/'.$AppointmentRequest->id;
				$data = array(
						'name'		=> $name,
						'service' 	=> $serviceName,
						'date' 		=> date('d-M-Y',strtotime($appointmentDatetime)),
						'time' 		=> $timeSlot,
						'link' 		=> $link);
				
				Mail::send('requestMail', $data, function($message) {
					$message->to('dottechnologies123@gmail.com', 'KABE')->subject
					('Customer Appointment Request');
					$message->from('dottechnologies@gmail.com','Kabera');
				});
			}
			/*$otherDetail = array(
								'appointment_date' => $appointmentDatetime,
								'day_name'         => 'Monday', 
								'timeslot'         => $timeSlot, 
								'required_grafts'  => $required_grafts,
								'grafts_in_cart'   => $grafts_in_cart,
								'cost_per_graft'   => $cost_per_graft,
								'total_cost'       => $total_cost,
								'balance'          => $grandTotal
							);*/
			return response()->json(['status'=>true, 'appointment_id' => $AppointmentList->id,'message' => 'Your request has been submitted. We will update you soon!'], $this->successStatus); 					
		}else{
			return response()->json(['status'=>false, 'message' => 'No doctors are found on this location.'], $this->successStatus);
		}
	}
	
	/*
	 * get appointment details
	 * @return dataArray
	 * */
	 
	public function confirmRequest($id){
		$AppointmentRequest = AppointmentRequest::where('id',$id)->where('status',0)->first();
		if($AppointmentRequest){
			$AppointmentRequest->status = 1;
			$AppointmentRequest->save();
			$AppointmentList = AppointmentList::find($AppointmentRequest->appointment_id);
			if($AppointmentList){
				$AppointmentList->doctor_id = $AppointmentRequest->doctor_id;
				$AppointmentList->status 	= '1';
				$AppointmentList->save();
				$procedure = Procedure::where('id',$AppointmentList->procedure_id)->first();
				if($procedure){
					$procedure->doctor_id = $AppointmentList->doctor_id;
					$procedure->track_status = 'visit_doc';
					$procedure->save();
				}
			}
			return response()->json(['status'=>true, 'message' => 'Request has been successfully confirmed.'], $this->successStatus);
		}else{
			return response()->json(['status'=>false, 'message' => 'Request has been already confirmed by others.'], $this->successStatus);
		}
	}
	
	/*
	 * get appointment details
	 * @return dataArray
	 * */
	 
	public function getAppointmentdetail(Request $request){
		$AppointmentList = AppointmentList::where('id',$request->appointment_id)->where('status','1')->first();
		if($AppointmentList){
			$clinic = Doctors::where('id',$AppointmentList->doctor_id)->first(['id','user_id','clinic_name','clinic_address','clinic_name','clinic_name']);
			if($clinic){
				$new_time = date("H A", strtotime('+2 hours', strtotime($AppointmentList->appointment_date)));
				$required_grafts 	= '';
				$grafts_in_cart 	= '';
				$required_grafts 	= '';
				$cost_per_graft 	= '';
				$total_cost 		= '';
				$grandTotal 		= '';
				$otherDetail = array(
								'appointment_date' => $AppointmentList->appointment_date,
								'day_name'         => date('D',strtotime($AppointmentList->appointment_date)), 
								'timeslot'         => date('h A',strtotime($AppointmentList->appointment_date)) .' To '.$new_time, 
								'required_grafts'  => $required_grafts,
								'grafts_in_cart'   => $grafts_in_cart,
								'cost_per_graft'   => $cost_per_graft,
								'total_cost'       => $total_cost,
								'balance'          => $grandTotal
							);
				$dataArray = array('clinic_detail' => $clinic,'other_detail' => $otherDetail);	
				return response()->json(['status'=>true, 'data' => $dataArray,'message' => 'Appointment Data']);		
			}else{
				return response()->json(['status'=>false, 'data' => [],'message' => 'Something went wrong']); 			
			}
		}else{
			return response()->json(['status'=>false, 'data' => [],'message' => 'Request has been under process for doctor confirmation.']);
		}
	}
	
	
	/* Review Upload*/
	
	public function uploadReview(Request $request){
		
		$validator = Validator::make($request->all(), [             
            'user_id'      => 'required',
            'rating'       => 'required',
            'review'       => 'required',
            'image'        => 'required',
            'service_id'   => 'required',
        ]);
        
		if ($validator->fails()) { 						
			foreach($validator->errors()->toArray() as $key=>$er) {
				$err[] = $er[0];
			}
            return response()->json(['error'=>$err], $this->successStatus);            
        }   
        
        $user 	= User::find($request->user_id);
		if($user){
			$name 	= $user->name;
			$email 	= $user->email;
			
			$random_number = mt_rand(100000, 999999);
			$imgname       = 'review-'.time().'.png';
			\File::put(public_path().'/images/reviews/'.$imgname, base64_decode($request->image));
			
			$ProcedureReview = new ProcedureReview;
			$ProcedureReview->service_id 		= $request->service_id;
			$ProcedureReview->user_id 	 		= $request->user_id;
			$ProcedureReview->rating 			= $request->rating;
			$ProcedureReview->review 			= $request->review;
			$ProcedureReview->review_image 		= $imgname;
			$ProcedureReview->reviewer_name 	= $name;
			$ProcedureReview->reviewer_email 	= $email;
			$ProcedureReview->review_status 	= '0';
			$ProcedureReview->save();
			if($ProcedureReview){
				return response()->json(['status'=>true,'message' => 'Thank for your reivew.']);	
			}else{
				return response()->json(['status'=>false,'message' => 'Something went wrong.']);	
			}
		} else {			
			return response()->json(['status'=>false,'message' => 'Sorry! User Not Exist on Our Database.']);	
		}
	}
	
	/**
	 *Function Name:appointmentDetail
	 *Function Arguments: One Argument
	 *Function Purpose: To get appointment details and appoinment history between Patient and Doctor
	 *Function Return: Appointment details and appoinment history between Patient and Doctor
	 **/
	public function appointmentDetail(Request $request){
		$validator = Validator::make($request->all(), [ 
														'doctor_id'	  => 'required', 
														'patient_id'	  => 'required', 
														'appointment_id'	  => 'required', 
													]
									);
		if ($validator->fails()) { 						
			foreach($validator->errors()->toArray() as $key=>$er) {
				$err[] = $er[0];
			}
            return response()->json(['status'=>false,'message'=>$err], $this->errorStatus);            
        }
		$getProcedureDetails= [];
		
		$appointmentDetails= [];
		
		$doctor_id = $request->input('doctor_id');
		
		if($request->assistant_id != "0"){
			$checkAppointmentDetailsExist = AppointmentList::where('id',$request->input('appointment_id'))->where('user_id',$request->input('patient_id'))->where('assistant_ids',$request->input('assistant_id'))->where('status','1')->orderBy('id','desc')->get()->first();
		}else{
			$checkAppointmentDetailsExist = AppointmentList::where('id',$request->input('appointment_id'))->where('user_id',$request->input('patient_id'))->where('doctor_id',$request->input('doctor_id'))->where('status','1')->orderBy('id','desc')->get()->first();
		}
		
		if ($checkAppointmentDetailsExist) {
			$getAppointmentDetails = $checkAppointmentDetailsExist->toArray();
		}else{
			return response()->json(['status'=>false,'message'=>"No Appointment Available"], $this->errorStatus); 
		}
		
		$appointmentDetails['appointment_no']='';
		$appointmentDetails['appointment_date']='';
		$appointmentDetails['appointment_time']='';
		$appointmentDetails['notes']='';
		if(!empty($getAppointmentDetails)){
			foreach($getAppointmentDetails as $key => $val){
				if($key=="id"){ 
					if(!empty($getAppointmentDetails[$key])){ 
						$appointmentDetails['appointment_no']=$getAppointmentDetails[$key];
					}
				}
				if($key=="appointment_date"){
					if(!empty($getAppointmentDetails[$key])){
						$appointmentDetails[$key]=date('Y-m-d',strtotime($getAppointmentDetails[$key]));
						$appointmentDetails['appointment_time']=date('H:i:s',strtotime($getAppointmentDetails[$key]));
						$appointmentDetails['appointment_from_time'] = date('h A',strtotime($getAppointmentDetails[$key]));
					}
					
				}
				if($key=="appointment_to_date"){
					if(!empty($getAppointmentDetails[$key])){
						$appointmentDetails[$key]=date('Y-m-d',strtotime($getAppointmentDetails[$key]));
						$appointmentDetails['appointment_to_time']  =  date('h A',strtotime($getAppointmentDetails[$key]));
					}
					
				}
				if($key=='note'){
					if(!empty($getAppointmentDetails[$key])){
						$appointmentDetails['notes']=$getAppointmentDetails[$key];						
					}
				}
			}			
		}
		$predate 	   = date('Y-m-d h:i:d');
		$appointmentHistory= [];
		$checkAppointmentHistoryExist = AppointmentList::with('serviceDetail')->where('user_id',$request->input('patient_id'))->where('doctor_id',$request->input('doctor_id'))->orWhereRaw('FIND_IN_SET('.$doctor_id.', assistant_ids)')->where('appointment_date','<',$predate)->where('status','1')->orderby('id','desc')->get();
		
		
		if($request->assistant_id != "0"){
			$checkAppointmentDetailsExist = AppointmentList::where('user_id',$request->input('patient_id'))->where('assistant_ids',$request->input('assistant_id'))->orderby('id','desc')->where('appointment_date','<',$predate)->where('status','1')->get();
		}else{
			$checkAppointmentDetailsExist = AppointmentList::where('user_id',$request->input('patient_id'))->where('doctor_id',$request->input('doctor_id'))->orderby('id','desc')->where('appointment_date','<',$predate)->where('status','1')->get();
		}
		
		
		if ($checkAppointmentHistoryExist) {
			$getAppointmentHistory = $checkAppointmentHistoryExist->toArray();
		}else{
			return response()->json(['status'=>false,'message'=>"No Appointment Available"], $this->errorStatus); 
		}
		
		if(!empty($getAppointmentHistory)){
			$i = 0;
			foreach($getAppointmentHistory as $adkey => $adval){
				$i++;
				foreach($adval as $subadkey => $subadval){
					
					/*if($subadkey=="id"){ 
						$appointmentHistory[$adkey]['appointment_no']='';
						if(!empty($adval[$subadkey])){ 
							$appointmentHistory[$adkey]['appointment_no']=$i;
						}
					}*/
					$appointmentHistory[$adkey]['appointment_no']=$i;
					if($subadkey=="appointment_date"){
						$appointmentHistory[$adkey][$subadkey]='';
						if(!empty($adval[$subadkey])){ 
							$appointmentHistory[$adkey][$subadkey]=date('Y-m-d',strtotime($adval[$subadkey]));
							//$appointmentHistory['appointment_time']=date('H:i:s',strtotime($adval[$subadkey]));
						}
					}
					if($subadkey=='note'){
						$appointmentHistory[$adkey]['notes']='';
						if(!empty($adval[$subadkey])){
							$appointmentHistory[$adkey]['notes']=$adval[$subadkey];						
						}
					}
					
					if($subadkey=='service_detail'){
						$appointmentHistory[$adkey]['service']='';
						if(!empty($adval[$subadkey])){
							$appointmentHistory[$adkey]['service']=$adval[$subadkey]['sub_name_en'];						
						}
					}
					
					if($subadkey=='doctor_id'){
						$appointmentHistory[$adkey]['doctor_name']='';
						if(!empty($adval[$subadkey])){ 
							$checkDoctorName = User::select('name')->where('id',$adval[$subadkey])->get()->first();
							if ($checkDoctorName) {
								$getDoctorName = $checkDoctorName->toArray();
							}
							if(!empty($getDoctorName)){
								if(!empty($getDoctorName['name'])){
									$appointmentHistory[$adkey]['doctor_name']= $getDoctorName['name'];
								}
							}								
						}
						$appointmentHistory[$adkey]['assistant_name']='';
						/*if(!empty($adval[$subadkey])){ 
							$getDoctorAssistantID = DoctorAssistant::select('user_id')->where('doctor_id',$adval[$subadkey])->get()->first()->toArray();							
							if(!empty($getDoctorAssistantID)){
								if(!empty($getDoctorAssistantID['user_id'])){
									$getDoctorAssistantName = User::select('name')->where('id',$getDoctorAssistantID['user_id'])->get()->first()->toArray();
									if(!empty($getDoctorAssistantName)){
										if(!empty($getDoctorAssistantName['name'])){
											$appointmentHistory[$adkey]['assistant_name']= $getDoctorAssistantName['name'];
										}
									}
								}
							}					
						}*/
					}
				}
			}
		}
		return response()->json(['status'=>true,'appointment_detail'=>$appointmentDetails,'appointment_history'=>$appointmentHistory], $this->successStatus);   
		
	}
	/* */
	public function updateProcedurestatus(Request $request){
		$Procedure = Procedure::where('id',$request->procedure_id)->first();
		if($Procedure){
			$Procedure->track_status = 'operation';
			$Procedure->save();	
			return response()->json(['status'=>true,'message' => 'Procedure status updated successfully.']);
		}else{
			return response()->json(['status'=>false,'message' => 'something went wron.']);
		}
	}
	
	public function sendpromotAppointmentOtp(Request $request){
		$dr_id = $request->doctor_id;
		$AppointmentList = AppointmentList::where('id',$request->appointment_id)->where('user_id',$request->user_id)->where('doctor_id',$request->doctor_id)->orWhereRaw('FIND_IN_SET('.$dr_id.', assistant_ids)')->first();
		if($AppointmentList){
			$user = User::where('id',$request->user_id)->first();
			if($user){
				/* Phone Otp */
				$OTP     =  mt_rand(100000, 999999);
				$time 	 = new DateTime(date('Y-m-d H:i:s'));
				$time->add(new DateInterval('PT5M'));
				$expTime = $time->format('Y-m-d H:i:s');													
				$message = "Dear ".$user->name.", Please use this otp to login (".$OTP .")";
				$SmsApi  =  new SmsApi();
				$SmsApi->sendSMS($user->phone, $message);
				/* Email Otp */
				$mdata['email']     = $user->email;
				$mdata['name']      = $user->name;
				$mdata['otp']  		= $OTP;	
				Mail::to($user->email)->send(new SendOtpMail($mdata));
				return response()->json(['status'=>true,'expired_at'=>$expTime,'isVerified'=>1,'message'=>'You will receive OTP on email/phone to login your account','otp'=>(string)$OTP]);  
			}else{
				return response()->json(['status'=>false,'message'=>'Something went wrong.'], $this->successStatus);	
			}
		}else{
			return response()->json(['status'=>false,'message'=>'Something went wrong.'], $this->successStatus);	
		}
	}
	
	
	public function confirmpromotAppointment(Request $request){
		$AppointmentList = AppointmentList::where('id',$request->appointment_id)->where('user_id',$request->user_id)->where('doctor_id',$request->doctor_id)->first();
		
		if($AppointmentList){
			$date	 								= date('Y-m-d H:i:s',strtotime($request->date.' '.$request->time));
			$AppointmentList->appointment_status 	= 'completed';
			$AppointmentList->doctor_approved  	 	= $request->doctor_approved;
			$AppointmentList->user_approved 	 	= $request->user_approved;
			$AppointmentList->report_check 	 		= $request->report_check;
			$AppointmentList->save();
			/* Operation Entry */
			
			$OperationList = OperationList::where('appointment_id',$request->appointment_id)->where('user_id',$request->user_id)->where('doctor_id',$request->doctor_id)->first();
			if($OperationList){
				$OperationList->appointment_id 	= $OperationList->appointment_id;
				$OperationList->procedure_id 	= $OperationList->procedure_id;
				$OperationList->user_id 		= $OperationList->user_id;
				$OperationList->doctor_id 		= $OperationList->doctor_id;
				$OperationList->service_id 		= $OperationList->service_id;
				$OperationList->operation_date 	= $date;
				$OperationList->doctor_approved = $request->doctor_approved;
				$OperationList->user_approved 	= $request->user_approved;
				$OperationList->save();
				if($request->assistant_id != "0"){
					/* save entry in the assistant record table if assistant cancel the appointment*/
					$AssistantProcedureRecords 						= new AssistantProcedureRecords;
					$AssistantProcedureRecords->assistant_id 		= $request->assistant_id;
					$AssistantProcedureRecords->procedure_id 		= $AppointmentList->procedure_id;
					$AssistantProcedureRecords->appointment_id 		= $AppointmentList->id;
					$AssistantProcedureRecords->user_id 			= $AppointmentList->user_id;
					$AssistantProcedureRecords->action 				= "update_ot_dates";
					$AssistantProcedureRecords->save();
				}
			}else{
				$OperationList 					=  new OperationList;
				$OperationList->appointment_id 	= $AppointmentList->id;
				$OperationList->procedure_id 	= $AppointmentList->procedure_id;
				$OperationList->user_id 		= $AppointmentList->user_id;
				$OperationList->doctor_id 		= $AppointmentList->doctor_id;
				$OperationList->service_id 		= $AppointmentList->service_id;
				$OperationList->operation_date 	= $date;
				$OperationList->doctor_approved = $request->doctor_approved;
				$OperationList->user_approved 	= $request->user_approved;
				$OperationList->save();
				
				if($request->assistant_id != "0"){
					/* save entry in the assistant record table if assistant cancel the appointment*/
					$AssistantProcedureRecords 						= new AssistantProcedureRecords;
					$AssistantProcedureRecords->assistant_id 		= $request->assistant_id;
					$AssistantProcedureRecords->procedure_id 		= $AppointmentList->procedure_id;
					$AssistantProcedureRecords->appointment_id 		= $AppointmentList->id;
					$AssistantProcedureRecords->user_id 			= $AppointmentList->user_id;
					$AssistantProcedureRecords->ot_date 			= $date;
					$AssistantProcedureRecords->action 				= "add_ot_dates";
					$AssistantProcedureRecords->save();
				}	
			}
			$doctorDetail = Doctors::where('user_id',$request->doctor_id)->first();
			$address = 'N/A';
			if($doctorDetail){
				$address = $doctorDetail->clinic_address.','.$doctorDetail->doctor_city.','.$doctorDetail->doctor_state.','.$doctorDetail->doctor_zip.' ,'.$doctorDetail->doctor_country;
			}
			
			if($AppointmentList->doctor_approved == "1" && $AppointmentList->user_approved == "1" && $AppointmentList->report_check == "1"){
				$isPromote = 1;
			}else{
				$isPromote = 0;	
			}
			$OperationList = OperationList::where('user_id',$request->user_id)->where('doctor_id',$request->doctor_id)->where('appointment_id',$request->appointment_id)->first();
			$oprationDatadate = 'N/A';
			$oprationDatatime = 'N/A';
			if($OperationList){
				$oprationDatadate = date('d M,Y',strtotime($request->operation_date));
				$oprationDatatime = date('H:i:s',strtotime($request->operation_date));
			}
			$doctor_approved = $request->doctor_approved;
			$user_approved = $request->user_approved;
			$report_check = $request->report_check;
			$get_paid_amount = Procedure::where('id',$AppointmentList->procedure_id)->first();
			$pending_payment = $get_paid_amount->pending_payment;
			//$pending_payment = 0;
			if($doctor_approved == 1 && $user_approved == 1 && $report_check == 1 && $pending_payment == 0)
			{
				$procedureDetail = Procedure::find($AppointmentList->procedure_id);
				$procedureDetail->track_status = 'follow_up';
				$procedureDetail->save(); 
				
				// Add Referral points here...
				
				$user_id = $request->user_id;
				$get_user_detail = User::where("id",$user_id)->first();
				$current_useremail = $get_user_detail->email;
				$check_user_referred = ReferralData::where('ref_to_email',$current_useremail)->where('point_des','reffered to someone')->first();
				if(count($check_user_referred) != 0)
				{
				
					$ref_by_id = $check_user_referred->ref_from;
					$points_data = ReferralPointsData::all();
					$ot_points	= $points_data[0]->ot_points;
					$total_amount = $get_paid_amount->total_payment;
					$reward_points = ($ot_points * $total_amount)/100;
					$check_point_exist = ReferralData::where('user_id',$ref_by_id)->where('point_des','OT')->where('procedure_id',$AppointmentList->procedure_id)->first();
					if(count($check_point_exist) == 0)
					{
						$ot_point = new ReferralData;
						$ot_point->user_id = $ref_by_id;
						$ot_point->ref_from = $ref_by_id;
						$ot_point->ref_code = "";
						$ot_point->ref_to_email = $current_useremail;
						$ot_point->ref_to_phone = "";
						$ot_point->status = "1";
						$ot_point->ref_type = "OT";
						$ot_point->points = $reward_points;
						$ot_point->point_des = "OT";
						$ot_point->procedure_id = $AppointmentList->procedure_id;
						$ot_point->save();
						
						$check_user_point_exist = 	ReferralPoint::where("user_id",$ref_by_id)->first();
					
						if(empty($check_user_point_exist))
						{
							$total_user_points = ReferralData::where("user_id", $ref_by_id)->sum('points');
							$used_points = 0;
							$points_data = new ReferralPoint;
							$points_data->user_id = $ref_by_id;
							$points_data->total_points = $total_user_points;
							$points_data->used_points = $used_points;
							$points_data->save();
						}
						else
						{
							$total_user_points = ReferralData::where("user_id", $ref_by_id)->sum('points');
							$used_points = $check_user_point_exist->used_points;
							$pending_points = $total_user_points - $used_points;
							ReferralPoint::where("user_id",$ref_by_id)->update(['total_points' => $pending_points]);
							
						}
					}
					
				}
			}
			
			
			$balance = 0;
			
			if($get_paid_amount){
				$balance = $get_paid_amount->pending_payment;
			}
			$data = ['date' => date('d M,Y',strtotime($request->date)),'time' => $request->time,'address' => $address,'doctor_approved' => $AppointmentList->doctor_approved,'user_approved' => $AppointmentList->user_approved,'report_check' => $AppointmentList->report_check,'is_promote' => $isPromote,'oprationDatadate' => $oprationDatadate,'oprationDatatime' => $oprationDatatime,'balance' => $balance];
			return response()->json(['status'=>true,'message'=>'Appointment status successfully updated.','data' => $data], $this->successStatus);  
		}else{
			return response()->json(['status'=>false,'message'=>'Something went wrong.'], $this->successStatus);	
		}
	}
	
	public function confirmpromotProcedure(Request $request){
		$OperationList = OperationList::where('user_id',$request->user_id)->where('doctor_id',$request->doctor_id)->where('appointment_id',$request->appointment_id)->first();
		if($OperationList){
			$dateTime 					= $request->complete_date.' '.$request->complete_time;
			$completeDate 				= date('Y-m-d H:i:s',strtotime($dateTime));
			$OperationList->doctor_approved 	= $request->doctor_approved;
			$OperationList->user_approved 		= $request->user_approved;
			$OperationList->operation_date 		= $completeDate;
			$OperationList->operation_status 	= '1';
			$OperationList->status 				= '1';
			$OperationList->save();
			/* Change Procedure Status */
			if($request->doctor_approved && $request->user_approved == 1 && $OperationList->operation_status == 1){
				$procedure 					= Procedure::find($OperationList->procedure_id);
				$procedure->track_status  	= "completed";
				$procedure->complete_date 	= $completeDate;
				$procedure->save();
			}
			$AppointmentList = AppointmentList::where('id',$request->appointment_id)->where('user_id',$request->user_id)->where('doctor_id',$request->doctor_id)->first();
			if($request->assistant_id != "0"){
				/* save entry in the assistant record table if assistant cancel the appointment*/
				$AssistantProcedureRecords 						= new AssistantProcedureRecords;
				$AssistantProcedureRecords->assistant_id 		= $request->assistant_id;
				$AssistantProcedureRecords->procedure_id 		= $AppointmentList->procedure_id;
				$AssistantProcedureRecords->appointment_id 		= $AppointmentList->id;
				$AssistantProcedureRecords->user_id 			= $AppointmentList->user_id;
				$AssistantProcedureRecords->action 				= "promote_procedure";
				$AssistantProcedureRecords->save();
			}
			return response()->json(['status'=>true,'message'=>'Procedure status successfully updated.'], $this->successStatus);  
		}else{
			return response()->json(['status'=>false,'message'=>'Something went wrong.'], $this->successStatus);	
		}
	}
	
	/**
	 *Function Name:appointmentChangeStatus
	 *Function Arguments: One Argument
	 *Function Purpose: To change status (Cancel, Reschedule and Complete) of specific appointment
	 *Function Return: Appointment changed status true/false and its message
	 **/
	public function appointmentChangeStatus(Request $request){
		$users 		= User::where('id',$request->doctor_id)->first();
		if($users){
			$device_token = $users->device_token;
		}
		if($request->input('appointment_status')=="cancel"){
			$validator = Validator::make($request->all(), [ 
				'doctor_id'	  			=> 'required', 
				'patient_id'	  		=> 'required', 
				'appointment_id'		=> 'required',
				'appointment_status'	=> 'required', 
			]);
		}else if($request->input('appointment_status')=="reschedule"){
			$validator = Validator::make($request->all(), [ 
				'doctor_id'	  			=> 'required', 
				'patient_id'	  		=> 'required', 
				'appointment_id'		=> 'required', 
				'appointment_date'	=> 'required', 
				'appointment_time'	=> 'required', 				
			]);
		} 
		if ($validator->fails()) { 						
			foreach($validator->errors()->toArray() as $key=>$er) {
				$err[] = $er[0];
			}
            return response()->json(['status'=>false,'message'=>$err], $this->errorStatus);            
        }
        
        $checkDoctorDetails = User::select(['name','email','phone','device_token','device_id'])->where('id',$request->input('doctor_id'))->first();
        if($checkDoctorDetails){
			$getDoctorDetails = $checkDoctorDetails->toArray();
		}
        $checkDoctorClinicName = Doctors::select(['clinic_name'])->where('user_id',$request->input('doctor_id'))->first();
		if($checkDoctorClinicName){
			$getDoctorClinicName = $checkDoctorClinicName->toArray();
		}
        $checkPatientDetails = User::select(['name','email','phone','device_token','device_id'])->where('id',$request->input('patient_id'))->first();
        if($checkPatientDetails){
			$getPatientDetails = $checkPatientDetails->toArray();
		}
        $getAdminDetails = User::select(['name','email','phone','device_token','device_id'])->where('role',1)->get()->toArray();
        if($request->assistant_id != "0"){
			 $getAppointmentDetails = AppointmentList::where('id',$request->input('appointment_id'))->where('user_id',$request->input('patient_id'))->where('assistant_ids',$request->input('assistant_id'))->where('status','1')->first();
		}else{
			 $getAppointmentDetails = AppointmentList::where('id',$request->input('appointment_id'))->where('user_id',$request->input('patient_id'))->where('doctor_id',$request->input('doctor_id'))->where('status','1')->first();
		}
        if(!empty($getAppointmentDetails)){
			$appointment_date = date('d-m-Y',strtotime($getAppointmentDetails->appointment_date));
			$appointment_time = date('h:i A',strtotime($getAppointmentDetails->appointment_date));
			if($request->input('appointment_status')=="cancel"){
				$getAppointmentDetails->appointment_status=$request->input('appointment_status');
				$getAppointmentDetails->save();
				if($request->assistant_id != "0"){
					/* save entry in the assistant record table if assistant cancel the appointment*/
					$AssistantProcedureRecords 						= new AssistantProcedureRecords;
					$AssistantProcedureRecords->assistant_id 		= $request->assistant_id;
					$AssistantProcedureRecords->procedure_id 		= $getAppointmentDetails->procedure_id;
					$AssistantProcedureRecords->appointment_id 		= $getAppointmentDetails->id;
					$AssistantProcedureRecords->user_id 			= $getAppointmentDetails->user_id;
					$AssistantProcedureRecords->action 				= "cancel";
					$AssistantProcedureRecords->save();
				}
				if(!empty($getAdminDetails)){
					foreach($getAdminDetails as $adminDetailkey=> $adminDetailvalue){
						//Email to Admin
							$mdata['user_role']     = "Admin";
							$mdata['email']     = $getAdminDetails[$adminDetailkey]['email'];
							$mdata['name']      = $getAdminDetails[$adminDetailkey]['name'];
							$mdata['message']   = "This mail is to inform you that there is a new cancellation request  for the appointment scheduled of Mr ".$getPatientDetails['name']." with Dr. ".$getDoctorDetails['name']." on ".$appointment_date." at ".$appointment_time." in ".$getDoctorClinicName['clinic_name']." has been cancelled. Any update regarding the appointment will be informed to you through the mail. ";
							$mdata['caption']   = "Regards";
							$mdata['signature'] = "Kabera";
							Mail::to($mdata['email'])->send(new AppointmentCancelMail($mdata));	
					}
				}
				if(!empty($getDoctorDetails)){
					//Message to Doctor
						$message	 = "Dear Dr. ".$getDoctorDetails['name'].", you have cancelled your appointment with your patient ".$getPatientDetails['name']." on ".$appointment_date." at ".$appointment_time." in ".$getDoctorClinicName['clinic_name'].". If it has not been cancelled at your end please let us know.";
						$SmsApi 	 =  new SmsApi();
						$SmsApi->sendSMS($getDoctorDetails['phone'], $message);
					//Email to Doctor
						$mdata['user_role'] = "Doctor";
						$mdata['email']     = $getDoctorDetails['email'];
						$mdata['name']      = $getDoctorDetails['name'];
						$mdata['message']   = "This mail is to inform you that you have cancelled your appointment that was scheduled with your patient ".$getPatientDetails['name']." on ".$appointment_date." at ".$appointment_time." in ".$getDoctorClinicName['clinic_name'].". If it has not been cancelled at your end please let us know. In order to schedule a new appointment with your patient please contact Kabera.";
						$mdata['caption']   = "Regards";
						$mdata['signature'] = "Kabera";
						Mail::to($mdata['email'])->send(new AppointmentCancelMail($mdata));
					//Notification To Doctor
					//Notification to Doctor for Anroid Device - Cancel
						if($device_token != ""){
							$this->CancelAppointmentNotification($device_token);
						}
				}
				if(!empty($getPatientDetails)){
					//Message to Patient
						$message	 = "Dear Patient, your appointment scheduled with Dr. ".$getDoctorDetails['name']." on ".$appointment_date." at ".$appointment_time." in ".$getDoctorClinicName['clinic_name']." has been cancelled. If it has not been cancelled at your end please let us know.";
						$SmsApi 	 =  new SmsApi();
						$SmsApi->sendSMS($getPatientDetails['phone'], $message);
					//Email to Patient
						$mdata['user_role']     = "Patient";
						$mdata['email']     = $getPatientDetails['email'];
						$mdata['name']      = $getPatientDetails['name'];
						$mdata['message']   = "This mail is to inform you that your appointment was scheduled with Dr.".$getDoctorDetails['name']." on ".$appointment_date." at ".$appointment_time." in ".$getDoctorClinicName['clinic_name']." has been cancelled. If it has not been cancelled at your end please let us know. In order to schedule a new appointment please contact Kabera or book a new date from your Kabera app.";
						$mdata['caption']   = "With love";
						$mdata['signature']   = "Kabera…… Jiyo Umarless";
						Mail::to($mdata['email'])->send(new AppointmentCancelMail($mdata));	
					//Notification To Patient
						if(!empty($getPatientDetails['device_id'])){
							$this->AppointmentChangeForWeb($getPatientDetails['device_id']);
						}
					//Notification to Patient for Anroid Device - Cancel
				}
				
				
					$device_token = User::where('id',$request->input('patient_id'))->first();
					//print_r($device_token);  die;
					
					if($device_token->device_id != ''){								
						$this->ChangeAppointmenCancelAssistant($device_token->device_id);
					}
					
					$assistant = DoctorAssistant::with(array('user' => function($q){ 
						 $q->select('id','name','email', 'phone','added_by','request_recieve_per_day','device_token');
					}))->where('doctor_id', $request->doctor_id)->get();
							
						foreach($assistant as $assistants){
							//print_r($assistants->user->device_token); 
							if($assistants->user->device_token != ''){								
								$device_token = $assistants->user->device_token;								
								$this->ChangeAppointmenCancelToAssistant($device_token);
								
							} 
						}
					
					
				return response()->json(['status'=>true,'message'=>"Appointment is cancelled"], $this->successStatus);
			}else if($request->input('appointment_status')=="reschedule"){
				if($request->assistant_id != "0"){
					/* save entry in the assistant record table if assistant cancel the appointment*/
					$AssistantProcedureRecords 						= new AssistantProcedureRecords;
					$AssistantProcedureRecords->assistant_id 		= $request->assistant_id;
					$AssistantProcedureRecords->procedure_id 		= $getAppointmentDetails->procedure_id;
					$AssistantProcedureRecords->appointment_id 		= $getAppointmentDetails->id;
					$AssistantProcedureRecords->user_id 			= $getAppointmentDetails->user_id;
					$AssistantProcedureRecords->action 				= "reschedule";
					$AssistantProcedureRecords->save();
				}
				$getAppointmentDetails->user_id		=	$request->input('patient_id');
				$getAppointmentDetails->doctor_id	=	$request->input('doctor_id');
				$getAppointmentDetails->is_visited	=	(0);
				$appointment_time 					= 	explode('TO',$request->input('appointment_time'));
				$appointment_date = '';
				$appointment_to_date = '';
				if(count($appointment_time) > 1){
					$appointmrntTime1 = $appointment_time[0];
					$appointmrntTime2 = $appointment_time[1];
				}else{
					$appointmrntTime1 = $appointment_time[0];
					$appointmrntTime2 = $appointment_time[0];
				}
				if(!empty($appointment_time)){
					$appointment_date= date('Y-m-d H:i:s',strtotime($request->input('appointment_date').' '.date('H:i:s',strtotime($appointmrntTime1))));
					$appointment_to_date= date('Y-m-d H:i:s',strtotime($request->input('appointment_date').' '.date('H:i:s',strtotime($appointmrntTime2))));
				}
				$getAppointmentDetails->appointment_date= $appointment_date;
				$getAppointmentDetails->appointment_to_date = $appointment_to_date;
				$getAppointmentDetails->save();
				if(!empty($getAdminDetails)){
					foreach($getAdminDetails as $adminDetailkey=> $adminDetailvalue){
						//Email to Admin
							$mdata['user_role']     = "Admin";
							$mdata['email']     = $getAdminDetails[$adminDetailkey]['email'];
							$mdata['name']      = $getAdminDetails[$adminDetailkey]['name'];
							$mdata['message'] = "Appointment Rescheduled";
							$mdata['caption']   = "Regards";
							$mdata['signature'] = "Kabera";
							Mail::to($mdata['email'])->send(new AppointmentCancelMail($mdata));	
					}									
				}
				if(!empty($getDoctorDetails)){
					//Message to Doctor
						$message = "Appointment Rescheduled";
						$SmsApi 	 =  new SmsApi();
						$SmsApi->sendSMS($getDoctorDetails['phone'], $message);
					//Email to Doctor
						$mdata['user_role'] = "Doctor";
						$mdata['email']     = $getDoctorDetails['email'];
						$mdata['name']      = $getDoctorDetails['name'];
						$mdata['message'] = "Appointment Rescheduled";
						$mdata['caption']   = "Regards";
						$mdata['signature'] = "Kabera";
						Mail::to($mdata['email'])->send(new AppointmentRescheduleMail($mdata));	
					//Notification To Doctor
						if(!empty($getDoctorDetails['device_token'])){
							$this->ChangeAppointmentNotification($getDoctorDetails['device_token']);
						}
						
						$assistant = DoctorAssistant::with(array('user' => function($q){ 
						 $q->select('id','name','email', 'phone','added_by','request_recieve_per_day','device_token');
					}))->where('doctor_id', $request->doctor_id)->get();
							
						foreach($assistant as $assistants){
							//print_r($assistants->user->device_token); 
							if($assistants->user->device_token != ''){								
								$device_token = $assistants->user->device_token;								
								$this->ChangeAppointmenAssistant($device_token);
								
							} 
						}
						
					//Notification to Doctor for Anroid Device - Reschedule
				}
				
				if(!empty($getPatientDetails)){
					//Message to Patient
						$message = "Appointment Rescheduled";
						$SmsApi 	 =  new SmsApi();
						$SmsApi->sendSMS($getPatientDetails['phone'], $message);
					//Email to Patient
						$mdata['user_role']     = "Patient";
						$mdata['email']     = $getPatientDetails['email'];
						$mdata['name']      = $getPatientDetails['name'];
						$mdata['message'] = "Appointment Rescheduled";
						$mdata['caption']   = "With love";
						$mdata['signature']   = "Kabera…… Jiyo Umarless";
						Mail::to($mdata['email'])->send(new AppointmentRescheduleMail($mdata));	
					//Notification To Patient
					
					if($request->input('appointment_status')=="reschedule"){
											
						$proceduree 		   = Procedure::find($getAppointmentDetails['procedure_id']);			
						$AppointmentListstatus = AppointmentList::where('procedure_id',$proceduree->id)->first(['status']);
						
						$MobileNotification    = new MobileNotification();					
						$MobileNotification->user_id = $request->patient_id;
						$MobileNotification->procedure_id = $proceduree->id;
						$MobileNotification->report_id = $proceduree->report_id;
						$MobileNotification->track_status = $proceduree->track_status;
						$MobileNotification->notification_status = $AppointmentListstatus->status;
						$MobileNotification->type = $proceduree->type;
						$MobileNotification->notification_type = 'Resedule Appointment';
						$MobileNotification->save();
						
						$mobileDetail = array('user_id'=>$MobileNotification->user_id,'procedure_id'=>$MobileNotification->procedure_id,'report_id'=>$MobileNotification->report_id,'track_status'=>$MobileNotification->track_status,'notification_status'=>$MobileNotification->notification_status,'type'=>$MobileNotification->type,'notification_type'=>$MobileNotification->notification_type);
						
						//print_r($MobileNotification); die;
						if(!empty($getPatientDetails['device_id'])){
							$this->ChangeAppointmentNotification($getPatientDetails['device_id'], $mobileDetail);
						}
					
						
					}else{				
						
						$proceduree 		   = Procedure::find($getAppointmentDetails['procedure_id']);				
						$AppointmentListstatus = AppointmentList::where('procedure_id',$proceduree->id)->first(['status']);

						$MobileNotification 	= new MobileNotification();						
						$MobileNotification->user_id = $request->patient_id;
						$MobileNotification->procedure_id = $proceduree->id;
						$MobileNotification->report_id = $proceduree->report_id;
						$MobileNotification->track_status = $proceduree->track_status;
						$MobileNotification->notification_status = $AppointmentListstatus->status;
						$MobileNotification->type = $proceduree->type;
						$MobileNotification->notification_type = 'Cancel Appointment';
						$MobileNotification->save();
						
						$mobileDetail = array('user_id'=>$MobileNotification->user_id,'procedure_id'=>$MobileNotification->procedure_id,'report_id'=>$MobileNotification->report_id,'track_status'=>$MobileNotification->track_status,'notification_status'=>$MobileNotification->notification_status,'type'=>$MobileNotification->type,'notification_type'=>$MobileNotification->notification_type);
							
							if(!empty($getPatientDetails['device_id'])){
							$this->AppointmentChangeForWeb($getPatientDetails['device_id'] , $mobileDetail);
							
							}
					}
					//Notification to Patient form Anroid Device - Reschedule
				
				}
				return response()->json(['status'=>true,'message'=>"Appointment is rescheduled"], $this->successStatus);
			}
		}else{
			return response()->json(['status'=>false,'message'=>"No Appointment Available"], $this->errorStatus);
		}
	}
	
	/**
	 *Function Name:addUpdateAppointmentNotes
	 *Function Arguments: One Argument
	 *Function Purpose: To add appointment notes
	 *Function Return: Appointment changed status true/false and its message
	 **/
	public function addUpdateAppointmentNotes(Request $request){
		
		$validator = Validator::make($request->all(), [ 
			'doctor_id'	  		=> 'required', 
			'patient_id'	  	=> 'required', 
			'appointment_id'	=> 'required', 
			'action'			=> 'required', 
			'procedure_id'		=> 'required', 			
		]);
		if ($validator->fails()) { 						
			foreach($validator->errors()->toArray() as $key=>$er) {
				$err[] = $er[0];
			}
            return response()->json(['status'=>false,'message'=>$err], $this->errorStatus);            
        }
        
      // print_r($request->input('patient_id')); die;
        
		$users 		= User::where('id',$request->doctor_id)->first();
		if($users){
			$device_token = $users->device_token;
		}
        $getAppointmentDetails = AppointmentList::where('id',$request->input('appointment_id'))->where('user_id',$request->input('patient_id'))->where('doctor_id',$request->input('doctor_id'))->where('status','1')->get()->first();
		$checkPatientDetails = User::select(['name','email','phone','device_token'])->where('id',$request->input('patient_id'))->get()->first();
        if($checkPatientDetails){
			$getPatientDetails = $checkPatientDetails->toArray();
		}
		
        if(!empty($getAppointmentDetails)){
			if($request->input('action')=="add_note"){
				$getAppointmentDetails->note=$request->input('note');
				$getAppointmentDetails->save();
				/* note added in comment-note-data table */
				 $addnote = new NoteCommentData;
				 $addnote->user_id = $request->input('patient_id');
				 $addnote->procedure_id = $request->input('procedure_id');
				 $addnote->appointment_id = $request->input('appointment_id');
				 $addnote->doctor_assistant_ids = $request->input('doctor_id');
				 $addnote->type = 'note';
				 $addnote->comments_notes = $request->input('note');
				 $addnote->visible_to  = $request->input('visible_to');
				 $addnote->save();
				 $id = $addnote->id;
				 $date = date("Y-m-d h:i:s");
				 $author_name = User::where('id',$request->input('doctor_id'))->first();
				 $name = $author_name->name;
				 $type = 'note';
				 
				 $data = array('id' => $id,'message' => $request->input('note'),'date' => $date,'author_name' => $name,'type' => $type);
				if($request->assistant_id != "0"){
					/* save entry in the assistant record table if assistant cancel the appointment*/
					$AssistantProcedureRecords 						= new AssistantProcedureRecords;
					$AssistantProcedureRecords->assistant_id 		= $request->assistant_id;
					$AssistantProcedureRecords->procedure_id 		= $getAppointmentDetails->procedure_id;
					$AssistantProcedureRecords->appointment_id 		= $getAppointmentDetails->id;
					$AssistantProcedureRecords->user_id 			= $getAppointmentDetails->user_id;
					$AssistantProcedureRecords->action 				= "appointment_note_add";
					$AssistantProcedureRecords->note 				= $request->input('note');
					$AssistantProcedureRecords->action_id 	    	= $addnote->id;
					$AssistantProcedureRecords->save();
				}
				
				if(!empty($getPatientDetails)){
					//Notification To Patient
						if(!empty($getPatientDetails['device_token'])){
							}					
				}
				
				
				$users_id 		= User::where('id',$request->patient_id)->first();
				
				if($users_id && $users_id->device_id != ''){
					$device_id = $users_id->device_id;
					$this->NoteNotificationForWebApp($device_id);
				}
				
				$assistant = DoctorAssistant::with(array('user' => function($q){ 
						 $q->select('id','name','email', 'phone','added_by','request_recieve_per_day','device_token');
					}))->where('doctor_id', $request->input('doctor_id'))->get();
					
				foreach($assistant as $assistants){
					//print_r($assistants->user->device_token); 
					if($assistants->user->device_token != ''){
						
						$device_token = $assistants->user->device_token;
						
						$this->NotificatinAssistantNote($device_token);
						
						} 
					
				}
				
				
				$doctor 		= User::where('id', $request->input('doctor_id'))->first();
				
				if($doctor->device_token != ''){
					$device_id = $doctor->device_token;
					$this->NoteNotificationForDoctor($device_id);
				}
				
				
				
				return response()->json(['status'=>true,'message'=>"New note is added for the appointment",'data' => $data], $this->successStatus);
			}else{
				$getAppointmentDetails->note=$request->input('note');
				$getAppointmentDetails->save();
				
				$NoteCommentData = NoteCommentData::where('user_id',$request->input('patient_id'))->where('procedure_id',$request->input('procedure_id'))->where('appointment_id',$request->input('appointment_id'))->first();
				
				if($NoteCommentData){
					$NoteCommentData->comments_notes = $request->input('note');
					$NoteCommentData->visible_to  = $request->input('visible_to');
					$NoteCommentData->save();
				}
				
				if($request->assistant_id != "0"){
					/* save entry in the assistant record table if assistant cancel the appointment*/
					$AssistantProcedureRecords 						= new AssistantProcedureRecords;
					$AssistantProcedureRecords->assistant_id 		= $request->assistant_id;
					$AssistantProcedureRecords->procedure_id 		= $getAppointmentDetails->procedure_id;
					$AssistantProcedureRecords->appointment_id 		= $getAppointmentDetails->appointment_id;
					$AssistantProcedureRecords->user_id 			= $getAppointmentDetails->user_id;
					$AssistantProcedureRecords->action 				= "appointment_note_add";
					$AssistantProcedureRecords->save();
				}
				if(!empty($getDoctorDetails)){
					//Notification To Patient
						if(!empty($getPatientDetails['device_token'])){
							$this->AppointmentUpdate($getPatientDetails['device_token']);
						}					
				}
				
				$proceduree 	= Procedure::where('user_id',$request->input('patient_id'))->first();			
				$AppointmentListstatus = AppointmentList::where('procedure_id',$proceduree->id)->first(['status']);
				$MobileNotification    = new MobileNotification();
				
				$MobileNotification->user_id = $request->patient_id;
				$MobileNotification->procedure_id = $proceduree->id;
				$MobileNotification->report_id = $proceduree->report_id;
				$MobileNotification->track_status = $proceduree->track_status;
				$MobileNotification->notification_status = $AppointmentListstatus->status;
				$MobileNotification->type = $proceduree->type;
				$MobileNotification->notification_type = 'Add Note';
				
				$mobileDetail = array('user_id'=>$MobileNotification->user_id,'procedure_id'=>$MobileNotification->procedure_id,'report_id'=>$MobileNotification->report_id,'track_status'=>$MobileNotification->track_status,'notification_status'=>$MobileNotification->notification_status,'type'=>$MobileNotification->type,'notification_type'=>$MobileNotification->notification_type);
				
				//print_r($MobileNotification); die;
				
				$MobileNotification->save();
					
				
				
				
				$users 		= User::where('id',$request->input('patient_id'))->first();
				
				if($users){
					$device_id = $users->device_id;
					if(!empty($users->device_id) ){
						
						$this->AppointmentUpdateWeb($device_id);	
					}
				}
				return response()->json(['status'=>true,'message'=>"Note is updated for the appointment"], $this->successStatus);
			}
		}else{
			return response()->json(['status'=>false,'message'=>"No Appointment Available"], $this->errorStatus);
		}
	}
	
	/**
	 *Function Name:addNewAppointment
	 *Function Arguments: One Argument
	 *Function Purpose: To add new appointment
	 *Function Return: Appointment changed status true/false and its message
	 **/
	public function addNewAppointment(Request $request){
		
		$validator = Validator::make($request->all(), [ 
			'doctor_id'	  			=> 'required', 
			'patient_id'	  		=> 'required', 
			'appointment_id'		=> 'required', 
			'appointment_date'		=> 'required', 
			'appointment_time'		=> 'required'	
		]);
		if ($validator->fails()) { 						
			foreach($validator->errors()->toArray() as $key=>$er) {
				$err[] = $er[0];
			}
            return response()->json(['status'=>false,'message'=>$err], $this->errorStatus);            
        }
        if($request->assistant_id != "0"){
			$users 		= User::where('id',$request->assistant_id)->first();
		}else{
			$users 		= User::where('id',$request->doctor_id)->first();
		}
        
		if($users){
			$device_token = $users->device_token;
		}
        
        $checkAppointmentDetails = AppointmentList::select(['id','assistant_ids','procedure_id','service_id'])->where('id',$request->input('appointment_id'))->get()->first();
		$checkAppointmentDetailsExist 	  = [];
        if($checkAppointmentDetails){
			$checkAppointmentDetailsExist = $checkAppointmentDetails->toArray();
		}
		if(!empty($checkAppointmentDetailsExist)){
			if($checkAppointmentDetailsExist['assistant_ids'] != ""){
				$assistant_id = $checkAppointmentDetailsExist['assistant_ids'];
			}else{
				$assistant_id = $request->assistant_id;
			}
			$time 										= explode("TO",$request->input('appointment_time'));
			$getAppointmentDetails 						= new AppointmentList();
			$getAppointmentDetails->user_id 			= $request->input('patient_id');
			$getAppointmentDetails->procedure_id 		= $checkAppointmentDetailsExist['procedure_id'];
			$getAppointmentDetails->service_id	 		= $checkAppointmentDetailsExist['service_id'];
			$getAppointmentDetails->doctor_id 			= $request->input('doctor_id');
			$getAppointmentDetails->appointment_date 	= date('Y-m-d H:i:s',strtotime($request->input('appointment_date').' '.$time[0]));
			$getAppointmentDetails->appointment_to_date = date('Y-m-d H:i:s', strtotime($request->input('appointment_date').' '.$time[1]));
			$getAppointmentDetails->note 				= $request->input('note');
			$getAppointmentDetails->appointment_status 	= "new";
			$getAppointmentDetails->status 	= "1";
			$getAppointmentDetails->assistant_ids 		= $assistant_id;
			$getAppointmentDetails->save();
			if($request->assistant_id != "0"){
				/* save entry in the assistant record table if assistant cancel the appointment*/
				$AssistantProcedureRecords 						= new AssistantProcedureRecords;
				$AssistantProcedureRecords->assistant_id 		= $request->assistant_id;
				$AssistantProcedureRecords->procedure_id 		= $getAppointmentDetails->procedure_id;
				$AssistantProcedureRecords->appointment_id 		= $getAppointmentDetails->id;
				$AssistantProcedureRecords->user_id 			= $getAppointmentDetails->user_id;
				$AssistantProcedureRecords->action 				= "add_new_appointment";
				$AssistantProcedureRecords->save();
			}
			$checkDoctorDetails = User::select(['name','email','phone','device_token'])->where('id',$request->input('doctor_id'))->get()->first();
			if($checkDoctorDetails){
				$getDoctorDetails = $checkDoctorDetails->toArray();
			}
			$checkDoctorClinicName = Doctors::select(['clinic_name'])->where('user_id',$request->input('doctor_id'))->get()->first();
			if($checkDoctorClinicName){
				$getDoctorClinicName = $checkDoctorClinicName->toArray();
			}
			$checkPatientDetails = User::select(['name','email','phone','device_token'])->where('id',$request->input('patient_id'))->get()->first();
			if($checkPatientDetails){
				$getPatientDetails = $checkPatientDetails->toArray();
			}
			if($device_token != ""){
				$this->doctorAddAppointment($device_token);	
			}
			
			$proceduree 	= Procedure::find($checkAppointmentDetailsExist['procedure_id']);
			
			$AppointmentListstatus = AppointmentList::where('procedure_id',$proceduree->id)->first(['status']);

			$MobileNotification 	= new MobileNotification();
			
			$MobileNotification->user_id = $request->patient_id;
			$MobileNotification->procedure_id = $proceduree->id;
			$MobileNotification->report_id = $proceduree->report_id;
			$MobileNotification->track_status = $proceduree->track_status;
			$MobileNotification->notification_status = $AppointmentListstatus->status;
			$MobileNotification->type = $proceduree->type;
			$MobileNotification->notification_type = 'Add New Appointment';
			$MobileNotification->save();
			$mobileDetail = array('user_id'=>$MobileNotification->user_id,'procedure_id'=>$MobileNotification->procedure_id,'report_id'=>$MobileNotification->report_id,'track_status'=>$MobileNotification->track_status,'notification_status'=>$MobileNotification->notification_status,'type'=>$MobileNotification->type,'notification_type'=>$MobileNotification->notification_type);
			
			//print_r($MobileNotification); die;
			
			
			
				
			$users 	= User::where('id',$request->patient_id)->first();
				if($users){
					$device_id = $users->device_id;
					if($users->device_id != ""){
						$this->AddNewAppointmentWeb($device_id , $mobileDetail);
					}
				}
				
				$assistant = DoctorAssistant::with(array('user' => function($q){ 
						 $q->select('id','name','email', 'phone','added_by','request_recieve_per_day','device_token');
					}))->where('doctor_id', $request->doctor_id)->get();
					
				foreach($assistant as $assistants){
					//print_r($assistants->user->device_token); 
					if($assistants->user->device_token != ''){
						
						$device_token = $assistants->user->device_token;
						
						$this->AddAppointmentAssistant($device_token);
						
						} 
					
				}	
				
				
			return response()->json(['status'=>true,'message'=>"New Appointment is added successfully"], $this->successStatus);			
		}else{
			return response()->json(['status'=>false,'message'=>"No Appointment Available"], $this->errorStatus);
		}
        
	}

	/**
	 *Function Name:addCommentByDoctorForAppointment
	 *Function Arguments: One Argument
	 *Function Purpose: To add doctor comment on patient appointment
	 *Function Return: Status true/false and its message
	 **/
	public function addDrCommntForAppointment(Request $request){
		$validator = Validator::make($request->all(), [ 
			'doctor_id'	  			=> 'required', 
			'patient_id'	  		=> 'required', 
			'procedure_id'			=> 'required', 			
			'appointment_id'		=> 'required', 			
		]);
		if ($validator->fails()) { 						
			foreach($validator->errors()->toArray() as $key=>$er) {
				$err[] = $er[0];
			}
            return response()->json(['status'=>false,'message'=>$err], $this->errorStatus);            
        }
		$addcomment = new NoteCommentData;
		$addcomment->user_id = $request->input('patient_id');
		$addcomment->procedure_id = $request->input('procedure_id');
		$addcomment->appointment_id = $request->input('appointment_id');
		$addcomment->doctor_assistant_ids = $request->input('doctor_id');
		$addcomment->type = 'comment';
		$addcomment->comments_notes = $request->input('doctor_comment');
		$addcomment->visible_to 			= $request->input('visible_to');
		$addcomment->save();
		$AppointmentList = AppointmentList::find($request->input('appointment_id'));
		if($request->assistant_id != "0"){
			/* save entry in the assistant record table if assistant cancel the appointment*/
			$AssistantProcedureRecords 						= new AssistantProcedureRecords;
			$AssistantProcedureRecords->assistant_id 		= $request->assistant_id;
			$AssistantProcedureRecords->procedure_id 		= $AppointmentList->procedure_id;
			$AssistantProcedureRecords->appointment_id 		= $AppointmentList->id;
			$AssistantProcedureRecords->user_id 			= $AppointmentList->user_id;
			$AssistantProcedureRecords->action 				= "appointment_comment";
			$AssistantProcedureRecords->action_id 	    	= $addcomment->id;
			$AssistantProcedureRecords->save();
		}
		$id = $addcomment->id;
		$date = date("Y-m-d h:i:s");
		$author_name = User::where('id',$request->input('doctor_id'))->first();
		$name = $author_name->name;
		$type = 'comment';
		$data = array('id' => $id,'message' => $request->input('doctor_comment'),'date' => $date,'author_name' => $name,'type' => $type);
		
			/*$assistant = DoctorAssistant::with(array('user' => function($q){ 
						 $q->select('id','name','email', 'phone','added_by','request_recieve_per_day','device_token');
					}))->where('doctor_id', $request->input('doctor_id'))->get();
					
				foreach($assistant as $assistants){
					//print_r($assistants->user->device_token); 
					if($assistants->user->device_token != ''){
						
						$device_token = $assistants->user->device_token;
						
						$this->AddAppointmentAssistantComment($device_token);
						
						} 
					
				}*/
		
				$proceduree 	= Procedure::where('user_id',$request->input('patient_id'))->first();
				
				$AppointmentListstatus = AppointmentList::where('procedure_id',$proceduree->id)->first(['status']);

				$MobileNotification 	= new MobileNotification();
				
				$MobileNotification->user_id = $request->patient_id;
				$MobileNotification->procedure_id = $proceduree->id;
				$MobileNotification->report_id = $proceduree->report_id;
				$MobileNotification->track_status = $proceduree->track_status;
				$MobileNotification->notification_status = $AppointmentListstatus->status;
				$MobileNotification->type = $proceduree->type;
				$MobileNotification->notification_type = 'Add Comment';
				
				$mobileDetail = array('user_id'=>$MobileNotification->user_id,'procedure_id'=>$MobileNotification->procedure_id,'report_id'=>$MobileNotification->report_id,'track_status'=>$MobileNotification->track_status,'notification_status'=>$MobileNotification->notification_status,'type'=>$MobileNotification->type,'notification_type'=>$MobileNotification->notification_type);
				
				//print_r($MobileNotification); die;
				
				$MobileNotification->save();
					
		
				$users = User::where('id', $request->input('patient_id'))->first();
				if($users->device_id != ''){						
						$device_token = $users->device_id;
						
						$this->AddAppointmentDoctorComment($device_token, $mobileDetail);
						
				} 
		
		
		
		
		return response()->json(['status'=>true,'message'=>"Comment added successfully",'data' => $data], 200); 
		//
		//return response()->json(['status'=>false,'message'=>"No appointment is available"], $this->errorStatus); 
	
	}
	/***
	 * Get Appointment Request Notifications
	**/	
	public function getAppointmentNotification(Request $request) {
		
		$total_records = $request->input('max-results');
		$getPreappointments = AppointmentList::where('doctor_id', $request->doctor_id)->where('status','1')->with(['user_detail'])->paginate($total_records)->toArray();
		$predataArrays = [];
		$dataArrays = [];
		if(!empty($getPreappointments)){
			foreach($getPreappointments['data'] as $appointment){
				$affected_rows_area = 'Not Defined';
				$procedure    = Procedure::find($appointment['procedure_id']);
				if($procedure){
					$HairTransplantReport = HairTransplantReport::find($procedure->report_id);
					if($HairTransplantReport){
						$affected_rows_area = str_replace(',','+',$HairTransplantReport->affected_ids);
					}
				}
				if($affected_rows_area == ""){
					$affected_rows_area = 'Not Defined';
				}
				$predataArray['appointment_id'] 	= $appointment['id'];
				$predataArray['affected_area'] 	= $affected_rows_area;
				$predataArray['appointment_date'] 	= $appointment['appointment_date'];
				$predataArray['appointment_time'] 	= date('H:i a',strtotime($appointment['appointment_date']));
				$predataArray['user_name'] 		= $appointment['user_detail']['name'];
				$predataArray['service'] 			= $this->getService($appointment['service_id']);
				$predataArray['description'] 	    = "N/A";
				$predataArray['request_type'] 	    = "confirmed";
				$predataArrays[]                   = $predataArray;
			}	
		}
		$appointments  = AppointmentList::where('doctor_id', '0')->where('status','0')->with(['user_detail'])->paginate($total_records)->toArray();
		if($appointments){
			foreach($appointments['data'] as $appointment){
				$affected_rows_area = 'Not Defined';
				$procedure    = Procedure::find($appointment['procedure_id']);
				if($procedure){
					$HairTransplantReport = HairTransplantReport::find($procedure->report_id);
					if($HairTransplantReport){
						$affected_rows_area = str_replace(',','+',$HairTransplantReport->affected_ids);
					}
				}
				if($affected_rows_area == ""){
					$affected_rows_area = 'Not Defined';
				}
				$AppointmentRequest = AppointmentRequest::where('appointment_id',$appointment['id'])->where('doctor_id',$request->doctor_id)->first();
			    if($AppointmentRequest){ //only for requested doctors
					$dataArray['appointment_id'] 	= $appointment['id'];
					$dataArray['affected_area'] 	= $affected_rows_area;
					$dataArray['appointment_date'] 	= $appointment['appointment_date'];
					$dataArray['appointment_time'] 	= date('H:i a',strtotime($appointment['appointment_date']));
					$dataArray['user_name'] 		= $appointment['user_detail']['name'];
					$dataArray['service'] 			= $this->getService($appointment['service_id']);
					$dataArray['description'] 	    = "N/A";
					$dataArray['request_type'] 	    = "new";
					$dataArrays[]                   = $dataArray;
				}
				//For all doctors
				/*$dataArray['appointment_id'] 	= $appointment['id'];
				$dataArray['affected_area'] 	= $affected_rows_area;
				$dataArray['appointment_date'] 	= $appointment['appointment_date'];
				$dataArray['appointment_time'] 	= date('H:i a',strtotime($appointment['appointment_date']));
				$dataArray['user_name'] 		= $appointment['user_detail']['name'];
				$dataArray['service'] 			= $this->getService($appointment['service_id']);
				$dataArray['description'] 	    = "N/A";
				$dataArray['request_type'] 	    = "new";
				$dataArrays[]                   = $dataArray;
				*/
			}	
			
		}
		
		$finalArray = array_merge($dataArrays);//,$predataArrays
		if(!empty($finalArray)){
			
			return response()->json(['status'=>'success', 'appointments' => $finalArray], $this->successStatus); 
		} else {
			return response()->json(['status'=>'success', 'appointments' => []], $this->successStatus); 			
		}
    }
    
    public function getService($id){
		$Service 		= SubService::find($id);
		$serviceName 	= 'N/A';
		if($Service){
			$serviceName = $Service->sub_name_en;
		}
		return $serviceName;
	}
	
	public function doctorAddAppointment($token) 
	{
		//die('svsdfs');
		
		//echo $message; die
		$optionBuilder = new OptionsBuilder();
		
		$optionBuilder->setTimeToLive(60*20);
		
		$notificationBuilder = new PayloadNotificationBuilder('Kabera');
		$notificationBuilder->setBody('New Appointment Added Successfully')
							->setSound('default');					
		$dataBuilder = new PayloadDataBuilder();
		
		//$message1 =  Response::json(array('success'=>false,'message'=>$message));	
		
		
		$dataBuilder->addData(['message' => 'New Appointment Added Successfully']);
			
		
			
		$option = $optionBuilder->build();
		$notification = $notificationBuilder->build();
		$data = $dataBuilder->build();
		$downstreamResponse = FCM::sendTo($token, $option, $notification, $data);

		$downstreamResponse->numberSuccess();
		$downstreamResponse->numberFailure();
		$downstreamResponse->numberModification();

		// return Array - you must remove all this tokens in your database
		$downstreamResponse->tokensToDelete();

		// return Array (key : oldToken, value : new token - you must change the token in your database)
		$downstreamResponse->tokensToModify();

		// return Array - you should try to resend the message to the tokens in the array
		$downstreamResponse->tokensToRetry();

		// return Array (key:token, value:error) - in production you should remove from your database the tokens
		$downstreamResponse->tokensWithError();
		
		
	}
	
	
	
	
	
	public function AppointmentUpdate($token) 
	{
		//die('svsdfs');
		
		//echo $message; die;
		
		//Android Token
		//$token = 'epweoOXplKw:APA91bG_pxWZBE5w4KEK6pFoU9Fgzn8JVpkrbqwV-MawLlaOkAdVMKMOQptYwUyyZ0CcpH825l0pJUptUKopL2mnmLVNZTdFcyOe1Wvq__t4Djcz0j_mtdcpCX4kRrv_tBN_e_3SilK0';

		
		$optionBuilder = new OptionsBuilder();
		
		$optionBuilder->setTimeToLive(60*20);
		
		$notificationBuilder = new PayloadNotificationBuilder('Kabera');
		$notificationBuilder->setBody('Notification Received')
							->setSound('default');					
		$dataBuilder = new PayloadDataBuilder();
		
		//$message1 =  Response::json(array('success'=>false,'message'=>$message));	
		
		
		$dataBuilder->addData(['message' => 'Doctor has changed Appointment']);
			
		$option = $optionBuilder->build();
		$notification = $notificationBuilder->build();
		$data = $dataBuilder->build();
		$downstreamResponse = FCM::sendTo($token, $option, $notification, $data);

		$downstreamResponse->numberSuccess();
		$downstreamResponse->numberFailure();
		$downstreamResponse->numberModification();

		// return Array - you must remove all this tokens in your database
		$downstreamResponse->tokensToDelete();

		// return Array (key : oldToken, value : new token - you must change the token in your database)
		$downstreamResponse->tokensToModify();

		// return Array - you should try to resend the message to the tokens in the array
		$downstreamResponse->tokensToRetry();

		// return Array (key:token, value:error) - in production you should remove from your database the tokens
		$downstreamResponse->tokensWithError();
	}
	
	
	
	public function AppointmentNotification($token) 
	{
				
	
		
		//Android Token
		//$token = 'epweoOXplKw:APA91bG_pxWZBE5w4KEK6pFoU9Fgzn8JVpkrbqwV-MawLlaOkAdVMKMOQptYwUyyZ0CcpH825l0pJUptUKopL2mnmLVNZTdFcyOe1Wvq__t4Djcz0j_mtdcpCX4kRrv_tBN_e_3SilK0';

		
		$optionBuilder = new OptionsBuilder();
		
		$optionBuilder->setTimeToLive(60*20);
		
		$notificationBuilder = new PayloadNotificationBuilder('Kabera');
		$notificationBuilder->setBody('Notification Received')
							->setSound('default');					
		$dataBuilder = new PayloadDataBuilder();
		
		//$message1 =  Response::json(array('success'=>false,'message'=>$message));	
		
		
		$dataBuilder->addData(['message' => 'Appointment Notification']);
			
		
			
		$option = $optionBuilder->build();
		$notification = $notificationBuilder->build();
		$data = $dataBuilder->build();
		$downstreamResponse = FCM::sendTo($token, $option, $notification, $data);

		$downstreamResponse->numberSuccess();
		$downstreamResponse->numberFailure();
		$downstreamResponse->numberModification();

		// return Array - you must remove all this tokens in your database
		$downstreamResponse->tokensToDelete();

		// return Array (key : oldToken, value : new token - you must change the token in your database)
		$downstreamResponse->tokensToModify();

		// return Array - you should try to resend the message to the tokens in the array
		$downstreamResponse->tokensToRetry();

		// return Array (key:token, value:error) - in production you should remove from your database the tokens
		$downstreamResponse->tokensWithError();
		
		
	}
	
	public function ChangeAppointmenAssistant($token) 
	{
		$optionBuilder = new OptionsBuilder();
		
		$optionBuilder->setTimeToLive(60*20);
		
		$notificationBuilder = new PayloadNotificationBuilder('Kabera Global');
		$notificationBuilder->setBody('Your Assistant has rescheduled the appointment.')
							->setSound('default');					
		$dataBuilder = new PayloadDataBuilder();
		
		//$message1 =  Response::json(array('success'=>false,'message'=>$message));	
		
		
		$dataBuilder->addData(['message' => 'Your doctor has rescheduled the appointment.']);
			
		
			
		$option = $optionBuilder->build();
		$notification = $notificationBuilder->build();
		$data = $dataBuilder->build();
		$downstreamResponse = FCM::sendTo($token, $option, $notification, $data);

		$downstreamResponse->numberSuccess();
		$downstreamResponse->numberFailure();
		$downstreamResponse->numberModification();

		// return Array - you must remove all this tokens in your database
		$downstreamResponse->tokensToDelete();

		// return Array (key : oldToken, value : new token - you must change the token in your database)
		$downstreamResponse->tokensToModify();

		// return Array - you should try to resend the message to the tokens in the array
		$downstreamResponse->tokensToRetry();

		// return Array (key:token, value:error) - in production you should remove from your database the tokens
		$downstreamResponse->tokensWithError();
		
		
	}
	
	
	
	public function ChangeAppointmentNotification($token = null,$mobileDetail = null) 
	{
		$optionBuilder = new OptionsBuilder();
		
		$optionBuilder->setTimeToLive(60*20);
		
		$notificationBuilder = new PayloadNotificationBuilder('Kabera Global');
		$notificationBuilder->setBody('Your doctor has rescheduled the appointment.')
							->setSound('default');					
		$dataBuilder = new PayloadDataBuilder();
		
		//$message1 =  Response::json(array('success'=>false,'message'=>$message));	
		
		
		$dataBuilder->addData(['message' => 'Your doctor has rescheduled the appointment.','mobileDetail'=>$mobileDetail]);
			
		
			
		$option = $optionBuilder->build();
		$notification = $notificationBuilder->build();
		$data = $dataBuilder->build();
		$downstreamResponse = FCM::sendTo($token, $option, $notification, $data);

		$downstreamResponse->numberSuccess();
		$downstreamResponse->numberFailure();
		$downstreamResponse->numberModification();

		// return Array - you must remove all this tokens in your database
		$downstreamResponse->tokensToDelete();

		// return Array (key : oldToken, value : new token - you must change the token in your database)
		$downstreamResponse->tokensToModify();

		// return Array - you should try to resend the message to the tokens in the array
		$downstreamResponse->tokensToRetry();

		// return Array (key:token, value:error) - in production you should remove from your database the tokens
		$downstreamResponse->tokensWithError();
		
		
	}
	
	
	public function CancelAppointmentNotification($token) 
	{
		//echo $token;
		
		$optionBuilder = new OptionsBuilder();
		
		$optionBuilder->setTimeToLive(60*20);
		
		$notificationBuilder = new PayloadNotificationBuilder('Kabera Global');
		$notificationBuilder->setBody('Appointment Cancel Notification')
							->setSound('default');					
		$dataBuilder = new PayloadDataBuilder();
		
		//$message1 =  Response::json(array('success'=>false,'message'=>$message));	
		
		
		$dataBuilder->addData(['message' => 'Appointment Cancel Notification']);
			
		
			
		$option = $optionBuilder->build();
		$notification = $notificationBuilder->build();
		$data = $dataBuilder->build();
		$downstreamResponse = FCM::sendTo($token, $option, $notification, $data);

		$downstreamResponse->numberSuccess();
		$downstreamResponse->numberFailure();
		$downstreamResponse->numberModification();
//print_r($downstreamResponse); die;

		// return Array - you must remove all this tokens in your database
		$downstreamResponse->tokensToDelete();

		// return Array (key : oldToken, value : new token - you must change the token in your database)
		$downstreamResponse->tokensToModify();

		// return Array - you should try to resend the message to the tokens in the array
		$downstreamResponse->tokensToRetry();

		// return Array (key:token, value:error) - in production you should remove from your database the tokens
		$downstreamResponse->tokensWithError();
		
		
	}
	
	public function ChangeAppointmenCancelAssistant($token) 
	{
		//echo $token;
		$optionBuilder = new OptionsBuilder();
		
		$optionBuilder->setTimeToLive(60*20);
		
		$notificationBuilder = new PayloadNotificationBuilder('Kabera');
		$notificationBuilder->setBody('The Assistant has cancelled the scheduled appointment')
							->setSound('default');					
		$dataBuilder = new PayloadDataBuilder();
		
		//$message1 =  Response::json(array('success'=>false,'message'=>$message));	
		
		
		$dataBuilder->addData(['message' => 'The doctor has cancelled the scheduled appointment']);
			
		
			
		$option = $optionBuilder->build();
		$notification = $notificationBuilder->build();
		$data = $dataBuilder->build();
		$downstreamResponse = FCM::sendTo($token, $option, $notification, $data);

		$downstreamResponse->numberSuccess();
		$downstreamResponse->numberFailure();
		$downstreamResponse->numberModification();
//print_r($downstreamResponse); die;

		// return Array - you must remove all this tokens in your database
		$downstreamResponse->tokensToDelete();

		// return Array (key : oldToken, value : new token - you must change the token in your database)
		$downstreamResponse->tokensToModify();

		// return Array - you should try to resend the message to the tokens in the array
		$downstreamResponse->tokensToRetry();

		// return Array (key:token, value:error) - in production you should remove from your database the tokens
		$downstreamResponse->tokensWithError();
		
	
		
	}
	
	
	
	public function ChangeAppointmenCancelToAssistant($token) 
	{
		//echo $token;
		$optionBuilder = new OptionsBuilder();
		
		$optionBuilder->setTimeToLive(60*20);
		
		$notificationBuilder = new PayloadNotificationBuilder('Kabera');
		$notificationBuilder->setBody('You have successfully cancelled the user scheduled appointment')
							->setSound('default');					
		$dataBuilder = new PayloadDataBuilder();
		
		//$message1 =  Response::json(array('success'=>false,'message'=>$message));	
		
		
		$dataBuilder->addData(['message' => 'You have successfully cancelled the user scheduled appointment']);
			
		
			
		$option = $optionBuilder->build();
		$notification = $notificationBuilder->build();
		$data = $dataBuilder->build();
		$downstreamResponse = FCM::sendTo($token, $option, $notification, $data);

		$downstreamResponse->numberSuccess();
		$downstreamResponse->numberFailure();
		$downstreamResponse->numberModification();
//print_r($downstreamResponse); die;

		// return Array - you must remove all this tokens in your database
		$downstreamResponse->tokensToDelete();

		// return Array (key : oldToken, value : new token - you must change the token in your database)
		$downstreamResponse->tokensToModify();

		// return Array - you should try to resend the message to the tokens in the array
		$downstreamResponse->tokensToRetry();

		// return Array (key:token, value:error) - in production you should remove from your database the tokens
		$downstreamResponse->tokensWithError();
		
	
		
	}
	
	
	
		public function AppointmentChangeForWeb($token = null,$mobileDetail = null) 
	{
		//echo $token;
		$optionBuilder = new OptionsBuilder();
		
		$optionBuilder->setTimeToLive(60*20);
		
		$notificationBuilder = new PayloadNotificationBuilder('Kabera');
		$notificationBuilder->setBody('The doctor has cancelled the scheduled appointment')
							->setSound('default');					
		$dataBuilder = new PayloadDataBuilder();
		
		//$message1 =  Response::json(array('success'=>false,'message'=>$message));	
		
		
		$dataBuilder->addData(['message' => 'The doctor has cancelled the scheduled appointment','mobileDetail'=>$mobileDetail]);
			
		
			
		$option = $optionBuilder->build();
		$notification = $notificationBuilder->build();
		$data = $dataBuilder->build();
		$downstreamResponse = FCM::sendTo($token, $option, $notification, $data);

		$downstreamResponse->numberSuccess();
		$downstreamResponse->numberFailure();
		$downstreamResponse->numberModification();
//print_r($downstreamResponse); die;

		// return Array - you must remove all this tokens in your database
		$downstreamResponse->tokensToDelete();

		// return Array (key : oldToken, value : new token - you must change the token in your database)
		$downstreamResponse->tokensToModify();

		// return Array - you should try to resend the message to the tokens in the array
		$downstreamResponse->tokensToRetry();

		// return Array (key:token, value:error) - in production you should remove from your database the tokens
		$downstreamResponse->tokensWithError();
		
	
		
	}
	
	public function AddAppointmentDoctorComment($token , $mobileDetail)
	{	//echo $token;
		$optionBuilder = new OptionsBuilder();
		
		$optionBuilder->setTimeToLive(60*20);
		
		$notificationBuilder = new PayloadNotificationBuilder('Kabera Glocal');
		$notificationBuilder->setBody('Doctor has added new Comment. Tap to view the details.')
							->setSound('default');		 			
		$dataBuilder = new PayloadDataBuilder();
		
		//$message1 =  Response::json(array('success'=>false,'message'=>$message));	
		
		
		$dataBuilder->addData(['message' => 'New appointment is succesfully added.','mobileDetail'=>$mobileDetail]);
			
		
			
		$option = $optionBuilder->build();
		$notification = $notificationBuilder->build();
		$data = $dataBuilder->build();
		$downstreamResponse = FCM::sendTo($token, $option, $notification, $data);

		$downstreamResponse->numberSuccess();
		$downstreamResponse->numberFailure();
		$downstreamResponse->numberModification();
//print_r($downstreamResponse); die;
		// return Array - you must remove all this tokens in your database
		$downstreamResponse->tokensToDelete();

		// return Array (key : oldToken, value : new token - you must change the token in your database)
		$downstreamResponse->tokensToModify();

		// return Array - you should try to resend the message to the tokens in the array
		$downstreamResponse->tokensToRetry();

		// return Array (key:token, value:error) - in production you should remove from your database the tokens
		$downstreamResponse->tokensWithError();
		
	}
	
	
	public function AddAppointmentAssistantComment($token)
	{	//echo $token;
		$optionBuilder = new OptionsBuilder();
		
		$optionBuilder->setTimeToLive(60*20);
		
		$notificationBuilder = new PayloadNotificationBuilder('Kabera Glocal');
		$notificationBuilder->setBody('Assistant has added new Comment. Tap to view the details.')
							->setSound('default');		 			
		$dataBuilder = new PayloadDataBuilder();
		
		//$message1 =  Response::json(array('success'=>false,'message'=>$message));	
		
		
		$dataBuilder->addData(['message' => 'New appointment is succesfully added.']);
			
		
			
		$option = $optionBuilder->build();
		$notification = $notificationBuilder->build();
		$data = $dataBuilder->build();
		$downstreamResponse = FCM::sendTo($token, $option, $notification, $data);

		$downstreamResponse->numberSuccess();
		$downstreamResponse->numberFailure();
		$downstreamResponse->numberModification();
//print_r($downstreamResponse); die;
		// return Array - you must remove all this tokens in your database
		$downstreamResponse->tokensToDelete();

		// return Array (key : oldToken, value : new token - you must change the token in your database)
		$downstreamResponse->tokensToModify();

		// return Array - you should try to resend the message to the tokens in the array
		$downstreamResponse->tokensToRetry();

		// return Array (key:token, value:error) - in production you should remove from your database the tokens
		$downstreamResponse->tokensWithError();
		
	}
	
	
	
	public function AddAppointmentAssistant($token)
	{	//echo $token;
		$optionBuilder = new OptionsBuilder();
		
		$optionBuilder->setTimeToLive(60*20);
		
		$notificationBuilder = new PayloadNotificationBuilder('Kabera Glocal');
		$notificationBuilder->setBody('Assistant has added new appointment. Tap to view the details.')
							->setSound('default');		 			
		$dataBuilder = new PayloadDataBuilder();
		
		//$message1 =  Response::json(array('success'=>false,'message'=>$message));	
		
		
		$dataBuilder->addData(['message' => 'New appointment is succesfully added.']);
			
		
			
		$option = $optionBuilder->build();
		$notification = $notificationBuilder->build();
		$data = $dataBuilder->build();
		$downstreamResponse = FCM::sendTo($token, $option, $notification, $data);

		$downstreamResponse->numberSuccess();
		$downstreamResponse->numberFailure();
		$downstreamResponse->numberModification();
//print_r($downstreamResponse); die;
		// return Array - you must remove all this tokens in your database
		$downstreamResponse->tokensToDelete();

		// return Array (key : oldToken, value : new token - you must change the token in your database)
		$downstreamResponse->tokensToModify();

		// return Array - you should try to resend the message to the tokens in the array
		$downstreamResponse->tokensToRetry();

		// return Array (key:token, value:error) - in production you should remove from your database the tokens
		$downstreamResponse->tokensWithError();
		
	}
	
	
	
	
	
	public function AddNewAppointmentWeb($token,$mobileDetail)
	{	//echo $token;
		$optionBuilder = new OptionsBuilder();
		
		$optionBuilder->setTimeToLive(60*20);
		
		$notificationBuilder = new PayloadNotificationBuilder('Kabera Glocal');
		$notificationBuilder->setBody('Doctor has added new appointment. Tap to view the details.')
							->setSound('default');		 			
		$dataBuilder = new PayloadDataBuilder();
		
		//$message1 =  Response::json(array('success'=>false,'message'=>$message));	
		
		
		$dataBuilder->addData(['message' => 'New appointment is succesfully added.','dataa'=>$mobileDetail]);
			
		
			
		$option = $optionBuilder->build();
		$notification = $notificationBuilder->build();
		$data = $dataBuilder->build();
		$downstreamResponse = FCM::sendTo($token, $option, $notification, $data);

		$downstreamResponse->numberSuccess();
		$downstreamResponse->numberFailure();
		$downstreamResponse->numberModification();
//print_r($downstreamResponse); die;
		// return Array - you must remove all this tokens in your database
		$downstreamResponse->tokensToDelete();

		// return Array (key : oldToken, value : new token - you must change the token in your database)
		$downstreamResponse->tokensToModify();

		// return Array - you should try to resend the message to the tokens in the array
		$downstreamResponse->tokensToRetry();

		// return Array (key:token, value:error) - in production you should remove from your database the tokens
		$downstreamResponse->tokensWithError();
		
	}
	
	public function AppointmentUpdateWeb($token,$mobileDetail)
	{				
		
		$optionBuilder = new OptionsBuilder();
		
		$optionBuilder->setTimeToLive(60*20);
		
		$notificationBuilder = new PayloadNotificationBuilder('Kabera Glocal');
		$notificationBuilder->setBody('New appointment is succesfully added.')
							->setSound('default');					
		$dataBuilder = new PayloadDataBuilder();
		
		//$message1 =  Response::json(array('success'=>false,'message'=>$message));	
		
		
		$dataBuilder->addData(['message' => 'New appointment is succesfully added.','mobileDetail'=> $mobileDetail]);
			
		
			
		$option = $optionBuilder->build();
		$notification = $notificationBuilder->build();
		$data = $dataBuilder->build();
		$downstreamResponse = FCM::sendTo($token, $option, $notification, $data);

		$downstreamResponse->numberSuccess();
		$downstreamResponse->numberFailure();
		$downstreamResponse->numberModification();
//print_r($downstreamResponse); die;

		// return Array - you must remove all this tokens in your database
		$downstreamResponse->tokensToDelete();

		// return Array (key : oldToken, value : new token - you must change the token in your database)
		$downstreamResponse->tokensToModify();

		// return Array - you should try to resend the message to the tokens in the array
		$downstreamResponse->tokensToRetry();

		// return Array (key:token, value:error) - in production you should remove from your database the tokens
		$downstreamResponse->tokensWithError();
		
	} 
	public function NoteNotificationForDoctor($token)
	{				
		
		$optionBuilder = new OptionsBuilder();
		
		$optionBuilder->setTimeToLive(60*20);
		
		$notificationBuilder = new PayloadNotificationBuilder('Kabera Glocal');
		$notificationBuilder->setBody('Doctor has added new Note. Tap to View')
							->setSound('default');					
		$dataBuilder = new PayloadDataBuilder();
		
		//$message1 =  Response::json(array('success'=>false,'message'=>$message));	
		
		
		$dataBuilder->addData(['message' => 'New note is added successfully']);
			
		
			
		$option = $optionBuilder->build();
		$notification = $notificationBuilder->build();
		$data = $dataBuilder->build();
		$downstreamResponse = FCM::sendTo($token, $option, $notification, $data);

		$downstreamResponse->numberSuccess();
		$downstreamResponse->numberFailure();
		$downstreamResponse->numberModification();
//print_r($downstreamResponse); die;

		// return Array - you must remove all this tokens in your database
		$downstreamResponse->tokensToDelete();

		// return Array (key : oldToken, value : new token - you must change the token in your database)
		$downstreamResponse->tokensToModify();

		// return Array - you should try to resend the message to the tokens in the array
		$downstreamResponse->tokensToRetry();

		// return Array (key:token, value:error) - in production you should remove from your database the tokens
		$downstreamResponse->tokensWithError();
		
	} 
	
	public function NotificatinAssistantNote($token)
	{				
		
		$optionBuilder = new OptionsBuilder();
		
		$optionBuilder->setTimeToLive(60*20);
		
		$notificationBuilder = new PayloadNotificationBuilder('Kabera Glocal');
		$notificationBuilder->setBody('Assistant has added new Note. Tap to View')
							->setSound('default');					
		$dataBuilder = new PayloadDataBuilder();
		
		//$message1 =  Response::json(array('success'=>false,'message'=>$message));	
		
		
		$dataBuilder->addData(['message' => 'New note is added successfully']);
			
		
			
		$option = $optionBuilder->build();
		$notification = $notificationBuilder->build();
		$data = $dataBuilder->build();
		$downstreamResponse = FCM::sendTo($token, $option, $notification, $data);

		$downstreamResponse->numberSuccess();
		$downstreamResponse->numberFailure();
		$downstreamResponse->numberModification();
//print_r($downstreamResponse); die;

		// return Array - you must remove all this tokens in your database
		$downstreamResponse->tokensToDelete();

		// return Array (key : oldToken, value : new token - you must change the token in your database)
		$downstreamResponse->tokensToModify();

		// return Array - you should try to resend the message to the tokens in the array
		$downstreamResponse->tokensToRetry();

		// return Array (key:token, value:error) - in production you should remove from your database the tokens
		$downstreamResponse->tokensWithError();
		
	} 
	
	
	
	
	
	public function NoteNotificationForWebApp($token)
	{				
		
		$optionBuilder = new OptionsBuilder();
		
		$optionBuilder->setTimeToLive(60*20);
		
		$notificationBuilder = new PayloadNotificationBuilder('Kabera Glocal');
		$notificationBuilder->setBody('Doctor has added new Note. Tap to View')
							->setSound('default');					
		$dataBuilder = new PayloadDataBuilder();
		
		//$message1 =  Response::json(array('success'=>false,'message'=>$message));	
		
		
		$dataBuilder->addData(['message' => 'New note is added successfully']);
			
		
			
		$option = $optionBuilder->build();
		$notification = $notificationBuilder->build();
		$data = $dataBuilder->build();
		$downstreamResponse = FCM::sendTo($token, $option, $notification, $data);

		$downstreamResponse->numberSuccess();
		$downstreamResponse->numberFailure();
		$downstreamResponse->numberModification();
//print_r($downstreamResponse); die;

		// return Array - you must remove all this tokens in your database
		$downstreamResponse->tokensToDelete();

		// return Array (key : oldToken, value : new token - you must change the token in your database)
		$downstreamResponse->tokensToModify();

		// return Array - you should try to resend the message to the tokens in the array
		$downstreamResponse->tokensToRetry();

		// return Array (key:token, value:error) - in production you should remove from your database the tokens
		$downstreamResponse->tokensWithError();
		
	} 
	
	public function NotificationIos()
	{
			$token = 'cPJmSrKz7Gc:APA91bG-L3BUj3BEccI2cBdhLaiEh0jYoPdjD-c_WAsNeMnMyezi9wrcmKZaWOXZcHWxUbfWfULoOyPgBhRZnJbwu_a3cSUgwHDKzmEafd-sjJIn8G4YeNd6WAgmjcgShNZdcUq6UXtY';
			
			
			$optionBuilder = new OptionsBuilder();
			$optionBuilder->setTimeToLive(60*20);
			$option = $optionBuilder->build();
			$notificationBuilder = new PayloadNotificationBuilder();
			
			$notificationBuilder->setTitle('Received Notification')
				->setBody('Kabera Global')
				->setSound('default');
			$notification = $notificationBuilder->build();
			$dataBuilder = new PayloadDataBuilder();
			$dataBuilder->addData(['a_data' => 'Received Notification']);
			$data = $dataBuilder->build();
			echo "<pre>";
			print_r($data);
			
			$downstreamResponse = FCM::sendTo($token, $option, $notification, $data);
			$downstreamResponse->numberSuccess();
			$downstreamResponse->numberFailure();
			$downstreamResponse->numberModification();
			echo "<pre>";
			print_r($downstreamResponse);
		}
		
		
		
		
		public function drCommntouser(Request $request){
			$validator = Validator::make($request->all(), [ 
				'doctor_id'	  			=> 'required', 
				'patient_id'	  		=> 'required', 
				//'appointment_id'		=> 'required', 			
			]);
			
			if ($validator->fails()) { 						
				foreach($validator->errors()->toArray() as $key=>$er) {
					$err[] = $er[0];
				}
				return response()->json(['status'=>false,'message'=>$err], $this->errorStatus);            
			}
			$comment_array = [];
			
			$getDetails = NoteCommentData::with('doc_detail')->where('user_id',$request->input('patient_id'))->where('procedure_id',$request->input('procedure_id'))->where('doctor_assistant_ids',$request->input('doctor_id'))->orderby('id','desc')->get();
			if(count($getDetails) != 0)
				{
					if($request->input('type') == "comment")
						{
							$comment_data = NoteCommentData::with('doc_detail')->where('user_id',$request->input('patient_id'))->where('procedure_id',$request->input('procedure_id'))->where('doctor_assistant_ids',$request->input('doctor_id'))->where('type',$request->input('type'))->orderby('id','desc')->get();
							
							if(count($comment_data) != 0)
							{
								foreach($comment_data as $key => $val)
								{
									/** 10 Dec */
									$AssistantProcedureRecords = AssistantProcedureRecords::where('action_id',$val->id)->where('action','appointment_comment')->where('assistant_id','!=','0')->with('user')->first();
									$authName = $val['doc_detail']->name;
									if($AssistantProcedureRecords){
										$authName = $AssistantProcedureRecords->user->name;
									}
									$comment_array[$key]['id'] = $val->id;
									$comment_array[$key]['message'] = $val->comments_notes;
									$comment_array[$key]['date'] = date_format($val->updated_at, 'Y-m-d H:i:s');
									$comment_array[$key]['author_name'] = $authName;
									$comment_array[$key]['type'] = $val->type;
									$comment_array[$key]['visible_to'] = $val->visible_to;
								}
								return response()->json(['status'=>true, 'message'=>'success', 'data' => $comment_array], 200);
							}
							else
							{
							return response()->json(['status'=>false, 'message' => 'No comment available','data' => $comment_array], $this->errorStatus);
							}
						}
						else if($request->input('type') == "note") 
						{
							$note_data = NoteCommentData::with('doc_detail')->where('user_id',$request->input('patient_id'))->where('procedure_id',$request->input('procedure_id'))->where('doctor_assistant_ids',$request->input('doctor_id'))->where('type','note')->orderby('id','desc')->get();
							
							if(!empty($note_data))
							{
								foreach($note_data as $key => $val)
								{
									/** 10 Dec */
									$AssistantProcedureRecords = AssistantProcedureRecords::where('action_id',$val->id)->where('action','appointment_note_add')->where('assistant_id','!=','0')->with('user')->first();
									$authName = $val['doc_detail']->name;
									if($AssistantProcedureRecords){
										$authName = $AssistantProcedureRecords->user->name;
									}
									$comment_array[$key]['id'] 			= $val->id;
									$comment_array[$key]['message'] 	= $val->comments_notes;
									$comment_array[$key]['date'] 		= date_format($val->updated_at, 'Y-m-d H:i:s');
									$comment_array[$key]['author_name'] = $authName;
									$comment_array[$key]['type'] 		= $val->type;
									$comment_array[$key]['visible_to'] = $val->visible_to;
								}
								return response()->json(['status'=>true, 'message'=>'success', 'data' => $comment_array], 200);
							}
							else
							{
								return response()->json(['status'=>false, 'message' => 'No data available','data' => $comment_array], $this->errorStatus);
							}
						}
						else
						{
							$all_data = NoteCommentData::with('doc_detail')->where('user_id',$request->input('patient_id'))->where('doctor_assistant_ids',$request->input('doctor_id'))->where('procedure_id',$request->input('procedure_id'))->orderby('id','desc')->get();
							$comment_array = [];
							if(!empty($all_data))
							{
								foreach($all_data as $key => $val)
								{
									if($val->type == "note"){
										$AssistantProcedureRecords = AssistantProcedureRecords::where('action_id',$val->id)->where('action','appointment_note_add')->where('assistant_id','!=','0')->with('user')->first();
									}else{
										$AssistantProcedureRecords = AssistantProcedureRecords::where('action_id',$val->id)->where('action','appointment_comment')->where('assistant_id','!=','0')->with('user')->first();	
									}
									/** 10 Dec */
									/*$AssistantProcedureRecords = AssistantProcedureRecords::where('action_id',$val->id)->where('action','appointment_note_add')->where('assistant_id','!=','0')->with('user')->first();*/
									$authName = $val['doc_detail']->name;
									if($AssistantProcedureRecords){
										$authName = $AssistantProcedureRecords->user->name;
									}
									$comment_array[$key]['id'] 			= $val->id;
									$comment_array[$key]['message'] 	= $val->comments_notes;
									$comment_array[$key]['date'] 		= date_format($val->updated_at, 'Y-m-d H:i:s');
									$comment_array[$key]['author_name'] = $authName;
									$comment_array[$key]['type'] 		= $val->type;
									$comment_array[$key]['visible_to'] = $val->visible_to;
								}
								return response()->json(['status'=>true, 'message'=>'success', 'data' => $comment_array], 200);
							}
							else
							{
								return response()->json(['status'=>false, 'message' => 'No data available','data' => $comment_array], $this->errorStatus);
							}
						}
				}
			else
			{
				
				return response()->json(['status'=>false, 'message' => 'No data available','data' => $comment_array], $this->errorStatus); 	
			}
	}
	
	public function updateUserVisited(Request $request){
		$AppointmentList = AppointmentList::find($request->appointment_id);
		if($AppointmentList){
			$AppointmentList->is_visited = '1';
			if($AppointmentList->visit_first == '0') {
				$AppointmentList->visit_first = '1';
				//send notification here.
			}
			$AppointmentList->save();
			return response()->json(['status'=>true, 'message'=>'success'], $this->successStatus);
		}else{
			return response()->json(['status'=>false, 'message' => 'No data available'], $this->errorStatus);	
		}
	}
}
