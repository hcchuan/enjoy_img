<?php namespace App\Http\Controllers;

use Illuminate\Support\Facades\Input as Input;
use Illuminate\Support\Facades\Auth;
use App\Http\Requests;
use App\Models\User;
use App\Models\Collections;
use App\Models\UsersReported;
use App\Models\Stock;
use App\Models\Images;
use App\Models\ImagesReported;
use App\Models\Notifications;
use App\Models\Followers;
use App\Models\Downloads;
use App\Models\Like;
use App\Models\Replies;
use App\Models\Comments;
use App\Models\CollectionsImages;
use App\Models\Pages;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class AdminUserController extends Controller {
	
	use Traits\userTraits;
	
	 protected function validator(array $data, $id = null) {
	 	
    	Validator::extend('ascii_only', function($attribute, $value, $parameters){
    		return !preg_match('/[^x00-x7F\-]/i', $value);
		});

			return Validator::make($data, [
	        	'email'     => 'required|email|max:255|unique:users,id,'.$id,
	        ]);
		
    }
	 
	 /**
   * Display a listing of the resource.
   *
   * @return Response
   */
	 public function index() {
	 	
		$query = Input::get('q');
		
		if( $query != '' && strlen( $query ) > 2 ) {
		 	$data = User::where('name', 'LIKE', '%'.$query.'%')
			->orWhere('username', 'LIKE', '%'.$query.'%')
		 	->orderBy('id','desc')->paginate(20);
		 } else {
		 	$data = User::orderBy('id','desc')->paginate(20);
		 }
		
    	return view('admin.members', ['data' => $data,'query' => $query]);
	 }
	
	/**
   * Show the form for editing the specified resource.
   *
   * @param  int  $id
   * @return Response
   */
	public function edit($id) {
		
		$data = User::findOrFail($id);
		
		if( $data->id == 1 || $data->id == Auth::user()->id ) {
			\Session::flash('info_message', trans('admin.user_no_edit'));
			return redirect('panel/admin/members');
		}
    	return view('admin.edit-member')->withData($data);
	
	}//<--- End Method
	
	/**
   * Update the specified resource in storage.
   *
   * @param  int  $id
   * @return Response
   */
	public function update($id, Request $request) {
    	
    $user = User::findOrFail($id);
		
	$input = $request->all();
		
	     $validator = $this->validator($input,$id);
	
	    if ($validator->fails()) {
	        $this->throwValidationException(
	            $request, $validator
	        );
	    }
		
    $user->fill($input)->save();

    \Session::flash('success_message', trans('admin.success_update'));

    return redirect('panel/admin/members');
	
	}//<--- End Method
	
	
	/**
   * Remove the specified resource from storage.
   *
   * @param  int  $id
   * @return Response
   */
      
	public function destroy($id){
	  
	 $user = User::findOrFail($id);
	 
	 if( $user->id == 1 || $user->id == Auth::user()->id ) {
	 	return redirect('panel/admin/members');
		exit;
	 }
	 
	 $this->deleteUser($id);
	 
      return redirect('panel/admin/members');
	  
	}//<--- End Method


}
