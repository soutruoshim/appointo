<?php
/**
 * Created by PhpStorm.
 * User: DEXTER
 * Date: 24/05/17
 * Time: 11:29 PM
 */

namespace App\Traits;

use App\CompanySetting;
use App\SmtpSetting;
use Illuminate\Mail\MailServiceProvider;
use Illuminate\Support\Facades\Config;

trait SmtpSettings{

    public function setMailConfigs(){
        $smtpSetting = SmtpSetting::first();
        $settings = CompanySetting::first();
        $company = explode(' ',trim($settings->company_name));
        Config::set('mail.driver', $smtpSetting->mail_driver);
        Config::set('mail.host', $smtpSetting->mail_host);
        Config::set('mail.port', $smtpSetting->mail_port);
        Config::set('mail.username', $smtpSetting->mail_username);
        Config::set('mail.password', $smtpSetting->mail_password);
        Config::set('mail.encryption', $smtpSetting->mail_encryption);
        Config::set('mail.from.name', $smtpSetting->mail_from_name);
        Config::set('mail.from.address', $smtpSetting->mail_from_email);

        Config::set('app.name', $settings->company_name);

        Config::set('app.logo', $settings->logo_url);

        (new MailServiceProvider(app()))->register();
    }

}