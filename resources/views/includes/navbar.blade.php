<?php
$userAuth = Auth::user();
if( Auth::check() ) {

	// Notifications
	$notifications_count = App\Models\Notifications::where('destination',Auth::user()->id)->where('status','0')->count();

}
?>
<div class="navbar navbar-inverse navBar">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">

          	 <?php if( isset( $totalNotify ) ) : ?>
        	<span class="notify notifyResponsive"><?php echo $totalNotify; ?></span>
        	<?php endif; ?>

            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="{{ url('/') }}">
          	<img src="{{ asset('public/img/logo.png') }}" class="logo" />
          	</a>
        </div><!-- navbar-header -->

        <div class="navbar-collapse collapse">

        	<ul class="nav navbar-nav navbar-right margin-bottom-zero">

        		@if(!Request::is('/'))

               <li id="li-search">
        			<a class="color-default font-default text-uppercase" id="btnExpand" data-toggle="collapse" href="#formShow" aria-expanded="false" aria-controls="form_Show">
        				<i class="icon-search"></i> <span class="title-dropdown">{{trans('misc.search')}}</span>
        				</a>
        		</li>
        		 @endif

        		@if( Auth::check() )
        		 <li>
        			<a href="{{url('feed')}}" class="font-default text-uppercase">
        				{{trans('misc.feed')}}
        				</a>
        		</li>
        		@endif

        		<li class="dropdown">
        			<a href="javascript:void(0);" class="font-default text-uppercase"  data-toggle="dropdown">{{trans('misc.explore')}}
        				<i class="ion-chevron-down margin-lft5"></i>
        				</a>

        				<!-- DROPDOWN MENU -->
        				<ul class="dropdown-menu arrow-up" role="menu" aria-labelledby="dropdownMenu2">
        					<li><a href="{{ url('members') }}"><i class="icon icon-Users myicon-right"></i> {{ trans('misc.members') }}</a></li>
        					<li><a href="{{ url('collections') }}"><i class="fa fa-folder-open-o myicon-right"></i> {{ trans('misc.collections') }}</a></li>
        					<li><a href="{{ url('tags') }}"><i class="icon icon-Tag myicon-right"></i> {{ trans('misc.tags') }}</a></li>
        					<li role="separator" class="divider"></li>
        					<li><a href="{{ url('featured') }}">{{ trans('misc.featured') }}</a></li>
	        				<li><a href="{{ url('popular') }}">{{ trans('misc.popular') }}</a></li>
							<li><a href="{{ url('latest') }}">{{ trans('misc.latest') }}</a></li>
			            	<li><a href="{{ url('most/commented') }}">{{trans('misc.most_commented')}}</a></li>
				          	<li><a href="{{ url('most/viewed') }}">{{trans('misc.most_viewed')}}</a></li>
				          	<li><a href="{{ url('most/downloads') }}">{{trans('misc.most_downloads')}}</a></li>
        				</ul><!-- DROPDOWN MENU -->

        			</li>

        		<li class="dropdown">
        			<a href="javascript:void(0);" class="font-default text-uppercase" data-toggle="dropdown">{{trans('misc.categories')}}
        				<i class="ion-chevron-down margin-lft5"></i>
        				</a>

        				<!-- DROPDOWN MENU -->
        				<ul class="dropdown-menu arrow-up nav-session" role="menu" aria-labelledby="dropdownMenu2">
        				@foreach(  App\Models\Categories::where('mode','on')->orderBy('name')->take(9)->get() as $category )
        					<li>
        						<a href="{{ url('category') }}/{{ $category->slug }}" class="text-overflow">
        						{{ $category->name }}
        							</a>
        					</li>
        					@endforeach

        					@if( App\Models\Categories::count() > 9 )
			        		<li><a href="{{ url('categories') }}">
			        			<strong>{{ trans('misc.view_all') }} <i class="fa fa-long-arrow-right"></i></strong>
			        		</a></li>
			        		@endif
        				</ul><!-- DROPDOWN MENU -->

        			</li>


        		@if( Auth::check() )

        			<li>
        				<span class="notify @if( $notifications_count != 0 ) displayBlock @endif" id="noti_connect">@if( $notifications_count != 0 ) {{ $notifications_count }} @endif</span>
        				<a href="{{ url('notifications') }}" title="{{ trans('users.notifications') }}" class="font-default text-uppercase">
        					<i class="fa fa-bell-o"></i>
        					<span class="title-dropdown">{{ trans('users.notifications') }}</span>
        					</a>
        			</li><!-- NOTY -->

        			<li class="dropdown">
			          <a href="javascript:void(0);" data-toggle="dropdown" class="userAvatar myprofile dropdown-toggle font-default text-uppercase">
			          		<img src="{{ asset('public/avatar').'/'.$userAuth->avatar }}" alt="User" class="img-circle avatarUser" width="21" height="21">
			          		<span class="title-dropdown">{{ trans('users.my_profile') }}</span>
			          		<i class="ion-chevron-down margin-lft5 dropdown-ic"></i>
			          	</a>

			          <!-- DROPDOWN MENU -->
			          <ul class="dropdown-menu dd-close arrow-up nav-session" role="menu" aria-labelledby="dropdownMenu4">


	          		 @if( $userAuth->role == 'admin' )
	          		 	<li>
	          		 		<a href="{{ url('panel/admin') }}" class="text-overflow">
	          		 			<i class="icon icon-Speedometter myicon-right"></i> {{ trans('admin.admin') }}</a>
	          		 			</li>
	          		 			<li role="separator" class="divider"></li>
	          		 	@endif

	          		 	<li>
	          		 		<a href="{{ url($userAuth->username) }}" class="myprofile text-overflow">
	          		 			<i class="icon icon-User myicon-right"></i> @if( $userAuth->name != '' ) {{  e($userAuth->name) }} @else {{ e($userAuth->username) }} @endif
	          		 		</a>
	          		 		</li>

	          		 		<li>
	          		 			<a href="{{ url($userAuth->username,'collections') }}">
	          		 			<i class="fa fa-folder-open-o myicon-right"></i> {{ trans('misc.collections') }}
	          		 			</a></li>

	          		 		<li>
	          		 			<a href="{{ url('likes') }}" class="text-overflow">
	          		 				<i class="icon icon-Heart myicon-right"></i> {{ trans('users.likes') }}
	          		 				</a>
	          		 			</li>

	          		 		<li>
	          		 			<a href="{{ url('account') }}" class="text-overflow">
	          		 				<i class="icon icon-Settings myicon-right"></i> {{ trans('users.account_settings') }}
	          		 				</a>
	          		 			</li>
	          		 		<li>
	          		 			<a href="{{ url('logout') }}" class="logout text-overflow">
	          		 				<i class="icon icon-Exit myicon-right"></i> {{ trans('users.logout') }}
	          		 			</a>
	          		 		</li>

	          		 	</ul><!-- DROPDOWN MENU -->

	          		</li>

	          		@if( Auth::user()->authorized_to_upload == 'yes' )
	          		<li>
        				<a class="log-in font-default text-uppercase" href="{{ url('upload') }}" title="{{ trans('users.upload') }}">
        					<i class="fa fa-cloud-upload"></i> <span class="title-dropdown">{{ trans('users.upload') }}</span>
        					</a>
        			</li>
        			@endif



        		@else

        		@if( $settings->registration_active == '1' )
        			<li>
        				<a class="log-in font-default text-uppercase" href="{{ url('register') }}">
        					<i class="glyphicon glyphicon-user"></i> {{ trans('auth.sign_up') }}
        					</a>
        			</li>
        			@endif

        			<li>
        				<a class="font-default text-uppercase @if( $settings->registration_active == 0 ) log-in @endif" href="{{ url('login') }}">
        					{{ trans('auth.login') }}
        					</a>
        			</li>
        	  @endif
          </ul>



</div><!--/.navbar-collapse -->
      </div>
    </div>
