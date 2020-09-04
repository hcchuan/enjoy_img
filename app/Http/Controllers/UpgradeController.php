<?php namespace App\Http\Controllers;

use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\Auth;
use App\Http\Requests;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Models\Categories;
use App\Models\User;
use App\Models\AdminSettings;
use App\Models\Images;
use App\Models\Collections;

class UpgradeController extends Controller {

	public function __construct( AdminSettings $settings, Images $images, Collections $collections, User $user, Categories $categories) {
	 $this->user         = $user::first();
	 $this->settings     = $settings::first();
	 $this->images       = $images::first();
	 $this->collections  = $collections::first();
	 $this->categories   = $categories::first();
 }

	public function update($version) {

		$upgradeDone = '<h2 style="text-align:center; margin-top: 30px; font-family: Arial, san-serif;color: #4BBA0B;">'.trans('admin.upgrade_done').' <a style="text-decoration: none; color: #F50;" href="'.url('/').'">'.trans('error.go_home').'</a></h2>';

		//<<---- Version 1.3 ----->>

		if( $version == '1.3' ) {

			if( isset($this->settings->google_adsense_index) ) {
				return redirect('/');
			} else {

				Schema::table('admin_settings', function($table){
					$table->text('google_adsense_index')->after('min_width_height_image');
				 });

				return $upgradeDone;
			}

		}//<<---- Version 1.3 ----->>

	}

}
