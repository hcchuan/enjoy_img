<?php
if( Auth::check() ) {

	// FOLLOW ACTIVE
 	$followActive = App\Models\Followers::where( 'follower', Auth::user()->id )
 	->where('following',$response->user()->id)
	->where('status', '1')
 	->first();

       if( $followActive ) {
       	  $textFollow   = trans('users.following');
		  $icoFollow    = '-ok';
		  $activeFollow = 'btnFollowActive';
       } else {
       		$textFollow   = trans('users.follow');
		    $icoFollow    = '-plus';
			$activeFollow = '';
       }

	   // LIKE ACTIVE
	   $likeActive = App\Models\Like::where( 'user_id', Auth::user()->id )
	   ->where('images_id',$response->id)
	   ->where('status','1')
	   ->first();

       if( $likeActive ) {
       	  $textLike   = trans('misc.unlike');
		  $icoLike    = 'fa fa-heart';
		  $statusLike = 'active';
       } else {
       		$textLike   = trans('misc.like');
		    $icoLike    = 'fa fa-heart-o';
			$statusLike = '';
       }

	   // ADD TO COLLECTION
	   $collections = App\Models\Collections::where('user_id',Auth::user()->id)->orderBy('id','asc')->get();

 }//<<<<---- *** END AUTH ***

	// All Images resolutions
	$stockImages = $response->stock;

	// Similar Photos
	$arrayTags  = explode(",",$response->tags);
	$countTags = count( $arrayTags );

	$images = App\Models\Images::where('categories_id',$response->categories_id)
	->whereStatus('active')
	->where(function($query) use ($arrayTags,$countTags){
		for( $k = 0; $k < $countTags; ++$k ){
			 $query->orWhere('tags', 'LIKE', '%'.$arrayTags[$k].'%');
		}
	} )
	->where('id', '<>',$response->id)
	->orderByRaw('RAND()')
	->take(5)
	->get();

	// Comments
	$comments_sql = $response->comments()->where('status','1')->orderBy('date', 'desc')->paginate(10);

 ?>
 @extends('app')

@section('title'){{ $response->title.' - '.trans_choice('misc.photos_plural', 1 ).' #'.$response->id.' - ' }}@endsection

@section('description_custom'){{ $response->title.' - '.trans_choice('misc.photos_plural', 1 ).' #'.$response->id.' - ' }} @if( $response->description != '' ){{ App\Helper::removeLineBreak( e( $response->description ) ).' - ' }}@endif @endsection

@section('keywords_custom'){{$response->tags .','}}@endsection

@section('css')
<link href="{{ asset('public/plugins/iCheck/all.css') }}" rel="stylesheet" type="text/css" />

<meta property="og:site_name" content="{{$settings->title}}"/>
<meta property="og:url" content="{{url("photo/$response->id").'/'.str_slug($response->title)}}"/>
<meta property="og:image" content="{{ asset('public/uploads/preview/') }}/{{$response->preview}}"/>

<meta property="og:title" content="{{ $response->title }}"/>
<meta property="og:description" content="{{ App\Helper::removeLineBreak( e( $response->description ) ) }}"/>

<meta name="twitter:card" content="summary_large_image" />
<meta name="twitter:image" content="{{ asset('public/uploads/preview/') }}/{{$response->preview}}" />
<meta name="twitter:title" content="{{ $response->title }}" />
<meta name="twitter:description" content="{{ App\Helper::removeLineBreak( e( $response->description ) ) }}"/>

@endsection

@section('content')

@if( Auth::check() )
<div class="modal fade" id="collections" tabindex="-1" role="dialog" aria-hidden="true">
     		<div class="modal-dialog modal-sm">
     			<div class="modal-content">
     				<div class="modal-header">
				        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				        <h4 class="modal-title text-center" id="myModalLabel">
				        	<strong>{{ trans('misc.add_collection') }}</strong>
				        	</h4>
				     </div><!-- Modal header -->

			<div class="modal-body listWrap">

			<div class="collectionsData">
				@if( $collections->count() != 0 )
				    @foreach ( $collections as $collection )

				     <?php

				     $collectionImages = $collection->collection_images->where('images_id',$response->id)->where('collections_id',$collection->id)->first();

					 if( !empty( $collectionImages ) ) {
						$checked = 'checked="checked"';
						} else {
							$checked = null;
						}
				     ?>
				     	<div class="radio margin-bottom-15">
							<label class="checkbox-inline padding-zero addImageCollection text-overflow" data-image-id="{{$response->id}}" data-collection-id="{{$collection->id}}">
							<input class="no-show" name="checked" {{$checked}} type="checkbox" value="true">
							<span class="input-sm">{{$collection->title}}</span>
							</label>
						</div>

				    @endforeach



				    @else
				    	<div class="btn-block text-center no-collections">{{ trans('misc.no_have_collections') }}</div>
				    @endif

          </div><!-- collection data -->

          <small class="btn-block note-add @if( $collections->count() == 0 ) display-none @endif">* {{ trans('misc.note_add_collections') }}</small>

          <span class="label label-success display-none btn-block response-text"></span>

                 <!-- form start -->
			    <form method="POST" action="" enctype="multipart/form-data" id="addCollectionForm">
			    	<input type="hidden" name="_token" value="{{ csrf_token() }}">
			    	<input type="hidden" name="image_id" value="{{ $response->id }}">

                 <!-- Start Form Group -->
                    <div class="form-group">
                      <label>{{ trans('admin.title') }}</label>
                        <input type="text" value="" name="title" id="titleCollection" class="form-control" placeholder="{{ trans('admin.title') }}">
                    </div><!-- /.form-group-->

                    <!-- Start form-group -->
                    <div class="form-group">

                      	<div class="radio">
                        <label class="padding-zero">
                          <input type="radio" name="type" checked="checked" value="public">
                          {{ trans('misc.public') }}
                        </label>
                      </div>

                      <div class="radio">
                        <label class="padding-zero">
                          <input type="radio" name="type" value="private">
                          {{ trans('misc.private') }}
                        </label>
                      </div>

                    </div><!-- /.form-group -->

                    <!-- Alert -->
                    <div class="alert alert-danger alert-small display-none" id="dangerAlert">
							<ul class="list-unstyled" id="showErrors"></ul>
						</div><!-- Alert -->

                 <div class="btn-block text-center">
                 	<button type="submit" class="btn btn-sm btn-success" id="addCollection">{{ trans('misc.create_collection') }} <i class="fa fa-plus"></i></button>
                 </div>

                    </form>

				      </div><!-- Modal body -->
     				</div><!-- Modal content -->
     			</div><!-- Modal dialog -->
     		</div><!-- Modal -->
     		@endif

<div class="container margin-bottom-40 padding-top-40">

<!-- Col MD -->
<div class="col-md-9">

	@if( $response->status == 'pending' )
	<div class="alert alert-warning" role="alert">
			<i class="glyphicon glyphicon-info-sign myicon-right"></i>  {{ trans('misc.pending_approval') }}
		</div>
		@endif

	<div class="text-center margin-bottom-20">
		<img class="img-responsive" style="display: inline-block;" src="{{url('public/uploads/preview',$response->preview)}}" />
	</div>

	<h1 class="class-montserrat title-image none-overflow">
	 {{ $response->title }}
	</h1>

 <hr />

@if( $response->description != '' )
<p class="description">
	{{ $response->description }}
</p>
@endif

<!-- Start Block -->
<div class="btn-block margin-bottom-20">
	<h3>{{trans('misc.tags')}}</h3>
	<?php
	   $tags = explode(',', $response->tags);
	   $count_tags = count( $tags );
	   ?>

	   @for( $i = 0; $i < $count_tags; ++$i )
	   <a href="{{url('tags',$tags[$i]) }}" class="btn btn-danger tags font-default btn-sm">
	   	{{ $tags[$i] }}
	   </a>
	   @endfor
</div><!-- End Block -->

@if( $images->count() != 0 )
<!-- Start Block -->
<div class="btn-block margin-bottom-20 po">
	<h3>{{trans('misc.similar_photos')}}</h3>
	<div id="imagesFlex" class="flex-images btn-block margin-bottom-40">
		@include('includes.images')
		</div>
</div><!-- End Block -->
@endif

<!-- Start Block -->
<div class="btn-block margin-bottom-20">
	<h3>{{trans('misc.comments')}}(<span id="totalComments">{{number_format( $response->comments()->count() )}}</span>)</h3>


	@if( Auth::check() && $response->status == 'pending' )
	<div class="alert alert-warning" role="alert">
			<i class="glyphicon glyphicon-info-sign myicon-right"></i>  {{ trans('misc.pending_approval') }}
		</div>
		@endif

@if( Auth::check() && $response->status == 'active' )


	<div class="media">
            <span class="pull-left">
                <img alt="Image" src="{{ asset('public/avatar')}}/{{ Auth::user()->avatar }}" class="media-object img-circle" width="50">
            </span>

            <div class="media-body">
            <form action="{{ url('comment/store') }}" method="post" id="commentsForm">
            	<div class="form-group text-form">
            		<input type="hidden" name="image_id" value="{{ $response->id }}" />
            		<input type="hidden" name="_token" value="{{ csrf_token() }}">
            		<textarea name="comment" rows="3" required="required" min="2" id="comments" class="form-control input-sm textarea-comments mentions-textarea"></textarea>
            	</div>

            	<!-- Alert -->
                    <div class="alert alert-danger alert-small display-none" id="dangerAlertComments">
							<ul class="list-unstyled" id="showErrorsComments"></ul>
						</div><!-- Alert -->

                <div class="form-group ">
                	<button type="submit" class="btn btn-success btn-lg custom-rounded" id="commentSend">{{ trans('auth.send') }} <i class="fa fa-paper-plane"></i></button>
                	<small class="pull-right text-muted">{{$settings->comment_length}}</small>
                </div>
                </form>
            </div><!-- media body -->
 </div><!-- media -->
 <hr />
 @endif


	<div class="gridComments" id="gridComments" style="padding-top: 15px;">
		@include('includes.comments')
	</div><!-- gridComments -->

	 @if( $comments_sql->count() == 0 )

   <div class="btn-block text-center noComments">
	    	<i class="icon icon-MessageRight ico-no-result"></i>
	    </div>

    		<h3 class="margin-top-none text-center no-result row-margin-20 noComments">
	    	{{ trans('misc.no_comments_yet') }}
	    	</h3>
	    	@endif

	 @if( Auth::guest() )
	 <hr />
	 	<div class="alert alert-loggin text-center alert-custom" role="alert">
	 		{{ trans('auth.logged_in_comments') }}

	 	@if( $settings->registration_active == '1' )
	 		<a href="{{url('register')}}" class="btn btn-xs btn-success">{{ trans('auth.sign_up') }}</a>
	 	@endif

	 	<a href="{{url('login')}}">{{ trans('auth.login') }}</a>

	 	</div>
	 @endif

</div><!-- End Block -->

 </div><!-- /COL MD -->

 <div class="col-md-3">

 	@if( Auth::check() &&  isset($response->user()->id) && Auth::user()->id == $response->user()->id )
 	<div class="row margin-bottom-20">

			<div class="col-md-12">
				<a class="btn btn-success btn-block margin-bottom-5" href="{{ url('edit/photo',$response->id) }}"><i class="fa fa-pencil myicon-right "></i> {{trans('admin.edit')}}</a>
			</div>
			<div class="col-md-12">
				<a href="#" class="btn btn-danger btn-block" id="deletePhoto" data-url="{{ url('delete/photo',$response->id) }}"><i class="fa fa-times-circle myicon-right "></i> {{trans('admin.delete')}}</a>
			</div>
		</div>
		@endif

 	<!-- Start Panel -->
 	<div class="panel panel-default">
	  <div class="panel-body">
	    <div class="media none-overflow">
			  <div class="media-left">
			    <a href="{{url($response->user()->username)}}">
			      <img class="media-object img-circle" src="{{url('public/avatar/',$response->user()->avatar)}}" width="50" height="50" >
			    </a>
			  </div>
			  <div class="media-body">
			  	<a href="{{url($response->user()->username)}}" class="text-username font-default">
			    	<h4 class="media-heading">{{$response->user()->username}}</h4>
			    </a>
			    <small class="media-heading text-muted btn-block margin-zero">{{trans('misc.published')}} {{App\Helper::formatDate($response->date)}}</small>
			    <small class="media-heading text-muted">{{ number_format(App\Models\User::totalImages( $response->user()->id))}} {{trans_choice('misc.images_plural', App\Models\User::totalImages( $response->user()->id ))}}</small>
			   
			  </div>
			</div>
	  </div>
	</div><!-- End Panel -->

@if( Auth::check() && $response->status == 'active')
<div class="row margin-bottom-20">

	<!-- col-xs-6 -->
	<div class="col-xs-6" style="border-right: 1px solid #e3e3e3;">
	@if( Auth::check()  )
		<a href="#" class="btnLike likeButton {{$statusLike}}" data-id="{{$response->id}}" data-like="{{trans('misc.like')}}" data-unlike="{{trans('misc.unlike')}}">
			<h3 class="btn-block text-center margin-top-10"><i class="{{$icoLike}}"></i></h3>
			<small class="btn-block text-center text-muted textLike">{{$textLike}}</small>
		</a>
		@else

		<a href="{{url('login')}}" class="btnLike">
			<h3 class="btn-block text-center margin-top-10"><i class="fa fa-heart-o"></i></h3>
			<small class="btn-block text-center text-muted">{{trans('misc.like')}}</small>
		</a>

		@endif
	</div><!-- col-xs-6 -->


		 <!-- col-xs-6 -->
		<div class="col-xs-6">
		@if( Auth::check() )

			<a href="#" class="btn-collection" data-toggle="modal" data-target="#collections">
				<h3 class="btn-block text-center margin-top-10"><i class="fa fa-folder-open-o"></i></h3>
			    <small class="btn-block text-center text-muted">{{trans('misc.collection')}}</small>
		    </a>

		    @else

		    <a href="{{url('login')}}" class="btn-collection">
				<h3 class="btn-block text-center margin-top-10"><i class="fa fa-folder-open-o"></i></h3>
			    <small class="btn-block text-center text-muted">{{trans('misc.collection')}}</small>
		    </a>

		    @endif
		</div><!-- col-xs-6 -->
</div>
@endif


	<!-- Start Panel -->
 	<div class="panel panel-default">
	  <div class="panel-body padding-zero">
	  		<ul class="list-stats list-inline">
	    	<li>
	    		<h4 class="btn-block text-center">{{App\Helper::formatNumber($response->visits()->count())}}</h4>
	    		<small class="btn-block text-center text-muted">{{trans('misc.views')}}</small>
	    	</li>

	    	<li>
	    		<h4 class="btn-block text-center" id="countLikes">{{App\Helper::formatNumber($response->likes()->count())}}</h4>
	    		<small class="btn-block text-center text-muted">{{trans('misc.likes')}}</small>
	    	</li>

	    	<li>
	    		<h4 class="btn-block text-center">{{App\Helper::formatNumber($response->downloads()->count())}}</h4>
	    		<small class="btn-block text-center text-muted">{{trans('misc.downloads')}}</small>
	    	</li>

	    </ul>

	  </div>
	</div><!-- End Panel -->

	@if( $response->featured == 'yes' )

	<!-- Start Panel -->
	<div class="panel panel-default">
		<div class="panel-body">
	<i class="icon icon-Medal myicon-right"></i> <span class="text-muted">{{trans('misc.featured_on')}} </span>
	<strong>{{ App\Helper::formatDate($response->featured_date) }}</strong>

		</div>
	</div><!-- End Panel -->

	@endif

	<div class="btn-group btn-block margin-bottom-20">

		<button type="button" class="btn btn-success btn-lg btn-block dropdown-toggle" id="downloadBtn" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			<i class="fa fa-cloud-download myicon-right"></i> {{trans('misc.download')}} <span class="caret"></span>
			</button>

		 <ul class="dropdown-menu arrowDownload dd-close btn-block">
		 	@foreach( $stockImages as $stock )
		 	<?php
		 	switch( $stock->type ) {
			case 'small':
				$_size          = trans('misc.s');
				break;
			case 'medium':
				$_size          = trans('misc.m');
				break;
			case 'large':
				$_size          = trans('misc.l');
				break;

		}
		 	 ?>
		    	<li><a href="{{url('download',$stock->token)}}/{{$stock->type}}"><span class="label label-default myicon-right">{{$_size}}</span> {{$stock->resolution}} <span class="pull-right">{{$stock->size}}</span></a></li>
		    @endforeach
		  </ul>
		</div>

	<?php
	switch( $response->how_use_image ) {
			case 'free':
				$license          = trans('misc.use_free');
				$iconLicense      = 'glyphicon glyphicon-ok';
				break;
			case 'free_personal':
				$license          = trans('misc.use_free_personal');
				$iconLicense      = 'icon-warning';
				break;
			case 'editorial_only':
				$license          = trans('misc.use_editorial_only');
				$iconLicense      = 'icon-warning';
				break;
			case 'web_only':
				$license          = trans('misc.use_web_only');
				$iconLicense      = 'icon-warning';
				break;
		}
 ?>
	<!-- Start Panel -->
	<div class="panel panel-default">
		<div class="panel-body">
			<h5><i class="fa fa-creative-commons myicon-right" aria-hidden="true"></i> <strong>{{trans('misc.license_and_use')}}</strong></h5>
			<small class="text-muted"><i class="{{$iconLicense}} myicon-right"></i> {{$license}}</small>

			@if( $response->attribution_required == 'yes' )
			<small class="btn-block text-muted"><i class="glyphicon glyphicon-ok myicon-right"></i> {{trans('misc.attribution_required')}}</small>
			@else
			<small class="btn-block text-muted"><i class="glyphicon glyphicon-remove myicon-right"></i> {{trans('misc.no_attribution_required')}}</small>
			@endif

		</div>
	</div><!-- End Panel -->

	@if( $response->status == 'active' )
		<!-- Start Panel -->
	<div class="panel panel-default">
		<div class="panel-body">
			<h5 class="pull-left margin-zero" style="line-height: inherit;"><i class="icon icon-Share myicon-right" aria-hidden="true"></i> <strong>{{trans('misc.share')}}</strong></h5>

		<ul class="list-inline pull-right margin-zero">
			<div class="bdsharebuttonbox"><a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a></div>
<script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdMiniList":false,"bdPic":"","bdStyle":"1","bdSize":"24"},"share":{}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];</script>
     </ul>
		</div>
	</div><!-- End Panel -->
	@endif

	@if( $response->exif != '' || $response->camera != '' )
	<!-- Start Panel -->
	<div class="panel panel-default">
		<div class="panel-body">
			<h5><i class="icon icon-DSLRCamera myicon-right" aria-hidden="true"></i> <strong>{{trans('misc.exif_data')}}</strong></h5>

			@if( $response->camera != ''  )
			<small class="btn-block text-muted">{{trans('misc.photo_taken_with')}}</small>
			<small class="btn-block text-muted"><a href="{{url('cameras',$response->camera)}}">{{$response->camera}}</a></small>
			@endif

			<small class="btn-block text-muted wordSpacing">{{$response->exif}}</small>

		</div>
	</div><!-- End Panel -->
	@endif

	@if( $response->colors != '' )
	<?php
       $colors = explode(',', $response->colors);
       $count_colors = count( $colors );
       ?>

	<!-- Start Panel -->
	<div class="panel panel-default">
		<div class="panel-body">
			<h5><i class="icon icon-Drop myicon-right" aria-hidden="true"></i> <strong>{{trans('misc.color_palette')}}</strong></h5>

			@for( $c = 0; $c < $count_colors; ++$c )

		   	<a title="#{{$colors[$c]}}" href="{{url('colors') }}/{{$colors[$c]}}" class="colorPalette showTooltip" style="background-color: {{ '#'.$colors[$c] }};"></a>

		   	@endfor

		</div>
	</div><!-- End Panel -->
	@endif

<ul class="list-group">
       <li class="list-group-item"><i class="icon-info myicon-right"></i> <strong>{{trans('misc.details')}}</strong></li>


       <li class="list-group-item"> <span class="badge data-xs-img">{{App\Helper::formatDate($response->date)}}</span> {{trans('misc.published')}}</li>
	  <li class="list-group-item"> <span class="badge data-xs-img">{{strtoupper($response->extension)}}</span> {{trans('misc.image_type')}}</li>
	  <li class="list-group-item"> <span class="badge data-xs-img">{{$stockImages{2}->resolution}}</span> {{trans('misc.resolution')}}</li>
	  <li class="list-group-item"> <span class="badge data-xs-img"><a href="{{url('category',$response->category->slug)}}" title="{{$response->category->name}}">{{str_limit($response->category->name, 18, '...') }}</a></span> {{trans('misc.category')}}</li>
	  <li href="#" class="list-group-item"> <span class="badge data-xs-img">{{$stockImages{2}->size}}</span> {{trans('misc.file_size')}}</li>
	</ul>


@if( Auth::check() )
<div class="modal fade" id="reportImage" tabindex="-1" role="dialog" aria-hidden="true">
     		<div class="modal-dialog modal-sm">
     			<div class="modal-content">
     				<div class="modal-header">
				        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				        <h4 class="modal-title text-center" id="myModalLabel">
				        	<strong>{{ trans('misc.report_photo') }}</strong>
				        	</h4>
				     </div><!-- Modal header -->

				      <div class="modal-body listWrap">

				    <!-- form start -->
			    <form method="POST" action="{{ url('report/photo') }}" enctype="multipart/form-data" id="formReport">
			    	<input type="hidden" name="_token" value="{{ csrf_token() }}">
			    	<input type="hidden" name="id" value="{{ $response->id }}">
				    <!-- Start Form Group -->
                    <div class="form-group">
                      <label>{{ trans('admin.reason') }}</label>
                      	<select name="reason" class="form-control">
                            <option value="copyright">{{ trans('admin.copyright') }}</option>
                            <option value="privacy_issue">{{ trans('admin.privacy_issue') }}</option>
                            <option value="violent_sexual_content">{{ trans('admin.violent_sexual_content') }}</option>
                          </select>

                  </div><!-- /.form-group-->

                   <button type="submit" class="btn btn-sm btn-danger" id="reportPhoto">{{ trans('misc.report_photo') }}</button>

                    </form>

				      </div><!-- Modal body -->
     				</div><!-- Modal content -->
     			</div><!-- Modal dialog -->
     		</div><!-- Modal -->
     		@endif

@if( Auth::check() && Auth::user()->id != $response->user()->id && $response->status == 'active' )
	<div class="btn-block text-center">
		<a href="#" data-toggle="modal" data-target="#reportImage"><i class="icon-warning myicon-right"></i> {{ trans('misc.report_photo') }}</a>
	</div>
	@endif

	@if( isset( $settings->google_adsense ) )
	<div class="margin-top-20">
	   <?php echo html_entity_decode($settings->google_adsense); ?>
	</div>
	@endif

 </div><!-- /COL MD -->

 </div><!-- container wrap-ui -->

 @if( Auth::check() && $response->user()->id != Auth::user()->id && $response->user()->paypal_account != '' || Auth::guest()  && $response->user()->paypal_account != '' )
 <form id="form_pp" name="_xclick" action="https://www.paypal.com/cgi-bin/webscr" method="post"  style="display:none">
    <input type="hidden" name="cmd" value="_donations">
    <input type="hidden" name="return" value="{{url('photo',$response->id)}}">
    <input type="hidden" name="cancel_return"   value="{{url('photo',$response->id)}}">
    <input type="hidden" name="currency_code" value="USD">
    <input type="hidden" name="item_name" value="{{trans('misc.support').' @'.$response->user()->username}} - {{$settings->title}}" >
    <input type="hidden" name="business" value="{{$response->user()->paypal_account}}">
    <input type="submit">
</form>
@endif

@endsection

@section('javascript')
<script src="{{ asset('public/plugins/iCheck/icheck.min.js') }}" type="text/javascript"></script>
<script type="text/javascript">

$('#imagesFlex').flexImages({ maxRows: 1, truncate: true });

$('#btnFormPP').click(function(e){
	$('#form_pp').submit();
});

$('input').iCheck({
          radioClass: 'iradio_flat-green',
          checkboxClass: 'icheckbox_square-green',
        });

@if (session('noty_error'))
    		swal({
    			title: "{{ trans('misc.error_oops') }}",
    			text: "{{ trans('misc.already_sent_report') }}",
    			type: "error",
    			confirmButtonText: "{{ trans('users.ok') }}"
    			});
   		 @endif

   		 @if (session('noty_success'))
    		swal({
    			title: "{{ trans('misc.thanks') }}",
    			text: "{{ trans('misc.send_success') }}",
    			type: "success",
    			confirmButtonText: "{{ trans('users.ok') }}"
    			});
   		 @endif

  @if( Auth::check() )

  $("#reportPhoto").click(function(e) {
  	var element     = $(this);
	e.preventDefault();
  	 element.attr({'disabled' : 'true'});

  	 $('#formReport').submit();

  });

  // Comments Delete
$(document).on('click','.deleteComment',function () {

	var $id = $(this).data('id');

	$.ajaxSetup({
				headers: {
					'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
					}
			});

		swal(
			{   title: "{{trans('misc.delete_confirm')}}",
			  type: "warning",
			  showLoaderOnConfirm: true,
			  showCancelButton: true,
			  confirmButtonColor: "#DD6B55",
			   confirmButtonText: "{{trans('misc.yes_confirm')}}",
			   cancelButtonText: "{{trans('misc.cancel_confirm')}}",
			    closeOnConfirm: false,
			    },
			    function(isConfirm){
			    	 if (isConfirm) {

			element = $(this);

			element.removeClass('deleteComment');

			$.post("{{url('comment/delete')}}",
			{ comment_id: $id },
			function(data){
				if(data.success == true ){
					window.location.reload();
				} else {
					//bootbox.alert(data.error);
					//window.location.reload();
				}

			},'json');

			   }
	       });
		});

  // Likes Comments
		$(document).on('click','.likeComment',function () {

			$.ajaxSetup({
				headers: {
					'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
					}
			});

			element  = $(this);

			element.html('<i class="fa fa-spinner fa-spin"></i>');

			$.post("{{url('comment/like')}}",
			{ comment_id: $(this).data('id')
			}, function(data){
				if(data.success == true ){
					if( data.type == 'like' ) {
						element.html('<i class="fa fa-heart myicon-right"></i>');
						element.parent('.btn-block').find('.count').html(data.count).fadeIn();
						element.parent('.btn-block').find('.like-small').fadeIn();
						element.blur();

					} else if( data.type == 'unlike' ) {
						element.html('<i class="fa fa-heart-o myicon-right"></i>');

					if( data.count == 0 ) {
						element.parent('.btn-block').find('.count').html(data.count).fadeOut();
						element.parent('.btn-block').find('.like-small').fadeOut();
					} else {
						element.parent('.btn-block').find('.count').html(data.count).fadeIn();
						element.parent('.btn-block').find('.like-small').fadeIn();
					}

						element.blur();
					}
				} else {
					bootbox.alert(data.error);
					window.location.reload();
				}

				if( data.session_null ) {
					window.location.reload();
				}
			},'json');
		});
  @endif

  //<<<---------- Comments Likes
$(document).on('click','.comments-likes',function() {
   	element  = $(this);
   	var id   = element.attr("data-id");
   	var info = 'comment_id=' + id;

   		element.removeClass('comments-likes');

   		$.ajax({
   			headers: {
        	'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
    		},
		   type: "POST",
		   url: "{{ url('comments/likes') }}",
		   data: info,
		   success: function( data ) {


                $( '#collapse'+ id ).html(data);
                $('[data-toggle="tooltip"]').tooltip();

				if( data == '' ){
					$( '#collapse'+ id ).html("{{trans('misc.error')}}");
				}
				}//<-- $data
			});
   });

  @if( Auth::check() && Auth::user()->id == $response->user()->id )

  // Delete Photo
	 $("#deletePhoto").click(function(e) {
	   	e.preventDefault();

	   	var element = $(this);
		var url     = element.attr('data-url');

		element.blur();

		swal(
			{   title: "{{trans('misc.delete_confirm')}}",
			  type: "warning",
			  showLoaderOnConfirm: true,
			  showCancelButton: true,
			  confirmButtonColor: "#DD6B55",
			   confirmButtonText: "{{trans('misc.yes_confirm')}}",
			   cancelButtonText: "{{trans('misc.cancel_confirm')}}",
			    closeOnConfirm: false,
			    },
			    function(isConfirm){
			    	 if (isConfirm) {
			    	 	window.location.href = url;
			    	 	}
			    	 });
			 });
	@endif

	//<<---- PAGINATION AJAX
        $(document).on('click','.pagination a', function(e){
			e.preventDefault();
			var page = $(this).attr('href').split('page=')[1];
			$.ajax({
				headers: {
        	'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
    		},
					url: '{{ url("/") }}/ajax/comments?photo={{$response->id}}&page=' + page


			}).done(function(data){
				if( data ) {

					scrollElement('#gridComments');

					$('.gridComments').html(data);

					jQuery(".timeAgo").timeago();

					$('[data-toggle="tooltip"]').tooltip();
				} else {
					sweetAlert("{{trans('misc.error_oops')}}", "{{trans('misc.error')}}", "error");
				}
				//<**** - Tooltip
			});

		});//<<---- PAGINATION AJAX

</script>

@endsection
