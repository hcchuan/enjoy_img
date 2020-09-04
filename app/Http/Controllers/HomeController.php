<?php namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Input as Input;
use App\Http\Requests;
use App\Models\User;
use App\Models\Images;
use Illuminate\Http\Request;
use App\Models\AdminSettings;
use App\Models\Categories;
use App\Models\Query;
use App\Models\Collections;


class HomeController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Http\Response
     */
    public function index() {
		
		$categories = Categories::where('mode','on')->orderBy('name')->paginate(12);
		$images     = Query::latestImages();
		
		return view('index.home', ['categories' => $categories, 'images' => $images]);
		
	}// End Method
	
	public function getVerifyAccount( $confirmation_code ) {
		

		if( !Auth::check() ) {
		$user = User::where( 'activation_code', $confirmation_code )->where('status','pending')->first();
		
		if( $user ) {
			
			$update = User::where( 'activation_code', $confirmation_code )
			->where('status','pending')
			->update( array( 'status' => 'active', 'activation_code' => '' ) );
			

			Auth::loginUsingId($user->id);
			
			 return redirect('/')
					->with([
						'success_verify' => true,
					]);
			} else {
			return redirect('/')
					->with([
						'error_verify' => true,
					]);
			}
		} else {
			 return redirect('/');
		}
	}// End Method
	
	public function getSearch() {

		$images = Query::searchImages();
		
		//<--- * If $page not exists * ---->
		/*if( $page > $images->lastPage() ) {
			App::abort('404');
		}*/
		
		//<--- * If $q is empty or is minus to 1 * ---->
		if( Input::get('q') == '' || strlen( Input::get('q') ) <= 1 ){
			return redirect('/');
		}
		
		return view('default.search')->with($images);
	}// End Method
	
	public function latest() {
		
		$images = Query::latestImages();
		
		return view('index.latest', ['images' => $images]);
		
	}// End Method 
	
	public function featured() {
		
		$images = Query::featuredImages();
		
		return view('index.featured', ['images' => $images]);
		
	}// End Method 
	

	public function popular() {
		
		$images = Query::popularImages();
		
		return view('index.popular', ['images' => $images]);
		
	}// End Method
	
	public function commented() {
		
		$images = Query::commentedImages();
		
		return view('index.commented', ['images' => $images]);
		
	}// End Method
	
	public function viewed() {
		
		$images = Query::viewedImages();
		
		return view('index.viewed', ['images' => $images]);
		
	}// End Method
	
	public function downloads() {
		
		$images = Query::downloadsImages();
		
		return view('index.downloads', ['images' => $images]);
		
	}// End Method
	
	public function category($slug) {
		
		$images = Query::categoryImages($slug);
		
		return view('default.category')->with($images);
		
	}// End Method
	
	public function tags($slug) {
	 
	 if( strlen( $slug ) > 1 ) {
		$settings = AdminSettings::first();
		
		$images = Query::tagsImages($slug);
		
		return view('default.tags-show')->with($images);
		} else {
			abort('404');
		}
		
	}// End Method
	
	public function cameras($slug) {
	
	if( strlen( $slug ) > 3 ) {	
		$settings = AdminSettings::first();
		
		$images = Query::camerasImages($slug);
		
		return view('default.cameras')->with($images);
		
		} else {
			abort('404');
		}
	}// End Method

	public function colors($slug) {
		
		if( strlen( $slug ) == 6 ) {
			
			$settings = AdminSettings::first();
			
			$images = Query::colorsImages($slug);
			
			return view('default.colors')->with($images);
			
		} else {
			abort('404');
		}		
	}// End Method
	
	public function collections(Request $request) {
    	
		$settings = AdminSettings::first();
		
		$title       = trans('misc.collections').' - ';
		
	   $data = Collections::has('collection_images')
	   ->where('type','public')
		->orderBy('id','desc')
		->paginate( $settings->result_request );
		
		if( $request->input('page') > $data->lastPage() ) {
			abort('404');
		}
		
 		return view('default.collections', [ 'title' => $title, 'data' => $data] );
    }//<--- End Method

}
