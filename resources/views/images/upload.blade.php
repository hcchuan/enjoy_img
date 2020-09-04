@extends('app')

@section('title'){{ trans('users.upload').' - ' }}@endsection

@section('css')
<link href="{{ asset('public/plugins/iCheck/all.css') }}" rel="stylesheet" type="text/css" />
<link href="{{ asset('public/plugins/tagsinput/jquery.tagsinput.min.css') }}" rel="stylesheet" type="text/css" />
@endsection

@section('content')

    <?php

    $date = date('Y-m-d', strtotime('today'));
	$imagesUploads = App\Models\Images::where('user_id',Auth::user()->id)->whereRaw("DATE(date) = '".$date."'")->count();

     ?>

<div class="container margin-bottom-40 padding-top-40">
	<div class="row">

@if( $settings->limit_upload_user == 0 || $imagesUploads < $settings->limit_upload_user || Auth::user()->role == 'admin'  )
	<!-- col-md-4-->
		<div class="col-md-4">
		<div class="alert alert-warning" role="alert">

			<ul class="padding-zero">
				<?php if( $settings->limit_upload_user == 0 ) {
					$limit = strtolower(trans('admin.unlimited'));
				} else {
					$limit = $settings->limit_upload_user;
				} ?>
				<li class="margin-bottom-10"><i class="glyphicon glyphicon-warning-sign myicon-right"></i>  {{ trans('conditions.terms') }}</li>
				<li class="margin-bottom-10"><i class="glyphicon glyphicon-info-sign myicon-right"></i>  {{ trans('conditions.upload_max', ['limit' => $limit ]) }}</li>
				<li class="margin-bottom-10"><i class="glyphicon glyphicon-info-sign myicon-right"></i>  {{ trans('conditions.sex_content') }}</li>
				<li class="margin-bottom-10"><i class="glyphicon glyphicon-info-sign myicon-right"></i>  {{ trans('conditions.own_images') }}</li>
			</ul>

		</div>
	</div><!-- col-md-4-->

	<!-- col-md-8 -->
	<div class="col-md-8">

@include('errors.errors-forms')
    <!-- form start -->
    <form method="POST" action="{{ url('upload') }}" enctype="multipart/form-data" id="formUpload">

    	<input type="hidden" name="_token" value="{{ csrf_token() }}">

		<div class="filer-input-dragDrop position-relative" id="draggable">

			<input type="file" accept="image/*" name="photo" id="filePhoto">

			<!-- previewPhoto -->
			<div class="previewPhoto">

				<div class="btn btn-danger btn-sm btn-remove-photo" id="removePhoto">
					<i class="icon icon-Delete myicon-right"></i> {{trans('misc.delete')}}
					</div>

			</div><!-- previewPhoto -->

			<div class="filer-input-inner">
				<div class="filer-input-icon">
					<i class="fa fa-cloud-upload"></i>
					</div>
					<div class="filer-input-text">
						<h3 class="margin-bottom-10">{{ trans('misc.click_select_image') }}</h3>
						<h3>{{ trans('misc.max_size') }}: {{  $settings->min_width_height_image.' - '.App\Helper::formatBytes($settings->file_size_allowed * 1024)}} </h3>
					</div>
				</div>
			</div>

			<div class="panel panel-default">

				<div class="panel-body">
                 <!-- Start Form Group -->
                    <div class="form-group">
                      <label>{{ trans('admin.title') }}</label>
                        <input type="text" value="{{ old('title') }}" name="title" id="title" class="form-control" placeholder="{{ trans('admin.title') }}">
                    </div><!-- /.form-group-->

                   <!-- Start Form Group -->
                    <div class="form-group">
                      <label>{{ trans('misc.tags') }}</label>
                        <input type="text" value0="{{ old('tags') }}" value="美女" id="tagInput"  name="tags" class="form-control" placeholder="{{ trans('misc.tags') }}">
                      	<p class="help-block">* {{ trans('misc.add_tags_guide') }} ({{trans('misc.maximum_tags', ['limit' => $settings->tags_limit ]) }})</p>
                  </div><!-- /.form-group-->

                  <!-- Start Form Group -->
                    <div class="form-group">
                      <label>{{ trans('misc.category') }}</label>
                      	<select name="categories_id" class="form-control">

                      	@foreach(  App\Models\Categories::where('mode','on')->orderBy('name')->get() as $category )
                            <option value="{{$category->id}}">{{ $category->name }}</option>
						@endforeach

                          </select>
                  </div><!-- /.form-group-->

                  <!-- Start Form Group -->
                    <div class="form-group">
                      <label>{{ trans('misc.how_use_image') }}</label>
                      	<select name="how_use_image" class="form-control">
                            <option value="free">{{ trans('misc.use_free') }}</option>
                            <option value="free_personal">{{ trans('misc.use_free_personal') }}</option>
                             <option value="editorial_only">{{ trans('misc.use_editorial_only') }}</option>
                              <option value="web_only">{{ trans('misc.use_web_only') }}</option>

                          </select>
                  </div><!-- /.form-group-->

                  <!-- Start form-group -->
                    <div class="form-group">
                      <label>{{ trans('misc.attribution_required') }}</label>

                      	<div class="radio">
                        <label class="padding-zero">
                          <input type="radio" name="attribution_required" value="yes">
                          {{ trans('misc.yes') }}
                        </label>
                      </div>

                      <div class="radio">
                        <label class="padding-zero">
                          <input type="radio" name="attribution_required" checked="checked" value="no">
                          {{ trans('misc.no') }}
                        </label>
                      </div>

                    </div><!-- /.form-group -->

                  <div class="form-group">
                      <label>{{ trans('admin.description') }} ({{ trans('misc.optional') }})</label>
                      	<textarea name="description" rows="4" id="description" class="form-control" placeholder="{{ trans('admin.description') }}">{{ old('description') }}</textarea>
                    </div>

                    <!-- Alert -->
                    <div class="alert alert-danger display-none" id="dangerAlert">
							<ul class="list-unstyled" id="showErrors"></ul>
						</div><!-- Alert -->

                  <div class="box-footer">
                  	<hr />
                    <button type="submit" id="upload" class="btn btn-lg btn-success pull-right"><i class="fa fa-cloud-upload myicon-right"></i> {{ trans('users.upload') }}</button>
                  </div><!-- /.box-footer -->
                </form>

         	</div>
         </div>

		</div>
		<!-- col-md-8-->

		@else

		<div class="btn-block text-center margin-top-40">
	    			<i class="icon-warning ico-no-result"></i>
	    		</div>

		<h3 class="margin-top-none text-center no-result no-result-mg">
	    		{{trans('misc.limit_uploads_user')}}
	    	</h3>

		@endif

	</div><!-- row -->
</div><!-- container -->
@endsection

@section('javascript')
	<script src="{{ asset('public/plugins/iCheck/icheck.min.js') }}" type="text/javascript"></script>
	<script src="{{ asset('public/plugins/tagsinput/jquery.tagsinput.min.js') }}" type="text/javascript"></script>

	<script type="text/javascript">

	//Flat red color scheme for iCheck
        $('input[type="radio"]').iCheck({
          radioClass: 'iradio_flat-red'
        });

$('#removePhoto').click(function(){
	 	$('#filePhoto').val('');
	 	$('#title').val('');
	 	$('.previewPhoto').css({backgroundImage: 'none'}).hide();
	 	$('.filer-input-dragDrop').removeClass('hoverClass');
	 });

//================== START FILE IMAGE FILE READER
$("#filePhoto").on('change', function(){

	var loaded = false;
	if(window.File && window.FileReader && window.FileList && window.Blob){
		if($(this).val()){ //check empty input filed
			oFReader = new FileReader(), rFilter = /^(?:image\/gif|image\/ief|image\/jpeg|image\/jpeg|image\/jpeg|image\/png|image)$/i;
			if($(this)[0].files.length === 0){return}


			var oFile = $(this)[0].files[0];
			var fsize = $(this)[0].files[0].size; //get file size
			var ftype = $(this)[0].files[0].type; // get file type


			if(!rFilter.test(oFile.type)) {
				$('#filePhoto').val('');
				$('.popout').addClass('popout-error').html("{{ trans('misc.formats_available') }}").fadeIn(500).delay(5000).fadeOut();
				return false;
			}

			var allowed_file_size = {{$settings->file_size_allowed * 1024}};

			if(fsize>allowed_file_size){
				$('#filePhoto').val('');
				$('.popout').addClass('popout-error').html("{{trans('misc.max_size').': '.App\Helper::formatBytes($settings->file_size_allowed * 1024)}}").fadeIn(500).delay(5000).fadeOut();
				return false;
			}
		<?php $dimensions = explode('x',$settings->min_width_height_image); ?>

			oFReader.onload = function (e) {

				var image = new Image();
			    image.src = oFReader.result;

				image.onload = function() {

			    	if( image.width < {{ $dimensions[0] }}) {
			    		$('#filePhoto').val('');
			    		$('.popout').addClass('popout-error').html("{{trans('misc.width_min',['data' => $dimensions[0]])}}").fadeIn(500).delay(5000).fadeOut();
			    		return false;
			    	}

			    	if( image.height < {{ $dimensions[1] }} ) {
			    		$('#filePhoto').val('');
			    		$('.popout').addClass('popout-error').html("{{trans('misc.height_min',['data' => $dimensions[1]])}}").fadeIn(500).delay(5000).fadeOut();
			    		return false;
			    	}

			    	$('.previewPhoto').css({backgroundImage: 'url('+e.target.result+')'}).show();
			    	$('.filer-input-dragDrop').addClass('hoverClass');
			    	var _filname =  oFile.name;
					var fileName = _filname.substr(0, _filname.lastIndexOf('.'));
			    	$('#title').val(fileName);
			    };// <<--- image.onload


           }

           oFReader.readAsDataURL($(this)[0].files[0]);

		}
	} else{
		$('.popout').html('Can\'t upload! Your browser does not support File API! Try again with modern browsers like Chrome or Firefox.').fadeIn(500).delay(5000).fadeOut();
		return false;
	}
});

		$('input[type="file"]').attr('title', window.URL ? ' ' : '');

		$("#tagInput").tagsInput({

		 'delimiter': [','],   // Or a string with a single delimiter. Ex: ';'
		 'width':'auto',
		 'height':'auto',
	     'removeWithBackspace' : true,
	     'minChars' : 2,
	     'maxChars' : 25,
	     'defaultText':'{{ trans("misc.add_tag") }}',
	     onChange: function() {
         	var input = $(this).siblings('.tagsinput');
         	var maxLen = {{$settings->tags_limit}};

			if( input.children('span.tag').length >= maxLen){
			        input.children('div').hide();
			    }
			    else{
			        input.children('div').show();
			    }
			},
	});

	</script>


@endsection
