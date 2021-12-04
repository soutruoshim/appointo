<?php

namespace App\Http\Controllers\Admin;

use App\BookingTime;
use App\CompanySetting;
use App\Currency;
use App\Helper\Formats;
use App\Helper\Files;
use App\Helper\Reply;
use App\Language;
use App\Media;
use App\PaymentGatewayCredentials;
use App\SmtpSetting;
use App\TaxSetting;
use GuzzleHttp\Client;
use App\Http\Controllers\Controller;
use App\Http\Requests\Setting\UpdateSetting;
use App\Module;
use App\Permission;
use App\Role;
use App\SmsSetting;
use Carbon\Carbon;
use Illuminate\Support\Facades\File;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class SettingController extends Controller
{
    public function __construct()
    {
        parent::__construct();
        view()->share('pageTitle', __('menu.settings'));

    }

    public function index(){
        abort_if(!$this->user->roles()->withoutGlobalScopes()->first()->hasPermission('manage_settings'), 403);

        $bookingTimes = BookingTime::all();
        $images = Media::select('id', 'file_name')->latest()->get();
        $tax = TaxSetting::first();
        $timezones = \DateTimeZone::listIdentifiers(\DateTimeZone::ALL);
        $dateFormats = Formats::dateFormats();
        $timeFormats = Formats::timeFormats();
        $dateObject = Carbon::now($this->settings->timezone);
        $currencies = Currency::all();
        $enabledLanguages = Language::where('status', 'enabled')->orderBy('language_name')->get();
        $smtpSetting = SmtpSetting::first();
        $credentialSetting = PaymentGatewayCredentials::first();
        $smsSetting = SmsSetting::first();
        $roles = Role::where('name', '<>', 'administrator')->get();
        $totalPermissions = Permission::count();
        $modules = Module::all();

        $client = new Client();
        $res = $client->request('GET', config('froiden_envato.updater_file_path'), ['verify' => false]);
        $lastVersion = $res->getBody();
        $lastVersion = json_decode($lastVersion, true);
        $currentVersion = File::get('version.txt');

        $description = $lastVersion['description'];

        $newUpdate = 0;
        if (version_compare($lastVersion['version'], $currentVersion) > 0)
        {
            $newUpdate = 1;
        }
        $updateInfo = $description;
        $lastVersion = $lastVersion['version'];

        $appVersion = File::get('version.txt');
        $laravel = app();
        $laravelVersion = $laravel::VERSION;

        return view('admin.settings.index', compact('bookingTimes', 'images', 'tax', 'timezones', 'dateFormats', 'timeFormats', 'dateObject', 'currencies', 'enabledLanguages', 'smtpSetting', 'lastVersion', 'updateInfo', 'appVersion', 'laravelVersion', 'newUpdate', 'credentialSetting', 'smsSetting', 'roles', 'totalPermissions', 'modules'));
    }

    public function update(UpdateSetting $request, $id){
        abort_if(!$this->user->roles()->withoutGlobalScopes()->first()->hasPermission('manage_settings'), 403);

        $setting = CompanySetting::first();
        $setting->company_name = $request->company_name;
        // $setting->multi_task_user = $request->multi_task_user;
        $setting->company_email = $request->company_email;
        $setting->company_phone = $request->company_phone;
        $setting->address = $request->address;
        $setting->date_format = $request->date_format;
        $setting->time_format = $request->time_format;
        $setting->website = $request->website;
        $setting->timezone = $request->timezone;
        $setting->locale = $request->input('locale');
        $setting->currency_id = $request->currency_id;
        if ($request->hasFile('logo')) {
            $setting->logo = Files::upload($request->logo,'logo');
        }
        $setting->save();

        if ($setting->currency->currency_code !== 'INR') {
            $credential = PaymentGatewayCredentials::first();

            if ($credential->razorpay_status == 'active') {
                $credential->razorpay_status = 'deactive';

                $credential->save();
            }
        }
        return Reply::redirect(route('admin.settings.index'), __('messages.updatedSuccessfully'));
    }

    public function changeLanguage($code)
    {
        $language = Language::where('language_code', $code)->first();

        if ($language) {
            $this->settings->locale = $code;
        }
        else if ($code == 'en') {
            $this->settings->locale = 'en';
        }

        $this->settings->save();

        return Reply::success(__('messages.languageChangedSuccessfully'));
    }

    public function saveBookingTimesField(Request $request)
    {

        $booking_per_day = is_null($request->no_of_booking_per_customer) ? 0 : $request->no_of_booking_per_customer;

        $setting = CompanySetting::first();

        $setting->booking_per_day       = $booking_per_day;
        $setting->multi_task_user       = $request->multi_task_user;
        $setting->employee_selection    = $request->employee_selection;
        $setting->disable_slot          = $request->disable_slot;
        $setting->booking_time_type     = $request->booking_time_type;
        $setting->save();

        if($request->disable_slot=='enabled'){
            DB::table('payment_gateway_credentials')->where('id', 1)->update(['show_payment_options' => 'hide', 'offline_payment' => 1]);
        }

        return Reply::success(__('messages.updatedSuccessfully'));
    }





}
