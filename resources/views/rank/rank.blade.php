@extends('app')

@section('title'){{ $category->name.' - ' }}@endsection

@section('content') 
<div class="jumbotron md index-header jumbotron_set jumbotron-cover">
      <div class="container wrap-jumbotron position-relative">
        <h1 class="title-site title-sm">{{ $category->name }}</h1>

       @if( $images->total() != 0 )
        	<p class="subtitle-site"><strong>共 {{number_format($images->total())}} 图</strong></p>
        @else
        	<p class="subtitle-site"><strong>{{$settings->title}}</strong></p>
        @endif
      </div>
    </div>

<div class="col-md-12 margin-top-5 margin-bottom-5">
	<select id="time_type_list" name="time_type_list">
		<option value="0">{{trans('misc.rank_total')}}</option>
		@foreach ($time_type_list as $item)
			<option value="{{$item['id']}}">{{$item['name']}}</option>
		@endforeach
	</select>
</div>

<div class="container margin-bottom-40">

<!-- Col MD -->
<div class="col-md-12 margin-top-20 margin-bottom-20">	

	@if( $images->total() != 0 )	

	<div id="imagesFlex" class="flex-images btn-block margin-bottom-40 dataResult">
	     @include('includes.images')

	      @if( $images->count() != 0  )   
			    <div class="container-paginator">
			    	{{ $images->links() }}
			    	</div>	
			    	@endif
			    	
	  </div><!-- Image Flex -->
	  
	 
                  
	  @else
	  <div class="btn-block text-center">
	    			<i class="icon icon-Picture ico-no-result"></i>
	    		</div>
	    		
	    		<h3 class="margin-top-none text-center no-result no-result-mg">
	    		{{ trans('misc.no_results_found') }}
	    	</h3>
	  @endif
	    	
 </div><!-- /COL MD -->
 
 </div><!-- container wrap-ui -->
  
@endsection

@section('javascript')
	
<script type="text/javascript">

 $('#imagesFlex').flexImages({ rowHeight: 220 });

 $(function(){
     $.ajaxSetup({
         headers: { 'X-CSRF-TOKEN' : '{{ csrf_token() }}' }
     });

     $("#time_type_list").val({{$time_type}});

     $("#time_type_list").change(function(){
         console.log($("#time_type_list").val());
         location.href='{{ url("/") }}/rank/{{$category->slug}}/'+$("#time_type_list").val();
	 });
 });

//<<---- PAGINATION AJAX
        $(document).on('click','.pagination a', function(e){
			e.preventDefault();
			var page = $(this).attr('href').split('page=')[1];
			$.ajax({
				headers: {
        	'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
    		},
					url: '{{ url("/") }}/ajax/category?slug={{$category->slug}}&page=' + page
					
				
			}).done(function(data){
				if( data ) {
					
					scrollElement('#imagesFlex');
					
					$('.dataResult').html(data);
					
					$('.hovercard').hover(
		               function () {
		                  $(this).find('.hover-content').fadeIn();
		               }, 
		               function () {
		                  $(this).find('.hover-content').fadeOut();
		               }
		            );
            
					$('#imagesFlex').flexImages({ rowHeight: 220 });
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