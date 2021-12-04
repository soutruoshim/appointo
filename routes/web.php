<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Auth::routes();


// Admin routes
Route::group(['middleware' => 'auth'], function () {

    // Route::post('mark-notification-read', ['uses' => 'NotificationController@markAllRead'])->name('mark-notification-read');

    // Admin routes
    Route::group(
        ['namespace' => 'Admin', 'prefix' => 'account', 'as' => 'admin.'], function () {

        Route::post('business-services/store-images', 'BusinessServiceController@storeImages')->name('business-services.storeImages');
        Route::post('business-services/update-images', 'BusinessServiceController@updateImages')->name('business-services.updateImages');

        Route::get('coupons/data', 'CouponController@data')->name('coupons.data');

        Route::post('todo-items/update-todo-item', 'TodoItemController@updateTodoItem')->name('todo-items.updateTodoItem');

        Route::post('save-booking-times-field', 'SettingController@saveBookingTimesField')->name('save-booking-times-field');

        Route::resources(
            [
                'locations' => 'LocationController',
                'categories' => 'CategoryController',
                'business-services' => 'BusinessServiceController',
                'pages' => 'PageController',
                'settings' => 'SettingController',
                'booking-times' => 'BookingTimeController',
                'tax-settings' => 'TaxSettingController',
                'currency-settings' => 'CurrencySettingController',
                'language-settings' => 'LanguageSettingController',
                'email-settings' => 'SmtpSettingController',
                'theme-settings' => 'ThemeSettingController',
                'front-theme-settings' => 'FrontThemeSettingController',
                'customers' => 'CustomerController',
                'credential' => 'PaymentCredentialSettingController',
                'sms-settings' => 'SmsSettingController',
                'coupons' => 'CouponController',
                'sms-settings' => 'SmsSettingController',
                'todo-items' => 'TodoItemController',
                'deals' => 'DealController',
            ]
        );


        Route::post('selectLocation', 'DealController@selectLocation')->name('deals.selectLocation');
        Route::post('selectServices', 'DealController@selectServices')->name('deals.selectServices');
        Route::get('resetSelection', 'DealController@resetSelection')->name('deals.resetSelection');
        Route::post('makeDealWithMultipleLocation', 'DealController@makeDealWithMultipleLocation')->name('deals.makeDealWithMultipleLocation');
        Route::post('makeDeal', 'DealController@makeDeal')->name('deals.makeDeal');
        Route::post('makeDealMultipleLocation', 'DealController@makeDealMultipleLocation')->name('deals.makeDealMultipleLocation');


        Route::post('change-language/{code}', 'SettingController@changeLanguage')->name('changeLanguage');

        Route::post('change-language/{code}', 'SettingController@changeLanguage')->name('changeLanguage');
        Route::post('role-permission/add-role', 'RolePermissionSettingController@addRole')->name('role-permission.addRole');
        Route::post('role-permission/add-members/{role_id}', 'RolePermissionSettingController@addMembers')->name('role-permission.addMembers');
        Route::get('role-permission/get-members/{role_id}', 'RolePermissionSettingController@getMembers')->name('role-permission.getMembers');
        Route::get('role-permission/get-members-to-add/{id}', 'RolePermissionSettingController@getMembersToAdd')->name('role-permission.getMembersToAdd');
        Route::delete('role-permission/remove-member', 'RolePermissionSettingController@removeMember')->name('role-permission.removeMember');
        Route::get('role-permission/data', 'RolePermissionSettingController@data')->name('role-permission.data');
        Route::post('role-permission/toggleAllPermissions', 'RolePermissionSettingController@toggleAllPermissions')->name('role-permission.toggleAllPermissions');
        Route::resource('role-permission', 'RolePermissionSettingController');

        Route::put('change-language-status/{id}', 'LanguageSettingController@changeStatus')->name('language-settings.changeStatus');
        Route::get('smtp-settings/sent-test-email', ['uses' => 'SmtpSettingController@sendTestEmail'])->name('email-settings.sendTestEmail');
        Route::get('reports/earningTable', ['uses' => 'ReportController@earningTable'])->name('reports.earningTable');
        Route::post('reports/earningChart', ['uses' => 'ReportController@earningReportChart'])->name('reports.earningReportChart');
        Route::get('reports', ['uses' => 'ReportController@index'])->name('reports.index');

        Route::get('reports/salesTable', ['uses' => 'ReportController@salesTable'])->name('reports.salesTable');
        Route::get('reports/tabularTable', ['uses' => 'ReportController@tabularTable'])->name('reports.tabularTable');
        Route::post('reports/salesChart', ['uses' => 'ReportController@salesReportChart'])->name('reports.salesReportChart');

        /* Graphical reporting section  */
        Route::get('reports/userTypeChart', ['uses' => 'ReportController@userTypeChart'])->name('reports.userTypeChart');
        Route::get('reports/serviceTypeChart', ['uses' => 'ReportController@serviceTypeChart'])->name('reports.serviceTypeChart');
        Route::get('reports/bookingSourceChart', ['uses' => 'ReportController@bookingSourceChart'])->name('reports.bookingSourceChart');
        Route::post('reports/bookingPerDayChart', ['uses' => 'ReportController@bookingPerDayChart'])->name('reports.bookingPerDayChart');
        Route::post('reports/paymentPerDayChart', ['uses' => 'ReportController@paymentPerDayChart'])->name('reports.paymentPerDayChart');
        Route::post('reports/bookingPerMonthChart', ['uses' => 'ReportController@bookingPerMonthChart'])->name('reports.bookingPerMonthChart');
        Route::post('reports/paymentPerMonthChart', ['uses' => 'ReportController@paymentPerMonthChart'])->name('reports.paymentPerMonthChart');
        Route::post('reports/bookingPerYearChart', ['uses' => 'ReportController@bookingPerYearChart'])->name('reports.bookingPerYearChart');
        Route::post('reports/bookingPerYearChart', ['uses' => 'ReportController@bookingPerYearChart'])->name('reports.bookingPerYearChart');
        Route::post('reports/paymentPerYearChart', ['uses' => 'ReportController@paymentPerYearChart'])->name('reports.paymentPerYearChart');

        Route::get('reports/customer', ['uses' => 'ReportController@customer'])->name('reports.customer');
        Route::get('pos/select-customer', ['uses' => 'POSController@selectCustomer'])->name('pos.select-customer');
        Route::get('pos/search-customer', ['uses' => 'POSController@searchCustomer'])->name('pos.search-customer');
        Route::get('pos/filter-services', ['uses' => 'POSController@filterServices'])->name('pos.filter-services');
        Route::get('pos/addCart', ['uses' => 'POSController@addCart'])->name('pos.addCart');
        Route::post('pos/apply-coupon', ['uses' => 'POSController@applyCoupon'])->name('pos.apply-coupon');
        Route::post('pos/update-coupon', ['uses' => 'POSController@updateCoupon'])->name('pos.update-coupon');
        Route::resource('pos', 'POSController');

        Route::post('employee/changeRole', 'EmployeeController@changeRole')->name('employee.changeRole');
        Route::resource('employee', 'EmployeeController');
        Route::resource('employee-group', 'EmployeeGroupController');

        Route::resource('update-application', 'UpdateApplicationController');
        Route::resource('search', 'SearchController');

        Route::get('dashboard', 'ShowDashboard')->name('dashboard');

        Route::post('bookings/update-coupon', ['uses' => 'BookingController@updateCoupon'])->name('bookings.update-coupon');
        Route::post('multiStatusUpdate', ['uses' => 'BookingController@multiStatusUpdate'])->name('bookings.multiStatusUpdate');
        Route::post('sendReminder', ['uses' => 'BookingController@sendReminder'])->name('bookings.sendReminder');
        Route::post('bookings/{status?}', ['uses' => 'BookingController@index'])->name('bookings.index');
        Route::post('bookings/requestCancel/{id}', ['uses' => 'BookingController@requestCancel'])->name('bookings.requestCancel');
        Route::get('bookings/download/{id}', ['uses' => 'BookingController@download'])->name('bookings.download');
        Route::resources([
            'bookings' => 'BookingController',
            'profile' => 'ProfileController'
        ]);
    });

    Route::get('change-mobile', 'VerifyMobileController@changeMobile')->name('changeMobile');
    Route::post('/send-otp-code', 'VerifyMobileController@sendVerificationCode')->name('sendOtpCode');
    Route::post('/send-otp-code/account', 'VerifyMobileController@sendVerificationCode')->name('sendOtpCode.account');
    Route::post('/verify-otp-phone', 'VerifyMobileController@verifyOtpCode')->name('verifyOtpCode');
    Route::post('/verify-otp-phone/account', 'VerifyMobileController@verifyOtpCode')->name('verifyOtpCode.account');
    Route::get('/remove-session', 'VerifyMobileController@removeSession')->name('removeSession');
});

Route::group(
    ['namespace' => 'Front', 'as' => 'front.'], function () {
    Route::get('/', ['uses' => 'FrontController@index'])->name('index');

    Route::group(['middleware' => 'cookieRedirect'], function () {
        Route::get('/booking', ['uses' => 'FrontController@bookingPage'])->name('bookingPage');
        Route::get('/checkout', ['uses' => 'FrontController@checkoutPage'])->name('checkoutPage');
    });
    Route::get('/cart', ['uses' => 'FrontController@cartPage'])->name('cartPage');
    Route::get('/apply-coupon', ['uses' => 'FrontController@applyCoupon'])->name('apply-coupon');
    Route::get('/update-coupon', ['uses' => 'FrontController@updateCoupon'])->name('update-coupon');
    Route::get('/remove-coupon', ['uses' => 'FrontController@removeCoupon'])->name('remove-coupon');
    Route::get('/search', ['uses' => 'FrontController@searchServices'])->name('searchServices');
    Route::post('/add-or-update-product', ['uses' => 'FrontController@addOrUpdateProduct'])->name('addOrUpdateProduct');
    Route::post('/add-booking-details', ['uses' => 'FrontController@addBookingDetails'])->name('addBookingDetails');
    Route::post('/delete-product/{id}', ['uses' => 'FrontController@deleteProduct'])->name('deleteProduct');
    Route::post('/delete-front-product/{id}', ['uses' => 'FrontController@deleteProduct'])->name('deleteFrontProduct');
    Route::post('/update-cart', ['uses' => 'FrontController@updateCart'])->name('updateCart');
    Route::post('/check-user-availability', ['uses' => 'FrontController@checkUserAvailability'])->name('checkUserAvailability');
    Route::post('/grabDeal', ['uses' => 'FrontController@grabDeal'])->name('grabDeal');

    Route::post('/save-booking', ['uses' => 'FrontController@saveBooking'])->name('saveBooking');
    Route::group(['middleware' => 'mobileVerifyRedirect'], function () {
        Route::get('payment-gateway', array('as' => 'payment-gateway','uses' => 'FrontController@paymentGateway',));
        Route::get('offline-payment/{bookingId?}', array('as' => 'offline-payment','uses' => 'FrontController@offlinePayment',));
        Route::get('/payment-success/{paymentID?}', ['uses' => 'FrontController@paymentSuccess'])->name('payment.success');
        Route::get('/payment-fail/{paymentID?}', ['uses' => 'FrontController@paymentFail'])->name('payment.fail');
    });
    Route::post('/booking-slots', ['uses' => 'FrontController@bookingSlots'])->name('bookingSlots');
    Route::post('contact', ['uses' => 'FrontController@contact'])->name('contact');

    Route::get('paypal-recurring', array('as' => 'paypal-recurring','uses' => 'PaypalController@payWithPaypalRecurrring',));

    // route for view/blade file
    Route::get('paywithpaypal', array('as' => 'paywithpaypal','uses' => 'PaypalController@payWithPaypal',));
    // route for post request
    Route::get('paypal/{bookingId?}', array('as' => 'paypal','uses' => 'PaypalController@paymentWithpaypal',));
    // route for check status responce
    Route::get('paypal-status/{status?}', array('as' => 'status','uses' => 'PaypalController@getPaymentStatus',));

    Route::post('stripe/{bookingId?}', array('as' => 'stripe','uses' => 'StripeController@paymentWithStripe',));

    Route::post('razorpay', 'RazorPayController@paymentWithRazorpay')->name('razorpay');

    Route::post('change-language/{code}', 'FrontController@changeLanguage')->name('changeLanguage');

    Route::get('/{categorySlug}/{serviceSlug}', ['uses' => 'FrontController@serviceDetail'])->name('serviceDetail');

    Route::get('/deal/{dealId}/{dealSlug}', ['uses' => 'FrontController@dealDetail'])->name('dealDetail');

    Route::get('/{slug}', ['uses' => 'FrontController@page'])->name('page');
});
