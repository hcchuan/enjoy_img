@extends('app')

@section('title'){{ trans('auth.sign_up').' - ' }}@endsection

@section('content')

<div class="jumbotron md index-header jumbotron_set jumbotron-cover">
      <div class="container wrap-jumbotron position-relative">
        <h1 class="title-site title-sm">{{{ trans('auth.sign_up') }}}</h1>
        <p class="subtitle-site"><strong>{{{$settings->title}}}</strong></p>
      </div>
    </div>

<div class="container margin-bottom-40">
	
	<div class="row">
<!-- Col MD -->
<div class="col-md-6 line-login">	
	
	<h2 class="text-center line position-relative">{{{ trans('auth.sign_up') }}}</h2>
	
	<div class="login-form">
		
		@if (session('notification'))
						<div class="alert alert-success text-center">
							
							<div class="btn-block text-center margin-bottom-10">
								<i class="glyphicon glyphicon-ok ico_success_cicle"></i>
								</div>
								
							{{{ session('notification') }}}
						</div>
					@endif
					
		@include('errors.errors-forms')
	            	
          	<form action="{{{ url('register') }}}" method="post" name="form" id="signup_form">
            
            <input type="hidden" name="_token" value="{{{ csrf_token() }}}">
             
             <!-- FORM GROUP -->
            <div class="form-group has-feedback">
              <input type="text" class="form-control login-field custom-rounded" value="{{{ old('username') }}}" name="username" placeholder="{{{ trans('auth.username') }}}" title="{{{ trans('auth.username') }}}" autocomplete="off">
              <span class="glyphicon glyphicon-user form-control-feedback"></span>
            </div><!-- ./FORM GROUP -->
                    
             <!-- FORM GROUP -->
            <div class="form-group has-feedback">
              <input type="text" class="form-control login-field custom-rounded" value="{{{ old('email') }}}" name="email" placeholder="{{{ trans('auth.email') }}}" title="{{{ trans('auth.email') }}}" autocomplete="off">
              <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
            </div><!-- ./FORM GROUP -->
                     
         <!-- FORM GROUP -->
         <div class="form-group has-feedback">
              <input type="password" class="form-control login-field custom-rounded" name="password" placeholder="{{{ trans('auth.password') }}}" title="{{{ trans('auth.password') }}}" autocomplete="off">
              <span class="glyphicon glyphicon-lock form-control-feedback"></span>
         </div><!-- ./FORM GROUP -->
         
         <div class="form-group has-feedback">
			<input type="password" class="form-control" name="password_confirmation" placeholder="{{{ trans('auth.confirm_password') }}}" title="{{{ trans('auth.confirm_password') }}}" autocomplete="off">
			<span class="glyphicon glyphicon-log-in form-control-feedback"></span>
		</div>
		
		@if( $settings->captcha == 'on' )    
            <div class="form-group has-feedback">
              <input type="text" class="form-control login-field" name="captcha" id="lcaptcha" placeholder="" title="">
              <span class="glyphicon glyphicon-lock form-control-feedback"></span>
            
              <div class="alert alert-danger btn-sm margin-top-alert" id="errorCaptcha" role="alert" style="display: none;">
            		<strong><i class="glyphicon glyphicon-alert myicon-right"></i> {{Lang::get('auth.error_captcha')}}</strong>
            	</div>
            </div>
            @endif
         
           <button type="submit" id="buttonSubmitRegister" class="btn btn-block btn-lg btn-main custom-rounded">{{{ trans('auth.sign_up') }}}</button>

			@if( $settings->facebook_login == 'on' )
			<span class="login-link auth-social" id="twitter-btn-text">{{{ trans('auth.or_sign_in_with') }}}</span>

					<div class="facebook-login auth-social" id="twitter-btn">
						<a href="{{{url('/')}}}/oauth/facebook" class="btn btn-block btn-lg facebook custom-rounded"><i class="fa fa-facebook"></i> Facebook</a>
					</div>
					@endif
					
					<div class="btn-block">
						{{{ trans('auth.terms') }}}
					</div>
          </form>
     </div><!-- Login Form -->
		
 </div><!-- /COL MD -->
 
 <!-- Col MD -->
<div class="col-md-6">
	
	<div class="btn-block text-center">
	    	<i class="icon-users ico-no-result"></i>
	    </div>
	    
	<h2 class="text-center">{{ Lang::get('auth.already_have_an_account') }}</h2>
	
	<div class="btn-block text-center">
		<a href="{{{ url('login') }}}" class="btn btn-lg btn-success custom-rounded">{{{ trans('auth.login') }}}</a>
	</div>
	
</div><!-- /COL MD -->
 
</div><!-- ROW -->
 
 </div><!-- row -->
 
 <!-- container wrap-ui -->

@endsection

@section('javascript')
	
	<script type="text/javascript">

 @if( $settings->captcha == 'on' )     
/*
 *  ==============================================  Captcha  ============================== * /
 */
   var captcha_a = Math.ceil( Math.random() * 5 );
   var captcha_b = Math.ceil( Math.random() * 5 );
   var captcha_c = Math.ceil( Math.random() * 5 );
   var captcha_e = ( captcha_a + captcha_b ) - captcha_c;
  
function generate_captcha( id ) {
	var id = ( id ) ? id : 'lcaptcha';
	$("#" + id ).html( captcha_a + " + " + captcha_b + " - " + captcha_c + " = ").attr({'placeholder' : captcha_a + " + " + captcha_b + " - " + captcha_c, title: 'Captcha = '+captcha_a + " + " + captcha_b + " - " + captcha_c });
}
$("input").attr('autocomplete','off');
generate_captcha('lcaptcha');

$('#buttonSubmitRegister').click(function(e){
   	e.preventDefault();
   	var captcha        = $("#lcaptcha").val();
    	if( captcha != captcha_e ){
				var error = true;
		        $("#errorCaptcha").fadeIn(500);
		        $('#lcaptcha').focus();
		        return false;
		      } else {
		      	$('.wrap-loader').show();
		      	$(this).css('display','none');
    			$('.auth-social').css('display','none');
    			$('<div class="btn-block text-center"><i class="fa fa-cog fa-spin fa-3x fa-fw fa-loader"></i></div>').insertAfter('#signup_form');
   				$('#signup_form').submit();
		      }
    });
    
    @else
        	
	$('#buttonSubmitRegister').click(function(){
		$('.wrap-loader').show();
    	$(this).css('display','none');
    	$('.auth-social').css('display','none');
    	$('<div class="btn-block text-center"><i class="fa fa-cog fa-spin fa-3x fa-fw fa-loader"></i></div>').insertAfter('#signup_form');
    });
    
    @endif
    
    @if (count($errors) > 0)
    	scrollElement('#dangerAlert');
    @endif
    
    @if (session('notification'))
    	$('#signup_form, #dangerAlert').remove();
    @endif

</script>


@endsection
