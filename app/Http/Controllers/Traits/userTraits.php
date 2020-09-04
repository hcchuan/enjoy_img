<?php namespace App\Http\Controllers\Traits;

use Illuminate\Support\Facades\Input as Input;
use Illuminate\Support\Facades\Auth;
use App\Http\Requests;
use App\Models\AdminSettings;
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

trait userTraits {

    public function deleteUser($id) {

		$user = User::findOrFail($id);

		// Collections
	$collections = Collections::where('user_id', '=', $id)->get();

	if( isset( $collections ) ){
		foreach($collections as $collection){
			$collection->delete();

			// Collections
		$collectionsImages = CollectionsImages::where('images_id', '=', $collection->id)->get();
		 if( isset( $collectionsImages ) ){
				foreach($collectionsImages as $collectionsImage){
					$collectionsImage->delete();
				}
			}

		}
	}

	// Comments Delete
	$comments = Comments::where('user_id', '=', $id)->get();

	if( isset( $comments ) ){
		foreach($comments as $comment){
			$comment->delete();
		}
	}

	// Replies
	$replies = Replies::where('user_id', '=', $id)->get();

	if( isset( $replies ) ){
		foreach($replies as $replie){
			$replies->delete();
		}
	}

	// Likes
	$likes = Like::where('user_id', '=', $id)->get();
	if( isset( $likes ) ){
		foreach($likes as $like){
			$like->delete();
		}
	}

	// Downloads
	$downloads = Downloads::where('user_id', '=', $id)->get();
	if( isset( $downloads ) ){
		foreach($downloads as $download){
			$download->delete();
		}
	}

	// Followers
	$followers = Followers::where( 'follower', $id )->orwhere('following',$id)->get();
	if( isset( $followers ) ){
		foreach($followers as $follower){
			$follower->delete();
		}
	}

	// Delete Notification
	$notifications = Notifications::where('author',$id)
	->orWhere('destination', $id)
	->get();

	if(  isset( $notifications ) ){
		foreach($notifications as $notification){
			$notification->delete();
		}
	}

	// Images Reported
	$images_reporteds = ImagesReported::where('user_id', '=', $id)->get();

	if(  isset( $images_reporteds ) ){
		foreach ($images_reporteds as $images_reported ) {
				$images_reported->delete();
			}// End
	}

	// Images
    $images = Images::where('user_id', '=', $id)->get();

	if(isset( $images )){
		foreach($images as $image){

			//<---- ALL RESOLUTIONS IMAGES
			$stocks = Stock::where('images_id', '=', $image->id)->get();

			foreach($stocks as $stock){

				$stock_path = 'public/uploads/'.$stock->type.'/'.$stock->name;

				// Delete Stock
				if ( \File::exists($stock_path) ) {
					\File::delete($stock_path);
				}//<--- IF FILE EXISTS

				$stock->delete();
			}

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
		}
	}// End

	// User Reported
	$users_reporteds = UsersReported::where('user_id', '=', $id)->orWhere('id_reported', '=', $id)->get();

	if(  isset( $users_reporteds ) ){
		foreach ($users_reporteds as $users_reported ) {
				$users_reported->delete();
			}// End
	}

	//<<<-- Delete Avatar -->>>/
	$fileAvatar    = 'public/avatar/'.$user->avatar;

		if ( \File::exists($fileAvatar) && $user->avatar != 'default.jpg' ) {
			\File::delete($fileAvatar);
		}//<--- IF FILE EXISTS

	//<<<-- Delete Cover -->>>/
	$fileCover  = 'public/cover/'.$user->cover;

		if ( \File::exists($fileCover) && $user->cover != 'cover.jpg' ) {
			\File::delete($fileCover);
		}//<--- IF FILE EXISTS

	  // User Delete
      $user->delete();

    }//<-- End Method
}
