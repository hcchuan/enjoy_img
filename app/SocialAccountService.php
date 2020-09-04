<?php

namespace App;
use App\Models\User;
use Laravel\Socialite\Contracts\User as ProviderUser;
class SocialAccountService
{
    public function createOrGetUser(ProviderUser $providerUser)
    {
        $account = User::whereOauthProvider('facebook')
            ->whereOauthUid($providerUser->getId())
            ->first();
        if ($account) {
            return $account->user;
        } else {

			if( !$providerUser->getEmail()) {

        return redirect("login")
					->with(array('login_required' => trans('error.error_fb_mail')));

				//return 'Error! Your email is required, Go to app settings and delete our app and try again';
				exit;
			}

			$user = User::whereEmail($providerUser->getEmail())->first();

            if (!$user) {

				$token = str_random(75);

				$user = User::create([
					'username'        => $providerUser->getId(),
					'name'        => $providerUser->getName(),
					'password'        => '',
					'email'           => strtolower($providerUser->getEmail()),
					'avatar'          => 'default.jpg',
					'cover'           => 'cover.jpg',
					'status'          => 'active',
					'type_account'    => '1',
          'website' => '',
					'activation_code' => '',
					'token'           => $token,
			]);

            }

            return $user;
        }
    }
}
