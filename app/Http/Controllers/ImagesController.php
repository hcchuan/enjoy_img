<?php namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;
use App\Http\Requests;
use App\Models\User;
use App\Models\Images;
use App\Models\ImagesReported;
use App\Models\Stock;
use App\Models\AdminSettings;
use App\Models\Downloads;
use App\Models\Notifications;
use App\Models\Visits;
use App\Models\CollectionsImages;
use App\Helper;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use League\ColorExtractor\Color;
use League\ColorExtractor\ColorExtractor;
use League\ColorExtractor\Palette;
use Image;


class ImagesController extends Controller {

	 public function __construct( AdminSettings $settings, Request $request) {
		$this->settings = $settings::first();
		$this->request = $request;
	}

	 protected function validator(array $data, $id = null) {

    	Validator::extend('ascii_only', function($attribute, $value, $parameters){
    		return !preg_match('/[^x00-x7F\-]/i', $value);
		});

		$sizeAllowed = $this->settings->file_size_allowed * 1024;

		$dimensions = explode('x',$this->settings->min_width_height_image);

		$messages = array (
		'photo.required' => trans('misc.please_select_image'),
        "photo.max"   => trans('misc.max_size').' '.Helper::formatBytes( $sizeAllowed, 1 ),
	);

		// Create Rules
		if( $id == null ) {
			return Validator::make($data, [
			 'photo'       => 'required|mimes:jpg,gif,png,jpe,jpeg|image_size:>='.$dimensions[0].',>='.$dimensions[1].'|max:'.$this->settings->file_size_allowed.'',
        	'title'       => 'required|min:3|max:30',
            'description' => 'min:2|max:'.$this->settings->description_length.'',
	        'tags'        => 'required',
        ], $messages);

		// Update Rules
		} else {
			return Validator::make($data, [
	        	'title'       => 'required|min:3|max:30',
	            'description' => 'min:2|max:'.$this->settings->description_length.'',
		        'tags'        => 'required',
	        ]);
		}

    }

	 /**
   * Display a listing of the resource.
   *
   * @return Response
   */
	 public function index() {

	 	$data = Images::all();

    	return view('admin.images')->withData($data);
	 }

	 /**
   * Store a newly created resource in storage.
   *
   * @return Response
   */
	 public function create( Request $request ) {


		 if( Auth::guest() ) {
		 	return response()->json([
			        'session_null' => true,
			        'success' => false,
			    ]);
		 }

		// PATHS
		$temp                   = 'public/temp/';
	    $path_preview       = 'public/uploads/preview/';
		$path_thumbnail    = 'public/uploads/thumbnail/';
		$path_small          = 'public/uploads/small/';
		$path_medium      = 'public/uploads/medium/';
		$path_large           = 'public/uploads/large/';
		$watermarkSource = 'public/img/watermark.png';

		 $input = $request->all();

 	//dd($input);
	     $validator = $this->validator($input);

	     if ($validator->fails()) {
	        return response()->json([
			        'success' => false,
			        'errors' => $validator->getMessageBag()->toArray(),
			    ]);
	    } //<-- Validator

	    //<--- HASFILE PHOTO
	    if( $request->hasFile('photo') )	{

		$extension       = $request->file('photo')->getClientOriginalExtension();
		$originalName    = Helper::fileNameOriginal($request->file('photo')->getClientOriginalName());
		$type_mime_img   = $request->file('photo')->getMimeType();
		$sizeFile        = $request->file('photo')->getSize();
		$large           = strtolower( Auth::user()->id.time().str_random(100).'.'.$extension );
		$medium          = strtolower( Auth::user()->id.time().str_random(100).'.'.$extension );
		$small           = strtolower( Auth::user()->id.time().str_random(100).'.'.$extension );
		$preview         = strtolower( str_slug( $request->title, '-').'-'.Auth::user()->id.time().str_random(10).'.'.$extension );
		$thumbnail       = strtolower( str_slug( $request->title, '-').'-'.Auth::user()->id.time().str_random(10).'.'.$extension );


		if( $request->file('photo')->move($temp, $large) ) {

				set_time_limit(0);

				 $original = $temp.$large;
				 $width    = Helper::getWidth( $original );
				 $height   = Helper::getHeight( $original );



				if ( $width > $height ) {

					if( $width > 1280) : $_scale = 1280; else: $_scale = 900; endif;

					// PREVIEW
					$scale    = 850 / $width;
					$uploaded = Helper::resizeImage( $original, $width, $height, $scale, $temp.$preview );

					// Medium
					$scaleM   = $_scale / $width;
					$uploaded = Helper::resizeImage( $original, $width, $height, $scaleM, $temp.$medium );

					// Small
					$scaleS   = 640 / $width;
					$uploaded = Helper::resizeImage( $original, $width, $height, $scaleS, $temp.$small );

					// Thumbnail
					$scaleT   = 280 / $width;
					$uploaded = Helper::resizeImage( $original, $width, $height, $scaleT, $temp.$thumbnail );

				} else {

					if( $width > 1280) : $_scale = 960; else: $_scale = 800; endif;

					// PREVIEW
					$scale    = 480 / $width;
					$uploaded = Helper::resizeImage( $original, $width, $height, $scale, $temp.$preview );

					// Medium
					$scaleM   = $_scale / $width;
					$uploaded = Helper::resizeImage( $original, $width, $height, $scaleM, $temp.$medium );

					// Small
					$scaleS   = 480 / $width;
					$uploaded = Helper::resizeImage( $original, $width, $height, $scaleS, $temp.$small );

					// Thumbnail
					$scaleT   = 190 / $width;
					$uploaded = Helper::resizeImage( $original, $width, $height, $scaleT, $temp.$thumbnail );

				}

				// Insert Watermark
				/*Image::make($temp.$preview)
				->insert('public/img/watermark.png','center')
				->save($temp.$preview)
				->destroy();*/

				Helper::watermark( $temp.$preview, $watermarkSource );

			}// End File

		} //<----- HASFILE PHOTO

		 if( !empty( $request->description ) ) {
					$description = Helper::checkTextDb($request->description);
				} else {
					$description = '';
				}

		// Exif Read Data
		$exif_data = @exif_read_data($temp.$large, 0, true);

		if( isset($exif_data['EXIF']['ISOSpeedRatings'][0]) ) {
			$ISO = 'ISO '.$exif_data['EXIF']['ISOSpeedRatings'][0];
		}

		if( isset($exif_data['EXIF']['ExposureTime']) ) {
			$ExposureTime = $exif_data['EXIF']['ExposureTime'].'s';
		}

		if( isset($exif_data['EXIF']['FocalLength']) ) {
			$FocalLength = round($exif_data['EXIF']['FocalLength'], 1).'mm';
		}

		if( isset($exif_data['COMPUTED']['ApertureFNumber']) ) {
			$ApertureFNumber = $exif_data['COMPUTED']['ApertureFNumber'];
		}

		if( !isset($FocalLength) ) {
			$FocalLength = '';
		}

		if( !isset($ExposureTime) ) {
			$ExposureTime = '';
		}

		if( !isset($ISO) ) {
			$ISO = '';
		}

		if( !isset($ApertureFNumber) ) {
			$ApertureFNumber = '';
		}

		$exif = $FocalLength.' '.$ApertureFNumber.' '.$ExposureTime. ' '.$ISO;

		if( isset($exif_data['IFD0']['Model']) ) {
			$camera = $exif_data['IFD0']['Model'];
		} else {
			$camera = '';
		}

		//$exif['EXIF']['ISOSpeedRatings'][0] --> ISO 400
		//$exif['EXIF']['ExposureTime'] ---> 1/25s
		//$exif['EXIF']['FocalLength'] ----> 29.1mm round($exif['EXIF']['FocalLength'], 1)
		//$exif['IFD0']['Model']
		//$exif['EXIF']['DateTimeOriginal'] App\Helper::formatDate($exif['EXIF']['DateTimeOriginal'])
		//$exif['COMPUTED']['ApertureFNumber'] ----> f/5.6

		//=========== Colors
		$palette = Palette::fromFilename( url('public/temp/').'/'.$preview );

		$extractor = new ColorExtractor($palette);

		// it defines an extract method which return the most “representative” colors
		$colors = $extractor->extract(5);

		// $palette is an iterator on colors sorted by pixel count
		foreach($colors as $color) {

			$_color[]  = trim(Color::fromIntToHex($color), '#') ;
		}

           $colors_image = implode( ',', $_color);

		//App\Helper::formatBytes(filesize($file), 1)
		//list($w, $h) = getimagesize($file);

		if( $this->settings->auto_approve_images == 'on' ) {
			$status = 'active';
		} else {
			$status = 'pending';
		}

		$token_id = str_random(200);

		$sql = new Images;
		$sql->thumbnail            = $thumbnail;
		$sql->preview              = $preview;
		$sql->title                = trim($request->title);
		$sql->description          = trim($description);
		$sql->categories_id        = $request->categories_id;
		$sql->user_id              = Auth::user()->id;
		$sql->status               = $status;
		$sql->token_id             = $token_id;
		$sql->tags                 = strtolower($request->tags);
		$sql->extension            = strtolower($extension);
		$sql->colors               = $colors_image;
		$sql->exif                 = trim($exif);
		$sql->camera               = $camera;
		$sql->how_use_image        = $request->how_use_image;
		$sql->attribution_required = $request->attribution_required;
		$sql->original_name        = $originalName;
		$sql->save();

		// ID INSERT
		$imageID = $sql->id;

		// INSERT STOCK IMAGES

		$lResolution = list($w, $h) = getimagesize($temp.$large);
		$lSize     = Helper::formatBytes(filesize($temp.$large), 1);

		$mResolution = list($_w, $_h) = getimagesize($temp.$medium);
		$mSize     = Helper::formatBytes(filesize($temp.$medium), 1);

		$smallResolution = list($__w, $__h) = getimagesize($temp.$small);
		$smallSize       = Helper::formatBytes(filesize($temp.$small), 1);



	$stockImages = [
			['name' => $large, 'type' => 'large', 'resolution' => $w.'x'.$h, 'size' => $lSize ],
			['name' => $medium, 'type' => 'medium', 'resolution' => $_w.'x'.$_h, 'size' => $mSize ],
			['name' => $small, 'type' => 'small', 'resolution' => $__w.'x'.$__h, 'size' => $smallSize ],
		];

		foreach ($stockImages as $key) {

			$stock             = new Stock;
			$stock->images_id  = $imageID;
			$stock->name       = $key['name'];
			$stock->type       = $key['type'];
			$stock->extension  = $extension;
			$stock->resolution = $key['resolution'];
			$stock->size       = $key['size'];
			$stock->token      = $token_id;
			$stock->save();

		}

		 	\File::copy($temp.$preview, $path_preview.$preview);
			\File::delete($temp.$preview);

			\File::copy($temp.$thumbnail, $path_thumbnail.$thumbnail);
			\File::delete($temp.$thumbnail);

			\File::copy($temp.$small, $path_small.$small);
			\File::delete($temp.$small);

			\File::copy($temp.$medium, $path_medium.$medium );
			\File::delete($temp.$medium );

			\File::copy($temp.$large, $path_large.$large  );
			\File::delete($temp.$large  );

		//\Session::flash('success_message',trans('admin.success_add'));

		return response()->json([
			        'success' => true,
			        'target' => url('photo',$imageID),
			    ]);

	}//<--- End Method

	/**
   * Display the specified resource.
   *
   * @param  int  $id
   * @return Response
   */
	public function show($id, $slug = null ) {

		$response = Images::findOrFail($id);

		if( Auth::check() && $response->user_id != Auth::user()->id && $response->status == 'pending' && Auth::user()->role != 'admin' ) {
			abort(404);
		} else if(Auth::guest() && $response->status == 'pending'){
			abort(404);
		}

		$uri = $this->request->path();

		if( str_slug( $response->title ) == '' ) {

				$slugUrl  = '';
			} else {
				$slugUrl  = '/'.str_slug( $response->title );
			}

			$url_image = 'photo/'.$response->id.$slugUrl;

			//<<<-- * Redirect the user real page * -->>>
			$uriImage     =  $this->request->path();
			$uriCanonical = $url_image;

			if( $uriImage != $uriCanonical ) {
				return redirect($uriCanonical);
			}

			//<--------- * Visits * ---------->
			$user_IP = request()->ip();
			$date = time();

			if( Auth::check() ) {
				// SELECT IF YOU REGISTERED AND VISITED THE PUBLICATION
				$visitCheckUser = $response->visits()->where('user_id',Auth::user()->id)->first();

				if( !$visitCheckUser && Auth::user()->id != $response->user()->id ) {
					$visit = new Visits;
					$visit->images_id = $response->id;
					$visit->user_id  = Auth::user()->id;
					$visit->ip       = $user_IP;
					$visit->save();
				}

			} else {

				// IF YOU SELECT "UNREGISTERED" ALREADY VISITED THE PUBLICATION
				$visitCheckGuest = $response->visits()->where('user_id',0)
				->where('ip',$user_IP)
				->orderBy('date','desc')
				->first();

			if( $visitCheckGuest )	{
				  $dateGuest = strtotime( $visitCheckGuest->date  ) + ( 7200 ); // 2 Hours

			}

				if( empty( $visitCheckGuest->ip )  ) {
				   	$visit = new Visits;
					$visit->images_id = $response->id;
					$visit->user_id  = 0;
					$visit->ip       = $user_IP;
					$visit->save();
			   } else if( $dateGuest < $date ) {
			   		$visit = new Visits;
					$visit->images_id = $response->id;
					$visit->user_id  = 0;
					$visit->ip       = $user_IP;
					$visit->save();
			   }

			}//<--------- * Visits * ---------->

    	return view('images.show')->withResponse($response);

	}//<--- End Method

	/**
   * Show the form for editing the specified resource.
   *
   * @param  int  $id
   * @return Response
   */
	public function edit($id) {

		$data = Images::findOrFail($id);

		if( $data->user_id != Auth::user()->id ) {
			abort('404');
		}

    	return view('images.edit')->withData($data);

	}//<--- End Method

	/**
   * Update the specified resource in storage.
   *
   * @param  int  $id
   * @return Response
   */
	public function update(Request $request) {

    $image = Images::findOrFail($request->id);

	if( $image->user_id != Auth::user()->id ) {
		return redirect('/');
	}

	$input = $request->all();

	     $validator = $this->validator($input,$request->id);

	    if ($validator->fails()) {
	        $this->throwValidationException(
	            $request, $validator
	        );
	    }

    $image->fill($input)->save();

    \Session::flash('success_message', trans('admin.success_update'));

    return redirect('edit/photo/'.$image->id);

	}//<--- End Method


	/**
   * Remove the specified resource from storage.
   *
   * @param  int  $id
   * @return Response
   */
	public function destroy(Request $request){

	  $image = Images::find($request->id);

	  if( $image->user_id != Auth::user()->id ) {
		return redirect('/');
	}

		// Delete Notification
		$notifications = Notifications::where('destination',$request->id)
			->where('type', '2')
			->orWhere('destination',$request->id)
			->where('type', '3')
			->orWhere('destination',$request->id)
			->where('type', '4')
			->get();

		if(  isset( $notifications ) ){
			foreach($notifications as $notification){
				$notification->delete();
			}
		}

		// Collections Images
	$collectionsImages = CollectionsImages::where('images_id', '=', $request->id)->get();
	 if( isset( $collectionsImages ) ){
			foreach($collectionsImages as $collectionsImage){
				$collectionsImage->delete();
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

      return redirect(Auth::user()->username);

	}//<--- End Method

	public function download( $token_id, $type) {

		$image = Images::where('token_id',$token_id)->firstOrFail();

		if( isset( $image ) ) {
			$getImage = Stock::where('images_id',$image->id)->where('type','=',$type)->firstOrFail();
		}

		if( isset( $getImage ) ) {

			// Download Check User
			$user_IP = request()->ip();
			$date = time();

			if( Auth::check() ){

			$downloadCheckUser = $image->downloads()->where('user_id', Auth::user()->id)->first();

				if( !$downloadCheckUser && Auth::user()->id != $image->user()->id ) {
					$download            = new Downloads;
					$download->images_id = $image->id;
					$download->user_id   = Auth::user()->id;
					$download->ip        = $user_IP;
					$download->save();
				}
			}// Auth check

			else {

				// IF YOU SELECT "UNREGISTERED" ALREADY DOWNLOAD THE IMAGE
				$downloadCheckUser = $image->downloads()->where('user_id', 0)
				->where('ip',$user_IP)
				->orderBy('date','desc')
				->first();

			if( $downloadCheckUser )	{
				  $dateGuest = strtotime( $downloadCheckUser->date  ) + ( 7200 ); // 2 Hours

			}

				if( empty( $downloadCheckUser->ip )  ) {
				   	$download            = new Downloads;
					$download->images_id = $image->id;
					$download->user_id   = 0;
					$download->ip        = $user_IP;
					$download->save();
			   } else if( $dateGuest < $date ) {
			   		$download            = new Downloads;
					$download->images_id = $image->id;
					$download->user_id   = 0;
					$download->ip        = $user_IP;
					$download->save();
			   }

			}//<--------- * Visits * ---------->
			//<<<<---/ Download Check User

			$pathFile = 'public/uploads/'.$type.'/'.$getImage->name;
			return response()->download($pathFile, $image->title.' - '.$getImage->resolution.'.'.$image->extension);
		}
	}//<--- End Method

	public function report(Request $request){

		$data = ImagesReported::firstOrNew(['user_id' => Auth::user()->id, 'image_id' => $request->id]);

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


}
