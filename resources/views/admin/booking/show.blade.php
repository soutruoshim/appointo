<div class="row">
    <div class="col-md-12 text-right mt-2 mb-2">
        @if ($user->can('update_booking'))
        <button class="btn btn-sm btn-outline-primary edit-booking" data-booking-id="{{ $booking->id }}" type="button"><i class="fa fa-edit"></i> @lang('app.edit')</button>
        @endif
        @if ($user->roles()->withoutGlobalScopes()->first()->hasPermission('delete_booking'))
        <button class="btn btn-sm btn-outline-danger delete-row" data-row-id="{{ $booking->id }}" type="button"><i class="fa fa-times"></i> @lang('app.delete') @lang('app.booking')</button>
        @endif
        @if ($booking->status == 'pending')
            @if ($user->roles()->withoutGlobalScopes()->first()->hasPermission('create_booking') && $booking->date_time!='' && $booking->date_time->greaterThanOrEqualTo(\Carbon\Carbon::now()) )
            <a href="javascript:;" data-booking-id="{{ $booking->id }}" class="btn btn-outline-dark btn-sm send-reminder"><i class="fa fa-send"></i> @lang('modules.booking.sendReminder')</a>
            @endif
            @if ($user->roles()->withoutGlobalScopes()->first()->hasPermission('update_booking'))
            <button class="btn btn-sm btn-outline-danger cancel-row" data-row-id="{{ $booking->id }}" type="button"><i class="fa fa-times"></i> @lang('modules.booking.requestCancellation')</button>
            @endif
        @endif
    </div>

    <div class="col-md-12 text-center mb-3">
        <img src="{{ $booking->user->user_image_url }}" class="border img-bordered-sm img-circle" height="70em" width="70em">
        <h6 class="text-uppercase mt-2">{{ ucwords($booking->user->name) }}</h6>
    </div>

</div>

<div class="row">
    <div class="col-md-6 border-right"> <strong>@lang('app.email')</strong> <br>
        <p class="text-muted"><i class="icon-email"></i> {{ $booking->user->email ?? '--' }}</p>
    </div>
    <div class="col-md-6"> <strong>@lang('app.mobile')</strong> <br>
        <p class="text-muted"><i class="icon-mobile"></i> {{ $booking->user->mobile ? $booking->user->formatted_mobile : '--' }}</p>
    </div>
</div>
<hr>

@if ($booking->deal_id!='')
    <div class="row">
        <div class="col-md-12 border-right"> <strong>@lang('app.deal') @lang('app.name')</strong> <br>
            <a data-toggle="tooltip" data-original-title="@lang('app.view') @lang('app.deal')" href="{{ route('admin.deals.index') }}">{{$booking->deal->title}}</a>
        </div>
    </div>
    <hr>
    <div class="row">
        <div class="col-md-6 border-right"> <strong>@lang('app.deal') @lang('app.location')</strong> <br>
            <p> {{$booking->deal->location->name}} </p>
        </div>
        <div class="col-md-6 border-right"> <strong>@lang('app.deal') @lang('app.quantity')</strong> <br>
            <p> {{$booking->deal_quantity}} </p>
        </div>
    </div>
    <hr>
@endif


<div class="row">
    <div class="col-sm-4 border-right"> <strong>@lang('app.booking') @lang('app.date')</strong> <br>
        <p class="text-primary"><i class="icon-calendar"></i>
            @if ($booking->date_time != '')
                {{  \Carbon\Carbon::parse($booking->date_time)->translatedFormat($settings->date_format) }}
            @endif
        </p>
    </div>
    <div class="col-sm-4 border-right"> <strong>@lang('app.booking') @lang('app.time')</strong> <br>
        <p class="text-primary"><i class="icon-alarm-clock"></i>
            @if ($booking->date_time != '')
                {{ $booking->date_time->translatedFormat($settings->time_format) }}
            @endif
        </p>
    </div>
    <div class="col-sm-4"> <strong>@lang('app.booking') @lang('app.status')</strong> <br>
        <span class="text-uppercase small border
        @if($booking->status == 'completed') border-success text-success @endif
        @if($booking->status == 'pending') border-warning text-warning @endif
        @if($booking->status == 'approved') border-info text-info @endif
        @if($booking->status == 'in progress') border-primary text-primary @endif
        @if($booking->status == 'canceled') border-danger text-danger @endif
         badge-pill">{{ __('app.'.$booking->status) }}</span>
    </div>
</div>
<hr>

@if(count($booking->users)>0)
<div class="row">
    <div class="col-sm-12"> <strong>@lang('menu.employee') </strong> <br>
        <p class="text-primary" style="margin: 0.2em">
            @foreach ($booking->users as $user)
             &nbsp;&nbsp;&nbsp;  <i class="icon-user"></i> {{$user->name}}
            @endforeach
        </p>
    </div>
</div>
<hr>
@endif

<div class="row">
    <div class="col-md-12">
        <table class="table table-condensed">
            <thead class="bg-secondary">
            <tr>
                <th>#</th>
                <th>@lang('app.item')</th>
                <th>@lang('app.unitPrice')</th>
                <th>@lang('app.quantity')</th>
                <th class="text-right">@lang('app.amount')</th>
            </tr>
            </thead>
            <tbody>
            @foreach($booking->items as $key=>$item)
                <tr>
                    <td>{{ $key+1 }}.</td>
                    <td>{{ ucwords($item->businessService->name) }}</td>
                    <td>{{ $settings->currency->currency_symbol.number_format((float)$item->unit_price, 2, '.', '') }}</td>
                    <td>x{{ $item->quantity }}</td>
                    @if ($booking->deal_id!='')
                        <td class="text-right">{{ $settings->currency->currency_symbol.number_format((float)($item->unit_price  * $item->quantity), 2, '.', '')}} x {{$booking->deal_quantity}} = {{ $settings->currency->currency_symbol.number_format((float)($item->unit_price  * $item->quantity * $booking->deal_quantity), 2, '.', '')}}</td>
                    @else
                        <td class="text-right">{{ $settings->currency->currency_symbol.number_format((float)($item->businessService->discounted_price  * $item->quantity), 2, '.', '')}}</td>
                    @endif
                </tr>
            @endforeach
            </tbody>

        </table>
    </div>
    <div class="col-md-7 border-top">
        <div class="row">
            <div class="col-md-12">
                <table class="table table-condensed">
                    <tr class="h6">
                        <td class="border-top-0">@lang('modules.booking.paymentMethod')</td>
                        <td class="border-top-0 "><i class="fa fa-money"></i> {{ $booking->payment_gateway }}</td>
                    </tr>
                    <tr class="h6">
                        <td>@lang('modules.booking.paymentStatus')</td>
                        <td>
                            @if($booking->payment_status == 'completed')
                                <span class="text-success  font-weight-normal"><i class="fa fa-check-circle"></i> {{ __('app.'.$booking->payment_status) }}</span></td>
                            @endif
                            @if($booking->payment_status == 'pending')
                                <span class="text-warning font-weight-normal"><i class="fa fa-times-circle"></i> {{ __('app.'.$booking->payment_status) }}</span></td>
                            @endif
                    </tr>

                    @if ($commonCondition)
                    <tr>
                        <td colspan="2">
                            <div class="payment-type">
                                <h5>@lang('front.paymentMethod')</h5>
                                <div class="payments text-center">
                                    @if($credentials->stripe_status == 'active')
                                    <a href="javascript:;" id="stripePaymentButton" data-bookingId="{{ $booking->id }}" class="btn btn-custom btn-blue mb-2"><i class="fa fa-cc-stripe mr-2"></i>@lang('front.buttons.stripe')</a>
                                    @endif
                                    @if($credentials->paypal_status == 'active')
                                    <a href="{{ route('front.paypal', $booking->id) }}" class="btn btn-custom btn-blue mb-2"><i class="fa fa-paypal mr-2"></i>@lang('front.buttons.paypal')</a>
                                    @endif
                                    @if($credentials->razorpay_status == 'active')
                                    <a href="javascript:startRazorPayPayment();" class="btn btn-custom btn-blue mb-2"><i class="fa fa-card mr-2"></i>@lang('front.buttons.razorpay')</a>
                                    @endif
                                    @if($credentials->offline_payment == 1)
                                    <a href="{{ route('front.offline-payment', $booking->id) }}" class="btn btn-custom btn-blue mb-2"><i class="fa fa-money mr-2"></i>@lang('app.offline')</a>
                                    @endif
                                </div>
                            </div>
                        </td>
                    </tr>
                    @endif

                    @if($booking->status == 'completed')
                    <tr>
                        <td>
                            <a href="{{ route('admin.bookings.download', $booking->id) }}" class="btn btn-success btn-sm"><i class="fa fa-download"></i> @lang('app.download') @lang('app.receipt')</a>
                        </td>
                    </tr>
                    @endif
                </table>
            </div>
        </div>
    </div>
    <div class="col-md-5 border-top amountDetail">
        <div class="row">
            <div class="col-md-12">
                <table class="table table-condensed">
                    <tr class="h6">
                        <td class="border-top-0 text-right">@lang('app.subTotal')</td>
                        <td class="border-top-0">{{ $settings->currency->currency_symbol.number_format((float)$booking->original_amount, 2, '.', '') }}</td>
                    </tr>
                    @if($booking->discount > 0)
                    <tr class="h6">
                        <td class="text-right">@lang('app.discount')</td>
                        <td>{{ $settings->currency->currency_symbol.number_format((float)$booking->discount, 2, '.', '') }}</td>
                    </tr>
                    @endif

                    @if($booking->tax_amount > 0)
                    <tr class="h6">
                        <td class="text-right">{{ $booking->tax_name.' ('.$booking->tax_percent.'%)' }}</td>
                        <td>{{ $settings->currency->currency_symbol.number_format((float)$booking->tax_amount, 2, '.', '') }}</td>
                    </tr>
                    @endif

                    @if($booking->coupon_discount > 0)
                    <tr class="h6">
                        <td class="text-right" >@lang('app.couponDiscount') (<a href="javascript:;" onclick="showCoupon();" class="show-coupon">{{ $booking->coupon->title}}</a>)</td>
                        <td>{{ $settings->currency->currency_symbol.number_format((float)$booking->coupon_discount, 2, '.', '') }}</td>
                    </tr>
                    @endif
                    <tr class="h5">
                        <td class="text-right">@lang('app.total')</td>
                        <td>{{ $settings->currency->currency_symbol.number_format((float)$booking->amount_to_pay, 2, '.', '') }}</td>
                    </tr>
                </table>
            </div>
        </div>

    </div>

    @if(!is_null($booking->additional_notes))
    <div class="col-md-12 font-italic">
        <h4 class="text-info">@lang('modules.booking.customerMessage')</h4>
        <p class="text-lg">
            {!! $booking->additional_notes !!}
        </p>
    </div>
    @endif
    {{--coupon detail Modal--}}
    <div class="modal fade bs-modal-lg in" id="coupon-detail-modal" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" id="modal-data-application">
            <div class="modal-content">

                <div class="modal-header">
                    <h4 class="modal-title">@lang('app.coupon')</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                </div>
                <div class="modal-body">

                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> @lang('app.close')</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    {{--coupon detail Modal Ends--}}
</div>
<script>
    @if($booking->coupon_discount > 0)
        function showCoupon () {
            var url = '{{ route('admin.coupons.show', $booking->coupon_id)}}';
            $('#modelHeading').html('Show Coupon');
            $.ajaxModal('#coupon-detail-modal', url);
        }
    @endif
</script>
@if($credentials->stripe_status == 'active' && $commonCondition)
    <script>
        var token_triggered = false;
        var handler = StripeCheckout.configure({
            key: '{{ $credentials->stripe_client_id }}',
            image: '{{ $settings->logo_url }}',
            locale: 'auto',
            closed: function(data) {
                if (!token_triggered) {
                    $.easyUnblockUI('.statusSection');
                } else {
                    $.easyBlockUI('.statusSection');
                }
            },
            token: function(token) {
                token_triggered = true;
                // You can access the token ID with `token.id`.
                // Get the token ID to your server-side code for use.
                $.easyAjax({
                    url: '{{route('front.stripe', $booking->id)}}',
                    container: '#invoice_container',
                    type: "POST",
                    redirect: true,
                    data: {token: token, "_token" : "{{ csrf_token() }}"}
                })
            }
        });

        document.getElementById('stripePaymentButton').addEventListener('click', function(e) {
            // Open Checkout with further options:
            handler.open({
                name: '{{ $setting->company_name }}',
                amount: {{ $booking->amount_to_pay * 100 }},
                currency: '{{ $setting->currency->currency_code }}',
                email: "{{ $user->email }}"
            });
            $.easyBlockUI('.statusSection');
            e.preventDefault();
        });

        // Close Checkout on page navigation:
        window.addEventListener('popstate', function() {
            handler.close();
        });
    </script>
@endif

@if($credentials->razorpay_status == 'active' && $commonCondition)
    <script>
        var options = {
            "key": "{{ $credentials->razorpay_key }}", // Enter the Key ID generated from the Dashboard
            "amount": "{{ $booking->amount_to_pay * 100 }}", // Amount is in currency subunits. Default currency is INR. Hence, 50000 refers to 50000 paise or INR 500.
            "currency": "INR",
            "name": "{{ $booking->user->name }}",
            "description": "@lang('app.booking') @lang('front.headings.payment')",
            "image": "{{ $settings->logo_url }}",
            "handler": function (response){
                confirmRazorPayPayment(response.razorpay_payment_id, '{{ $booking->id }}', response);
            },
            "prefill": {
                "email": "{{ $booking->user->email }}",
                "contact": "{{ $booking->user->mobile }}"
            },
            "notes": {
                "booking_id": "{{ $booking->id }}"
            },
            "theme": {
                "color": "{{ $frontThemeSettings->primary_color }}"
            }
        };
        var rzp1 = new Razorpay(options);

        function startRazorPayPayment() {
            rzp1.open();
        }

        function confirmRazorPayPayment(paymentId, bookingId, response) {
            $.easyAjax({
                url: '{{ route('front.razorpay') }}',
                type: 'POST',
                data: {
                    _token: '{{ csrf_token() }}',
                    payment_id: paymentId,
                    booking_id: bookingId,
                    response: response
                },
                container: 'body',
                redirect: true
            });
        }

    </script>
@endif
