<?php namespace App\Models;

use Illuminate\Database\Eloquent\Model;

use Illuminate\Support\Facades\Input as Input;
use App\Models\Images;
use App\Models\Stock;
use App\Models\User;
use App\Models\AdminSettings;
use App\Models\Categories;


class Query extends Model {

	protected $guarded = array();
	public $timestamps = false;


	public static function users() {

	 $settings = AdminSettings::first();

	 $page      = Input::get('page');
	 $sort      =  Input::get('sort');
	 $location  =  Input::get('location');

	 if( $sort == 'latest' ) {
	 	$sortQuery = 'users.id';
	 } else if( $sort == 'photos'  ) {
	 	$sortQuery = 'COUNT(images.id)';
	 } else {
	 	$sortQuery = 'COUNT(followers.id)';
	 }

	$data = User::where('users.status','active');

  // lOCATION
	if( isset($location) && $location != '' ) {
		$data->where( 'users.countries_id', $location );
	}

 // PHOTOS
	if( $sort == 'photos' ) {
		$data->leftjoin('images', 'users.id', '=', \DB::raw('images.user_id AND images.status = "active"'));
	}

// POPULAR
	if( $sort == 'popular' || !$sort  ) {
			$data->leftjoin('followers', 'users.id', '=', \DB::raw('followers.following AND followers.status = "1"') );
		}

		$query = 	$data->where('users.status', '=', 'active')
		->groupBy('users.id')
			->orderBy(\DB::raw($sortQuery), 'DESC')
			->orderBy('users.id', 'ASC')
			->select('users.*')
			->paginate($settings->result_request);

	return ['data' => $query, 'page' => $page, 'sort' => $sort, 'location' => $location];

	}//<---- End Method

	//Search
	public static function searchImages() {

		$settings = AdminSettings::first();

		$q = trim(Input::get('q'));

		$page = Input::get('page');

		$images = Images::where( 'title','LIKE', '%'.$q.'%' )
		->where('status', 'active' )
		->orWhere( 'tags','LIKE', '%'.$q.'%' )
		->where('status', 'active' )
		->groupBy('id')
		->orderBy('id', 'desc' )
		->paginate( $settings->result_request );

		$title = trans('misc.result_of').' '. $q .' - ';

		$total = $images->total();

		return ['images' => $images, 'page' => $page, 'title' => $title, 'total' => $total, 'q' => $q];

	}//<---- End Method

	public static function latestImages() {

		$settings = AdminSettings::first();

		$data = Images::where('status','active')->orderBy('id','DESC')->paginate($settings->result_request);

		return $data;

	}//<---- End Method

	public static function featuredImages() {

		$settings = AdminSettings::first();

		$data = Images::where('featured', 'yes')->where('status','active')->orderBy('featured_date','DESC')->paginate($settings->result_request);

		return $data;

	}//<---- End Method

	public static function popularImages() {

		$settings = AdminSettings::first();

		$data = Images::join('likes', function($join){
				$join->on('likes.images_id', '=', 'images.id')->where('likes.status', '=', '1' )->where('images.status','active');
			})
					->groupBy('likes.images_id')
					->orderBy( \DB::raw('COUNT(likes.images_id)'), 'desc' )
					->select('images.*')
					->paginate( $settings->result_request );

		return $data;

	}//<---- End Method

	public static function commentedImages() {

		$settings = AdminSettings::first();

		$data = Images::join('comments', 'images.id', '=', 'comments.images_id')
					->where('images.status','active')
					->groupBy('comments.images_id')
					->orderBy( \DB::raw('COUNT(comments.images_id)'), 'desc' )
					->select('images.*')
					->paginate( $settings->result_request );

		return $data;

	}//<---- End Method

	public static function viewedImages() {

		$settings = AdminSettings::first();

		$data = Images::join('visits', 'images.id', '=', 'visits.images_id')
					->where('images.status','active')
					->groupBy('visits.images_id')
					->orderBy( \DB::raw('COUNT(visits.images_id)'), 'desc' )
					->select('images.*')
					->paginate( $settings->result_request );

		return $data;

	}//<---- End Method

	public static function downloadsImages() {

		$settings = AdminSettings::first();

		$data = Images::join('downloads', 'images.id', '=', 'downloads.images_id')
					->where('images.status','active')
					->groupBy('downloads.images_id')
					->orderBy( \DB::raw('COUNT(downloads.images_id)'), 'desc' )
					->select('images.*')
					->paginate( $settings->result_request );

		return $data;

	}//<---- End Method

	public static function categoryImages($slug) {

		$settings = AdminSettings::first();

		 $category = Categories::where('slug','=',$slug)->first();
	  	 $images   = Images::where('status', 'active')->where('categories_id',$category->id)->orderBy('id','DESC')->paginate($settings->result_request);

		return ['images' => $images, 'category' => $category];

	}//<---- End Method

	public static function tagsImages($tags) {

		$settings = AdminSettings::first();

		 $page = Input::get('page');

		$images = Images::where( 'tags','LIKE', '%'.$tags.'%' )
		->where('status', 'active' )
		->groupBy('id')
		->orderBy('id', 'desc' )
		->paginate( $settings->result_request );

		$title = trans('misc.tags').' - '. ucfirst( $tags );

		$total = $images->total();

		return ['images' => $images, 'title' => $title, 'total' => $total, 'tags' => $tags];

	}//<---- End Method

	public static function camerasImages($camera) {

		$settings = AdminSettings::first();

		 $page = Input::get('page');

		$images = Images::where( 'camera','LIKE', '%'.$camera.'%' )
		->where('status', 'active' )
		->groupBy('id')
		->orderBy('id', 'desc' )
		->paginate( $settings->result_request );

		$title = trans('misc.photos_taken_with').' '. ucfirst( $camera );

		$total = $images->total();

		return ['images' => $images, 'title' => $title, 'total' => $total, 'camera' => $camera];

	}//<---- End Method

	public static function colorsImages($colors) {

		$settings = AdminSettings::first();

		 $page = Input::get('page');

		$images = Images::where( 'colors','LIKE', '%'.$colors.'%' )
		->where('status', 'active' )
		->groupBy('id')
		->orderBy('id', 'desc' )
		->paginate( $settings->result_request );

		$title = trans('misc.colors').' #'.$colors;

		$total = $images->total();

		return ['images' => $images, 'title' => $title, 'total' => $total, 'colors' => $colors];

	}//<---- End Method

	public static function userImages($id){

		$settings = AdminSettings::first();

		$images      = Images::where('user_id',$id)
		->where('status', 'active' )
		->groupBy('id')
		->orderBy('id', 'desc' )
		->paginate( $settings->result_request );

		return $images;

	}//<---- End Method

}
