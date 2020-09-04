<button type="button" class="btn btn-default btn-block btn-border btn-lg show-toogle btn-collapse" data-toggle="collapse" data-target=".responsive-side" style="margin-bottom: 20px;">
	   <i class="fa fa-bars myicon-right"></i> {{ trans('misc.menu') }}
	</button>
	
<nav class="navbar navbar-default margin-b-10 navbar-user-ui nav-filters" role="navigation">
    	<div class="container">
    		<div style="width: 100%; text-align: center;">
    	
    	<div class="responsive-side collapse">
    		
    		<ul class="nav nav-pills nav-user-profile tabs_index">
    			<li @if(Request::is('latest')) class="active" @endif><a href="{{url('latest')}}">{{trans('misc.latest')}}</a></li>
    			<li @if(Request::is('featured')) class="active" @endif><a href="{{url('featured')}}">{{trans('misc.featured')}}</a></li>
    			<li @if(Request::is('popular')) class="active" @endif><a href="{{url('popular')}}">{{trans('misc.popular')}}</a></li>
    			<li @if(Request::is('most/commented')) class="active" @endif><a href="{{url('most/commented')}}">{{trans('misc.most_commented')}}</a></li>
    			<li @if(Request::is('most/viewed')) class="active" @endif><a href="{{url('most/viewed')}}">{{trans('misc.most_viewed')}}</a></li>
    			<li @if(Request::is('most/downloads')) class="active" @endif><a href="{{url('most/downloads')}}">{{trans('misc.most_downloads')}}</a></li>
    		</ul>
    		
    	</div>
    		
    		</div>
    	</div><!-- container -->
  </nav>