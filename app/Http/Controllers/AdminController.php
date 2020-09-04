<?php namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Input as Input;
use App\Models\User;
use App\Models\AdminSettings;
use App\Models\Notifications;
use App\Models\Categories;
use App\Models\UsersReported;
use App\Models\ImagesReported;
use App\Models\Images;
use App\Models\Stock;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

use Image;

class AdminController extends Controller {

	public function __construct( AdminSettings $settings) {
		$this->settings = $settings::first();
	}
	// START
	public function admin() {

		return view('admin.dashboard');

	}//<--- END METHOD

	// START
	public function categories() {

		$data      = Categories::orderBy('name')->get();

		return view('admin.categories')->withData($data);

	}//<--- END METHOD

	public function addCategories() {

		return view('admin.add-categories');

	}//<--- END METHOD

	public function storeCategories(Request $request) {

		$temp            = 'public/temp/'; // Temp
	    $path            = 'public/img-category/'; // Path General

		Validator::extend('ascii_only', function($attribute, $value, $parameters){
    		return !preg_match('/[^x00-x7F\-]/i', $value);
		});

		$rules = array(
            'name'        => 'required',
	        'slug'        => 'required|ascii_only|unique:categories',
	        'thumbnail'   => 'mimes:jpg,gif,png,jpe,jpeg|image_size:>=457,>=359',
        );

		$this->validate($request, $rules);

		if( $request->hasFile('thumbnail') )	{

		$extension              = $request->file('thumbnail')->getClientOriginalExtension();
		$type_mime_shot   = $request->file('thumbnail')->getMimeType();
		$sizeFile                 = $request->file('thumbnail')->getSize();
		$thumbnail              = $request->slug.'-'.str_random(32).'.'.$extension;

		if( $request->file('thumbnail')->move($temp, $thumbnail) ) {

			$image = Image::make($temp.$thumbnail);

			if(  $image->width() == 457 && $image->height() == 359 ) {

					\File::copy($temp.$thumbnail, $path.$thumbnail);
					\File::delete($temp.$thumbnail);

			} else {
				$image->fit(457, 359)->save($temp.$thumbnail);

				\File::copy($temp.$thumbnail, $path.$thumbnail);
				\File::delete($temp.$thumbnail);
			}

			}// End File
		} // HasFile

		else {
			$thumbnail = '';
		}

		$sql              = New Categories;
		$sql->name        = trim($request->name);
		$sql->slug        = strtolower($request->slug);
		$sql->thumbnail = $thumbnail;
		$sql->mode        = $request->mode;
		$sql->save();

		\Session::flash('success_message', trans('admin.success_add_category'));

    	return redirect('panel/admin/categories');

	}//<--- END METHOD

	public function editCategories($id) {

		$categories        = Categories::find( $id );

		return view('admin.edit-categories')->with('categories',$categories);

	}//<--- END METHOD

	public function updateCategories( Request $request ) {


		$categories  = Categories::find( $request->id );
		$temp            = 'public/temp/'; // Temp
	    $path            = 'public/img-category/'; // Path General

	    if( !isset($categories) ) {
			return redirect('panel/admin/categories');
		}

		Validator::extend('ascii_only', function($attribute, $value, $parameters){
    		return !preg_match('/[^x00-x7F\-]/i', $value);
		});

		$rules = array(
            'name'        => 'required',
	        'slug'        => 'required|ascii_only|unique:categories,slug,'.$request->id,
	        'thumbnail'   => 'mimes:jpg,gif,png,jpe,jpeg|image_size:>=457,>=359',
	     );

		$this->validate($request, $rules);

		if( $request->hasFile('thumbnail') )	{

		$extension              = $request->file('thumbnail')->getClientOriginalExtension();
		$type_mime_shot   = $request->file('thumbnail')->getMimeType();
		$sizeFile                 = $request->file('thumbnail')->getSize();
		$thumbnail              = $request->slug.'-'.str_random(32).'.'.$extension;

		if( $request->file('thumbnail')->move($temp, $thumbnail) ) {

			$image = Image::make($temp.$thumbnail);

			if(  $image->width() == 457 && $image->height() == 359 ) {

					\File::copy($temp.$thumbnail, $path.$thumbnail);
					\File::delete($temp.$thumbnail);

			} else {
				$image->fit(457, 359)->save($temp.$thumbnail);

				\File::copy($temp.$thumbnail, $path.$thumbnail);
				\File::delete($temp.$thumbnail);
			}

			// Delete Old Image
			\File::delete($path.$categories->thumbnail);

			}// End File
		} // HasFile
		else {
			$thumbnail = $categories->image;
		}

		// UPDATE CATEGORY
		$categories->name        = $request->name;
		$categories->slug        = strtolower($request->slug);
		$categories->thumbnail  = $thumbnail;
		$categories->mode        = $request->mode;
		$categories->save();

		\Session::flash('success_message', trans('misc.success_update'));

    	return redirect('panel/admin/categories');

	}//<--- END METHOD

	public function deleteCategories($id){

		$categories        = Categories::find( $id );
		$thumbnail          = 'public/img-category/'.$categories->thumbnail; // Path General

		if( !isset($categories) || $categories->id == 1 ) {
			return redirect('panel/admin/categories');
		} else {

			$images_category   = Images::where('categories_id',$id)->get();

			// Delete Category
			$categories->delete();

			// Delete Thumbnail
			if ( \File::exists($thumbnail) ) {
				\File::delete($thumbnail);
			}//<--- IF FILE EXISTS

			//Update Categories Images
			if( isset( $images_category ) ) {
				foreach ($images_category as $key ) {
					$key->categories_id = 1;
					$key->save();
				}
			}

			return redirect('panel/admin/categories');
		}
	}//<--- END METHOD

	public function settings() {

		return view('admin.settings');

	}//<--- END METHOD

	public function saveSettings(Request $request) {

		$rules = array(
            'title'            => 'required',
	        'welcome_text' 	   => 'required',
	        'welcome_subtitle' => 'required',
	        'keywords'         => 'required',
	        'description'      => 'required',
	        'email_no_reply'   => 'required',
	        'email_admin'      => 'required',
        );

		$this->validate($request, $rules);

		$sql                      = AdminSettings::first();
		$sql->title               = $request->title;
		$sql->welcome_text        = $request->welcome_text;
		$sql->welcome_subtitle    = $request->welcome_subtitle;
		$sql->keywords            = $request->keywords;
		$sql->description         = $request->description;
		$sql->email_no_reply      = $request->email_no_reply;
		$sql->email_admin         = $request->email_admin;
		$sql->captcha             = $request->captcha;
		$sql->registration_active = $request->registration_active;
		$sql->email_verification  = $request->email_verification;
		$sql->facebook_login  = $request->facebook_login;
		$sql->google_ads_index    = $request->google_ads_index;
		$sql->save();

		\Session::flash('success_message', trans('admin.success_update'));

    	return redirect('panel/admin/settings');

	}//<--- END METHOD

	public function settingsLimits() {

		return view('admin.limits');

	}//<--- END METHOD

	public function saveSettingsLimits(Request $request) {


		$sql                      = AdminSettings::first();
		$sql->result_request      = $request->result_request;
		$sql->limit_upload_user   = $request->limit_upload_user;
		$sql->message_length      = $request->message_length;
		$sql->comment_length      = $request->comment_length;
		$sql->file_size_allowed   = $request->file_size_allowed;
		$sql->auto_approve_images = $request->auto_approve_images;
		$sql->downloads           = $request->downloads;
		$sql->tags_limit          = $request->tags_limit;
		$sql->description_length  = $request->description_length;
		$sql->min_width_height_image = $request->min_width_height_image;

		$sql->save();

		\Session::flash('success_message', trans('admin.success_update'));

    	return redirect('panel/admin/settings/limits');

	}//<--- END METHOD

	public function members_reported() {

		$data = UsersReported::orderBy('id','DESC')->get();

		return view('admin.members_reported')->withData($data);

	}//<--- END METHOD

	public function delete_members_reported(Request $request) {

		$report = UsersReported::find($request->id);

		if( isset( $report ) ) {
			$report->delete();
		}

		return redirect('panel/admin/members-reported');

	}//<--- END METHOD

	public function images_reported() {

		$data = ImagesReported::orderBy('id','DESC')->get();

		//dd($data);

		return view('admin.images_reported')->withData($data);

	}//<--- END METHOD

	public function delete_images_reported(Request $request) {

		$report = ImagesReported::find($request->id);

		if( isset( $report ) ) {
			$report->delete();
		}

		return redirect('panel/admin/images-reported');

	}//<--- END METHOD

	public function images() {

		$query = Input::get('q');
		$sort = Input::get('sort');
		$pagination = 15;

		$data = Images::orderBy('id','desc')->paginate($pagination);

		// Search
		if( isset( $query ) ) {
		 	$data = Images::where('title', 'LIKE', '%'.$query.'%')
			->orWhere('tags', 'LIKE', '%'.$query.'%')
		 	->orderBy('id','desc')->paginate($pagination);
		 }

		// Sort
		if( isset( $sort ) && $sort == 'title' ) {
			$data = Images::orderBy('title','asc')->paginate($pagination);
		}

		if( isset( $sort ) && $sort == 'pending' ) {
			$data = Images::where('status','pending')->paginate($pagination);
		}

		if( isset( $sort ) && $sort == 'downloads' ) {
			$data = Images::join('downloads', 'images.id', '=', 'downloads.images_id')
					->groupBy('downloads.images_id')
					->orderBy( \DB::raw('COUNT(downloads.images_id)'), 'desc' )
					->select('images.*')
					->paginate( $pagination );
		}

		if( isset( $sort ) && $sort == 'likes' ) {
			$data = Images::join('likes', function($join){
				$join->on('likes.images_id', '=', 'images.id')->where('likes.status', '=', '1' );
			})
					->groupBy('likes.images_id')
					->orderBy( \DB::raw('COUNT(likes.images_id)'), 'desc' )
					->select('images.*')
					->paginate( $pagination );
		}

		return view('admin.images', ['data' => $data,'query' => $query, 'sort' => $sort ]);
	}//<--- End Method

	public function delete_image(Request $request) {

		//<<<<---------------------------------------------

		$image = Images::find($request->id);

		// Delete Notification
		$notifications = Notifications::where('destination',$request->id)
			->where('type', '2')
			->orWhere('destination',$request->id)
			->where('type', '3')
			->orWhere('destination',$request->id)
			->where('type', '6')
			->get();

		if(  isset( $notifications ) ){
			foreach($notifications as $notification){
				$notification->delete();
			}
		}

		//<---- ALL RESOLUTIONS IMAGES
		$stocks = Stock::where('images_id', '=', $request->id)->get();

		foreach($stocks as $stock){

			$stock_path = 'public/uploads/'.$stock->type.'/'.$stock->name;

			// Delete Stock
			if ( \File::exists($stock_path) ) {
				\File::delete($stock_path);
			}//<--- IF FILE EXISTS

			$stock->delete();

		}//<--- End foreach

		$preview_image = 'public/uploads/preview/'.$image->preview;
		$thumbnail     = 'public/uploads/thumbnail/'.$image->thumbnail;

		// Delete preview
		if ( \File::exists($preview_image) ) {
			\File::delete($preview_image);
		}//<--- IF FILE EXISTS

		// Delete thumbnail
		if ( \File::exists($thumbnail) ) {
			\File::delete($thumbnail);
		}//<--- IF FILE EXISTS

		$image->delete();

		return redirect('panel/admin/images');

	}//<--- End Method

	public function edit_image($id) {

		$data = Images::findOrFail($id);

		return view('admin.edit-image', ['data' => $data ]);

	}//<--- End Method

	public function update_image(Request $request) {

		$sql = Images::find($request->id);

		 $rules = array(
            'title'       => 'required|min:3|max:30',
            'description' => 'min:2|max:'.$this->settings->description_length.'',
	        'tags'        => 'required',

        );

		if( $request->featured == 'yes' && $sql->featured == 'no' ) {
			$featuredDate = \Carbon\Carbon::now();
		} elseif( $request->featured == 'yes' && $sql->featured == 'yes' ) {
			$featuredDate = $sql->featured_date;
		} else {
			$featuredDate = '';
		}

		$this->validate($request, $rules);

	    $sql->title         = $request->title;
		$sql->description   = $request->description;
		$sql->tags          = strtolower($request->tags);
		$sql->categories_id = $request->categories_id;
		$sql->status        = $request->status;
		$sql->featured      = $request->featured;
		$sql->featured_date = $featuredDate;


		$sql->save();

	    \Session::flash('success_message', trans('admin.success_update'));

	    return redirect('panel/admin/images');
	}//<--- End Method

	public function profiles_social(){
		return view('admin.profiles-social');
	}//<--- End Method

	public function update_profiles_social(Request $request) {

		$sql = AdminSettings::find(1);

		$rules = array(
            'twitter'    => 'url',
            'facebook'   => 'url',
            'googleplus' => 'url',
            'linkedin'   => 'url',
            'instagram'  => 'url',
        );

		$this->validate($request, $rules);

	    $sql->twitter       = $request->twitter;
		$sql->facebook      = $request->facebook;
		$sql->googleplus    = $request->googleplus;
		$sql->linkedin      = $request->linkedin;
		$sql->instagram     = $request->instagram;

		$sql->save();

	    \Session::flash('success_message', trans('admin.success_update'));

	    return redirect('panel/admin/profiles-social');
	}//<--- End Method

	public function google() {

		return view('admin.google');

	}//<--- END METHOD

	public function update_google(Request $request) {

		$sql = AdminSettings::first();

			$sql->google_adsense_index   = $request->google_adsense_index;
	    $sql->google_adsense   = $request->google_adsense;
		  $sql->google_analytics = $request->google_analytics;

		$sql->save();

	    \Session::flash('success_message', trans('admin.success_update'));

	    return redirect('panel/admin/google');
	}//<--- End Method


}
