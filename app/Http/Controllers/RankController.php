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
use Monolog\Logger;
use Monolog\Handler\StreamHandler;

class RankController extends Controller
{
	public function rank($slug='beauty',$time_type=0) {
        $time_type_list = ['1'=>'日榜','2'=>'周榜','3'=>'月榜','9'=>'季度榜','10'=>'半年榜','4'=>'年榜'];
        $time_type_list = GetCommonArr($time_type_list);

		$data = Query::categoryImages($slug,$time_type);
        $data['time_type_list']=$time_type_list;
        $data['time_type']=$time_type;
        //exit(json_encode($data));
        return view('rank.rank')->with($data);
	}
}
