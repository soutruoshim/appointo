@extends('layouts.master')

@push('head-css')
<link rel="stylesheet" href="{{ asset('assets/plugins/iCheck/all.css') }}">
<style>
    .collapse.in{
        display: block;
    }
</style>
@endpush
@section('content')
    <div class="row">
        <div class="col-md-12">
            <div class="card card-dark">
                <div class="card-header">
                    <h3 class="card-title">@lang('app.edit') @lang('menu.coupon')</h3>
                </div>
                <!-- /.card-header -->
                <div class="card-body">
                    <form role="form" id="editForm"  class="ajax-form" method="POST">
                        @csrf
                        @method('PUT')
                        <div class="row">
                            <div class="col-md-12">
                                <!-- text input -->
                                <div class="form-group">
                                    <label>@lang('app.coupon') @lang('app.code') </label>
                                    <input type="text" class="form-control" name="title" value="{{ $coupon->title }}" autocomplete="off">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <!-- text input -->
                                <div class="form-group">
                                    <label>@lang('app.StartTime')</label>
                                    <input type="text" class="form-control" id="start_time" name="start_time"  value="{{  \Carbon\Carbon::parse($coupon->start_date_time)->format($settings->date_format.' '.$settings->time_format) }}" autocomplete="off">

                                    
                                </div>
                            </div>
                            <div class="col-md-6">
                                <!-- text input -->
                                <div class="form-group">
                                    <label>@lang('app.endTime')</label>
                                  
                                    <input type="text" class="form-control" id="end_time"  name="end_time"  value="{{  \Carbon\Carbon::parse($coupon->end_date_time)->format($settings->date_format.' '.$settings->time_format) }} " autocomplete="off">




                                </div>
                            </div>
                            <div class="col-md-6">
                                <!-- text input -->
                                <div class="form-group">
                                    <label>@lang('app.usesTime')</label>
                                    <input type="number" class="form-control" name="uses_time"  value="{{ $coupon->uses_limit }}">
                                    <span class="help-block">@lang('messages.howManyTimeUserCanUse')</span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <!-- text input -->
                                <div class="form-group">
                                    <label>@lang('app.amount')</label>
                                    <input type="number" class="form-control" name="amount"  value="{{ $coupon->amount }}">
                                    <span class="help-block">@lang('messages.coupon.forAmountDiscountOrMaximumDiscount')</span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <!-- text input -->
                                <div class="form-group">
                                    <label>@lang('app.percent')</label>
                                    <input type="number" class="form-control" name="percent"  value="{{ $coupon->percent }}">
                                    <span class="help-block">@lang('messages.coupon.forPercentDiscount')</span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <!-- text input -->
                                <div class="form-group">
                                    <label>@lang('app.minimumPurchaseAmount')</label>
                                    <input type="number" class="form-control" name="minimum_purchase_amount"   value="{{ $coupon->minimum_purchase_amount }}">
                                    <span class="help-block">@lang('messages.coupon.keepBlankForwithoutMinimumAmount')</span>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="row">
                                    <label style="margin-left: 10px">@lang('app.dayForApply') </label>

                                    @forelse($days as $day)
                                        <div class="form-group" style="margin-left: 20px">
                                            <label class="">
                                                <div class="icheckbox_flat-green" aria-checked="false" aria-disabled="false" style="position: relative; margin-right: 5px">
                                                    <input type="checkbox" @if(!is_null($selectedDays) && in_array($day, $selectedDays)) checked @endif value="{{$day}}" name="days[]" class="flat-red columnCheck"  style="position: absolute; opacity: 0;">
                                                    <ins class="iCheck-helper" style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: rgb(255, 255, 255); border: 0px; opacity: 0;"></ins>
                                                </div>
                                                @lang('app.'. strtolower($day))
                                            </label>
                                        </div>
                                    @empty
                                    @endforelse

                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="name">@lang('app.status')</label>
                                    <select name="status" class="form-control">
                                        <option @if($coupon->status == 'active') selected @endif value="active"> @lang('app.active') </option>
                                        <option @if($coupon->status == 'inactive') selected @endif value="inactive"> @lang('app.inactive') </option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label for="name">@lang('app.description')</label>
                                    <textarea name="description" id="description" cols="30" class="form-control-lg form-control" rows="4">{!! $coupon->description !!} </textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <button type="button" id="save-form" class="btn btn-success btn-light-round"><i
                                            class="fa fa-check"></i> @lang('app.save')</button>
                            </div>

                        </div>

                    </form>
                </div>
                <!-- /.card-body -->
            </div>
            <!-- /.card -->
        </div>
    </div>
@endsection

@push('footer-js')
<script src="{{ asset('assets/plugins/iCheck/icheck.min.js') }}"></script>
<script src="{{ asset('assets/js/collaps.js') }}"></script>
<script src="{{ asset('assets/js/transition.js') }}"></script>
<script>

    let startDate = '{{  \Carbon\Carbon::parse($coupon->start_date_time)->format("Y-m-d") }}';
    let endDate = '{{  \Carbon\Carbon::parse($coupon->end_date_time)->format("Y-m-d") }}';
    let startTime = '{{  \Carbon\Carbon::parse($coupon->start_date_time)->format("H:i a") }}';
    let endTime = '{{  \Carbon\Carbon::parse($coupon->end_date_time)->format("H:i a") }}';


    $('#customers').select2();

    $('#description').summernote({
        dialogsInBody: true,
        height: 300,
        toolbar: [
            // [groupName, [list of button]]
            ['style', ['bold', 'italic', 'underline', 'clear']],
            ['font', ['strikethrough']],
            ['fontsize', ['fontsize']],
            ['para', ['ul', 'ol', 'paragraph']],
            ["view", ["fullscreen"]]
        ]
    });

    $('#start_time').datetimepicker({
            format: '{{ $date_picker_format }} {{ $time_picker_format }}',
            locale: '{{ $settings->locale }}',
            icons: {
                time: "fa fa-clock-o",
                date: "fa fa-calendar",
                up: "fa fa-arrow-up",
                down: "fa fa-arrow-down",
                previous: "fa fa-angle-double-left",
                next: "fa fa-angle-double-right",
            },
            useCurrent: false,
        }).on('dp.change', function(e) {
            startDate =  moment(e.date).format('YYYY-MM-DD');
            startTime = convert(e.date);
        });

        $('#end_time').datetimepicker({
            format: '{{ $date_picker_format }} {{ $time_picker_format }}', 
            locale: '{{ $settings->locale }}',
            icons: {
                time: "fa fa-clock-o",
                date: "fa fa-calendar",
                up: "fa fa-arrow-up",
                down: "fa fa-arrow-down",
                previous: "fa fa-angle-double-left",
                next: "fa fa-angle-double-right",
            },
            useCurrent: false,
        }).on('dp.change', function(e) {
            endDate =  moment(e.date).format('YYYY-MM-DD');
            endTime = convert(e.date);
        });

    
    //Flat red color scheme for iCheck
    $('input[type="checkbox"].flat-red').iCheck({
        checkboxClass: 'icheckbox_flat-blue',
    })
    $('.dropify').dropify({
        messages: {
            default: '@lang("app.dragDrop")',
            replace: '@lang("app.dragDropReplace")',
            remove: '@lang("app.remove")',
            error: '@lang('app.largeFile')'
        }
    });
    $('#save-form').click(function () {
        $.easyAjax({
            url: '{{route('admin.coupons.update', $coupon->id)}}',
            container: '#editForm',
            type: "POST",
            redirect: true,
            data:$('#editForm').serialize()+'&startDate='+startDate+'&endDate='+endDate+'&startTime='+startTime+'&endTime='+endTime,
        })
    });

    function convert(str) 
    {
        var date = new Date(str);
        var hours = date.getHours();
        var minutes = date.getMinutes();
        var ampm = hours >= 12 ? 'pm' : 'am';
        hours = hours % 12;
        hours = hours ? hours : 12; // the hour '0' should be '12'
        minutes = minutes < 10 ? '0'+minutes : minutes;
        hours = ("0" + hours).slice(-2);
        var strTime = hours + ':' + minutes + ' ' + ampm;
        return strTime;
    }

</script>

@endpush
