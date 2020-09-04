<?php namespace App\Http\Controllers;

use App\Models\User;
use App\Models\Query;
use App\Models\AdminSettings;
use App\Models\UsersReported;
use App\Models\ImagesReported;
use App\Models\Images;
use App\Models\Stock;
use App\Models\Notifications;
use App\Models\Collections;
use App\Models\CollectionsImages;
use App\Helper;

use Illuminate\Support\Facades\Auth;
use App\Http\Requests;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Image;
use DB;

class UserController extends Controller {
	
	use Traits\userTraits;
	
	public function __construct( AdminSettings $settings) {
		$this->settings = $settings::first();
	}
	
	protected function validator(array $data, $id = null) {
	 	
    	Validator::extend('ascii_only', function($attribute, $value, $parameters){
    		return !preg_match('/[^x00-x7F\-]/i', $value);
		});
		
		// Validate if have one letter
	Validator::extend('letters', function($attribute, $value, $parameters){
    	return preg_match('/[a-zA-Z0-9]/', $value);
	});
	
			return Validator::make($data, [
	        'full_name' => 'required|min:3|max:25',
			'username'  => 'required|min:3|max:15|ascii_only|alpha_dash|letters|unique:pages,slug|unique:reserved,name|unique:users,username,'.$id,
			'email'     => 'required|email|unique:users,email,'.$id,
			'paypal_account' => 'email',
	        'website'   => 'url',
	        'facebook'   => 'url',
	        'twitter'   => 'url',
	        'google'   => 'url',
	        'description' => 'max:200',
	        ]);
		
    }//<--- End Method
    
    public function profile($slug, Request $request) {
    	
		$user      = User::where( 'username','=', $slug )->firstOrFail();
		$title       = e( $user->username ).' - ';
		
	   $images = Query::userImages($user->id);
		
		if( $request->input('page') > $images->lastPage() ) {
			abort('404');
		}
				
		//<<<-- * Redirect the user real name * -->>>
		$uri = request()->path();
		$uriCanonical = $user->username;
		
		if( $uri != $uriCanonical ) {
			return redirect($uriCanonical);
		}
		
 		return view('users.profile', [ 'user' => $user ,'title' => $title, 'images' => $images] );
    }//<--- End Method

      public function followers($slug, Request $request) {
    	
		$user      = User::where( 'username','=', $slug )->firstOrFail();
		$title       = e( $user->username ).' - '.trans('users.followers').' - ';
		
	   $data = User::where('users.status','active')
			->leftjoin('followers', 'users.id', '=', \DB::raw('followers.follower AND followers.status = "1"'))
			->leftjoin('images', 'users.id', '=', \DB::raw('images.user_id AND images.status = "active"'))
			->where('users.status', '=', 'active')
			->where( 'followers.following', $user->id )
			->groupBy('users.id')
			->orderBy('followers.id', 'DESC')
			->select('users.*')
			->paginate(10);
		
		if( $request->input('page') > $data->lastPage() ) {
			abort('404');
		}
				
		//<<<-- * Redirect the user real name * -->>>
		$uri = request()->path();
		$uriCanonical = $user->username.'/followers';
		
		if( $uri != $uriCanonical ) {
			return redirect($uriCanonical);
		}
		
 		return view('users.followers', [ 'title' => $title, 'data' => $data, 'user' => $user] );
    }//<--- End Method
    
    public function following($slug, Request $request) {
    	
		$user      = User::where( 'username','=', $slug )->firstOrFail();
		$title       = e( $user->username ).' - '.trans('users.following').' - ';
		
	   $data = User::where('users.status','active')
			->leftjoin('followers', 'users.id', '=', \DB::raw('followers.following AND followers.status = "1"'))
			->leftjoin('images', 'users.id', '=', \DB::raw('images.user_id AND images.status = "active"'))
			->where('users.status', '=', 'active')
			->where( 'followers.follower', $user->id )
			->groupBy('users.id')
			->orderBy('followers.id', 'DESC')
			->select('users.*')
			->paginate(10);
		
		if( $request->input('page') > $data->lastPage() ) {
			abort('404');
		}
				
		//<<<-- * Redirect the user real name * -->>>
		$uri = request()->path();
		$uriCanonical = $user->username.'/following';
		
		if( $uri != $uriCanonical ) {
			return redirect($uriCanonical);
		}
		
 		return view('users.following', [ 'title' => $title, 'data' => $data, 'user' => $user] );
    }//<--- End Method
    
    public function account()
    {
		return view('users.account');
    }//<--- End Method
	
	public function update_account(Request $request)
    {
       
	   $input = $request->all();
	   $id = Auth::user()->id;
	   	   
	   $validator = $this->validator($input,$id);
	   
	   if ($validator->fails()) {
	        $this->throwValidationException(
	            $request, $validator
	        );
	    }
	   
	   $user = User::find($id);
	   $user->name        = $input['full_name'];
	   $user->email        = trim($input['email']);
	   $user->username = $input['username'];
	   $user->countries_id    = $input['countries_id'];
	   $user->paypal_account = trim($input['paypal_account']);
	   $user->website     = trim(strtolower($input['website']));
	   $user->facebook  = trim(strtolower($input['facebook']));
	   $user->twitter       = trim(strtolower($input['twitter']));
	   $user->google  = trim(strtolower($input['google']));
	   $user->bio = $input['description'];
	   $user->save();
	   
	   \Session::flash('notification',trans('auth.success_update'));
	   
	   return redirect('account');
	   
	}//<--- End Method
	
	public function password()
    {
		return view('users.password');
    }//<--- End Method
    
    public function update_password(Request $request)
    {
       
	   $input = $request->all();
	   $id = Auth::user()->id;
	   
		   $validator = Validator::make($input, [
			'old_password' => 'required|min:6',
	        'password'     => 'required|min:6',        
    	]);
	   
	   if ($validator->fails()) {
	        $this->throwValidationException(
	            $request, $validator
	        );
	    }
	   
	   if (!\Hash::check($input['old_password'], Auth::user()->password) ) {
		    return redirect('account/password')->with( array( 'incorrect_pass' => trans('misc.password_incorrect') ) );
		}
	   	   
	   $user = User::find($id);
	   $user->password  = \Hash::make($input[ "password"] );
	   $user->save();
	   
	   \Session::flash('notification',trans('auth.success_update_password'));
	   
	   return redirect('account/password');
	   
	}//<--- End Method
	
	public function delete()
    {
    	if( Auth::user()->id == 1 ) {
    		return redirect('account');
    	}
		return view('users.delete');
    }//<--- End Method
    
    public function delete_account(){
    
	$id = Auth::user()->id;
	
	$user = User::findOrFail($id);
	 
	 if( $user->id == 1 ) {
	 	return redirect('account');
		exit;
	 }
	 
	 $this->deleteUser($id);
	 
      return redirect('account');
		
    }//<--- End Method
    
    public function notifications() {
    	
		$sql = DB::table('notifications')
			 ->select(DB::raw('
			notifications.id id_noty,
			notifications.type,
			notifications.created_at,
			users.id,
			users.username,
			users.name,
			users.avatar,
			images.id,
			images.title
			'))
			->leftjoin('users', 'users.id', '=', DB::raw('notifications.author'))
			->leftjoin('images', 'images.id', '=', DB::raw('notifications.target AND images.status = "active"'))
			->leftjoin('comments', 'comments.images_id', '=', DB::raw('notifications.target 
			AND comments.user_id = users.id
			AND comments.images_id = images.id
			AND comments.status = "1"
			'))
			->where('notifications.destination', '=',  Auth::user()->id )
			->where('notifications.author', '!=',  Auth::user()->id )
			->where('notifications.trash', '=',  '0' )
			->where('users.status', '=',  'active' )
			->groupBy('notifications.id')
			->orderBy('notifications.id', 'DESC')
			->paginate( 10 );
			
			// Mark seen Notification
			Notifications::where('destination', Auth::user()->id)
			->update(array('status' => '1' ));
			
			return view('users.notifications')->withSql($sql);
    	
    }//<--- End Method
    
    public function notificationsDelete(){
    	
		$notifications = Notifications::where('destination', Auth::user()->id)->get();
		
		if( isset( $notifications ) ){
			foreach($notifications as $notification){
				$notification->delete();
			}
		}
		
		return redirect('notifications');
    	
    }//<--- End Method
    
    public function upload_avatar(Request $request){
    	
	   $id = Auth::user()->id;
	   	   
		$validator = Validator::make($request->all(), [
		'photo'       => 'required|mimes:jpg,gif,png,jpe,jpeg|image_size:>=180,>=180|max:'.$this->settings->file_size_allowed.'',
	    	]);
				   
		   if ($validator->fails()) {
		        return response()->json([
				        'success' => false,
				        'errors' => $validator->getMessageBag()->toArray(),
				    ]);
		    }
		
		// PATHS
		$temp    = 'public/temp/';
	    $path    = 'public/avatar/'; 
		$imgOld      = $path.Auth::user()->avatar;
		
		 //<--- HASFILE PHOTO
	    if( $request->hasFile('photo') )	{
	    	
			$extension  = $request->file('photo')->getClientOriginalExtension();
			$avatar       = strtolower(Auth::user()->username.'-'.Auth::user()->id.time().str_random(10).'.'.$extension );
			
			if( $request->file('photo')->move($temp, $avatar) ) {
				
				set_time_limit(0);
				
				Helper::resizeImageFixed( $temp.$avatar, 180, 180, $temp.$avatar );
				
				// Copy folder
				if ( \File::exists($temp.$avatar) ) {
					/* Avatar */	
					\File::copy($temp.$avatar, $path.$avatar);
					\File::delete($temp.$avatar);
				}//<--- IF FILE EXISTS
				
				//<<<-- Delete old image -->>>/
				if ( \File::exists($imgOld) && $imgOld != $path.'default.jpg' ) {
					\File::delete($temp.$avatar);	
					\File::delete($imgOld);
				}//<--- IF FILE EXISTS #1
				
				// Update Database
				User::where( 'id', Auth::user()->id )->update( array( 'avatar' => $avatar ) );
				
				return response()->json([
				        'success' => true,
				        'avatar' => url($path.$avatar),
				    ]);
					
			}// Move
	    }//<--- HASFILE PHOTO   	
    }//<--- End Method Avatar
    
    public function upload_cover(Request $request){
    	
	   $settings  = AdminSettings::first();
	   $id = Auth::user()->id;
	   	   
		$validator = Validator::make($request->all(), [
		'photo'       => 'required|mimes:jpg,gif,png,jpe,jpeg|image_size:>=800,>=600|max:'.$settings->file_size_allowed.'',
	    	]);
				   
		   if ($validator->fails()) {
		        return response()->json([
				        'success' => false,
				        'errors' => $validator->getMessageBag()->toArray(),
				    ]);
		    }
		
		// PATHS
		$temp    = 'public/temp/';
	    $path    = 'public/cover/'; 
		$imgOld      = $path.Auth::user()->cover;
		
		 //<--- HASFILE PHOTO
	    if( $request->hasFile('photo') )	{
	    	
			$extension  = $request->file('photo')->getClientOriginalExtension();
			$cover       = strtolower(Auth::user()->username.'-'.Auth::user()->id.time().str_random(10).'.'.$extension );
			
			if( $request->file('photo')->move($temp, $cover) ) {
				
				set_time_limit(0);
				
				//=============== Image Large =================//
				$width  = Helper::getWidth( $temp.$cover );
				$height = Helper::getHeight( $temp.$cover );
				$max_width = '1500';
				
				if( $width < $height ) {
					$max_width = '800';
				}
				
				if ( $width > $max_width ) {
					$scale = $max_width / $width;
					$uploaded = Helper::resizeImage( $temp.$cover, $width, $height, $scale, $temp.$cover );
				} else {
					$scale = 1;
					$uploaded = Helper::resizeImage( $temp.$cover, $width, $height, $scale, $temp.$cover );
				}
				
				// Copy folder
				if ( \File::exists($temp.$cover) ) {
					/* Avatar */	
					\File::copy($temp.$cover, $path.$cover);
					\File::delete($temp.$cover);
				}//<--- IF FILE EXISTS
				
				//<<<-- Delete old image -->>>/
				if ( \File::exists($imgOld)  && $imgOld != $path.'cover.jpg'  ) {
					\File::delete($temp.$cover);	
					\File::delete($imgOld);
				}//<--- IF FILE EXISTS #1
				
				// Update Database
				User::where( 'id', Auth::user()->id )->update( array( 'cover' => $cover ) );
				
				return response()->json([
				        'success' => true,
				        'cover' => url($path.$cover),
				    ]);
					
			}// Move
	    }//<--- HASFILE PHOTO   	
    }//<--- End Method Cover
    
    public function userLikes(Request $request) {
    	
		$title       = trans('users.likes').' - ';
		
	   $images = Images::where('images.status','active')
			->leftjoin('likes', 'images.id', '=', \DB::raw('likes.images_id AND likes.status = "1"'))
			->where( 'likes.user_id', Auth::user()->id )
			->groupBy('images.id')
			->orderBy('likes.id', 'DESC')
			->select('images.*')
			->paginate($this->settings->result_request);
		
		if( $request->input('page') > $images->lastPage() ) {
			abort('404');
		}
		
 		return view('users.likes', [ 'title' => $title, 'images' => $images] );
    }//<--- End Method
    
    public function followingFeed(Request $request) {
    	
		$title       = trans('misc.feed').' - ';
		
	   $images = Images::leftjoin('followers', 'images.user_id', '=', \DB::raw('followers.following AND followers.status = "1"'))
			->where('images.status', 'active')
			->where('followers.follower', '=', Auth::user()->id )
			->groupBy('images.id')
			->orderBy( 'images.id', 'desc' )
			->select('images.*')
			->paginate( $this->settings->result_request );
		
		if( $request->input('page') > $images->lastPage() ) {
			abort('404');
		}
		
 		return view('users.feed', [ 'title' => $title, 'images' => $images] );
    }//<--- End Method
    
    public function collections($slug, Request $request) {
    	
		$user      = User::where( 'username','=', $slug )->firstOrFail();
		$title       = e( $user->username ).' - '.trans('misc.collections').' - ';
		
		if( Auth::check() ) {
			$AuthId = Auth::user()->id;
		} else {
			$AuthId = 0;
		}
		
	   $data = $user->collections()->where( 'user_id', $user->id )
	   ->where('type','public')
		->orWhere('user_id', $AuthId)
		->where( 'user_id', $user->id )
		->where('type','private')
		->orderBy('id','desc')
		->paginate( $this->settings->result_request );
		
		if( $request->input('page') > $data->lastPage() ) {
			abort('404');
		}
				
		//<<<-- * Redirect the user real name * -->>>
		$uri = request()->path();
		$uriCanonical = $user->username.'/collections';
		
		if( $uri != $uriCanonical ) {
			return redirect($uriCanonical);
		}
		
 		return view('users.collections', [ 'title' => $title, 'data' => $data, 'user' => $user] );
    }//<--- End Method
    
    public function collectionDetail(Request $request) {
 	   
	   $collectionData = Collections::where('id', $request->id)->firstOrFail();
	   
	   $user               = User::find( $collectionData->user_id );
	   
	   $images = CollectionsImages::where('collections_images.collections_id',$request->id)
		->join('images', 'images.id', '=', 'collections_images.images_id' )
		->join('collections', 'collections.id', '=', 'collections_images.collections_id' )
		->join('users', 'users.id', '=', 'collections.user_id' )
		->where('images.status','active')
		->where('users.status','active')
		->orderBy('images.id','desc')
		->select('images.*')
		->paginate( $this->settings->result_request );
			
		$title = trans('misc.collection').' - '.$collectionData->title.' -';
		
		if( $request->input('page') > $images->lastPage() ) {
			abort('404');
		}
		
		$slugUrl = str_slug( $collectionData->title );
		
		if( $slugUrl  == '' ) {
				$slugUrl  = '';
			} else {
				$slugUrl  = '/'.$slugUrl;
			}
		
		//<<<-- * Redirect the user real name * -->>>
		$uri = request()->path();
		$uriCanonical = $user->username.'/collection/'.$collectionData->id.$slugUrl;
		
		if( $uri != $uriCanonical ) {
			return redirect($uriCanonical);
		}
		
 		return view('users.collection-detail', [ 'title' => $title, 'images' => $images, 'collectionData' => $collectionData, 'user' => $user] );
    }//<--- End Method
    
    public function report(Request $request){
		
		$data = UsersReported::firstOrNew(['user_id' => Auth::user()->id, 'id_reported' => $request->id]);
		
		if( $data->exists ) {
			\Session::flash('noty_error','error');
			return redirect()->back();
		} else {
			
			$data->reason = $request->reason;
			$data->save();
			\Session::flash('noty_success','success');
			return redirect()->back();
		}
		
	}//<--- End Method
	
	public function photosPending(Request $request) {
    	
		$images = Images::where('user_id',Auth::user()->id)->where('status','pending')->paginate( $this->settings->result_request );
		
		if( $request->input('page') > $images->lastPage() ) {
			abort('404');
		}
		
 		return view('users.photos-pending', [ 'images' => $images] );
    }//<--- End Method

}
