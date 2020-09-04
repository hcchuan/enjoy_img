<?php
/*----------------------------------------------
 *  SHOW NUMBER NOTIFICATIONS IN BROWSER ( 1 )
 * --------------------------------------------
 */
 if( Auth::check() ) {

	// Notifications
	$notifications_count = App\Models\Notifications::where('destination',Auth::user()->id)->where('status','0')->count();

	if( $notifications_count != 0 ) {
		$totalNotifications = '('.( $notifications_count ).') ';
		$totalNotify = ( $notifications_count );
	} else {
		$totalNotifications = null;
		$totalNotify = null;
	}
 } else {
 	$totalNotifications = null;
	$totalNotify = null;
 }

?>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="csrf-token" content="{{ csrf_token() }}">
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="@yield('description_custom'){{ $settings->description }}">
    <meta name="keywords" content="@yield('keywords_custom'){{ $settings->keywords }}" />
    <link rel="shortcut icon" href="{{ asset('public/img/favicon.png') }}" />

	<title>{{$totalNotifications}}@section('title')@show @if( isset( $settings->title ) ){{$settings->title}}@endif</title>

	@include('includes.css_general')

	<!-- Fonts -->
	<link href='https://fonts.googleapis.com/css?family=Montserrat:700' rel='stylesheet' type='text/css'>

	<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
	<!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
		<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->

	@yield('css')

	@if( Auth::check() )
<script type="text/javascript">
//<----- Notifications
function Notifications() {

	 var _title = '@section("title")@show {{e($settings->title)}}';

	 console.time('cache');

	 $.get(URL_BASE+"/ajax/notifications", function( data ) {
		if ( data ) {

			//* Notifications */
			if( data.notifications != 0 ) {

				var totalNoty = data.notifications;
				$('#noti_connect').html(data.notifications).fadeIn();
			} else {
				$('#noti_connect').html('').hide();
			}

			//* Error */
			if( data.error == 1 ) {
				window.location.reload();
			}

			var totalGlobal = parseInt( totalNoty );

			if( data.notifications == 0 ) {
				$('.notify').hide();
				$('title').html( _title );
			}

		if( data.notifications != 0 ) {
		    $('title').html( "("+ totalGlobal + ") " + _title );
		  }

		}//<-- DATA

		},'json');

		console.timeEnd('cache');
}//End Function TimeLine

timer = setInterval("Notifications()", 10000);
</script>
@endif

</head>
<body>
@if( isset( $settings->google_analytics ) )
	<?php echo html_entity_decode($settings->google_analytics) ?>
	@endif

	<div class="popout font-default"></div>

	<div class="wrap-loader">
		<i class="fa fa-cog fa-spin fa-3x fa-fw cog-loader"></i>
		<i class="fa fa-cog fa-spin fa-3x fa-fw cog-loader-small"></i>
	</div>

	@if(!Request::is('/'))
	<form role="search" class="box_Search collapse" autocomplete="off" action="{{ url('search') }}" method="get" id="formShow">
		     	<div>
		     		<input type="text" name="q" class="input_search form-control" id="btnItems" placeholder="Search">
		     		<button type="submit" id="_buttonSearch"><i class="icon-search"></i></button>
		     	</div><!--/.form-group -->
		     </form><!--./navbar-form -->
		     @endif

	@include('includes.navbar')

		@yield('content')

			@include('includes.footer')

		@include('includes.javascript_general')

	@yield('javascript')

</body>
</html>
