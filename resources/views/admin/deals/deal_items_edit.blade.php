<br>
<table class="table table-bordered table-condensed" width="100%" id="deal_table">
    <thead class="thead-dark">
        <tr>
            <th>@lang('app.service')</th>
            <th>@lang('app.unitPrice')</th>
            <th>@lang('app.quantity')</th>
            <th>@lang('app.subTotal')</th>
            <th>@lang('app.discount')</th>
            <th>@lang('app.total')</th>
            <th>#</th>
        </tr>
    </thead>

    @php $subTotal=0; $discount=0; $total=0; @endphp
    @foreach ($deal_items as $deal_item)
        <tr id="row{{$deal_item->businessService->id}}">
            <td><input type="hidden" name="deal_services[]" value="{{$deal_item->businessService->id}}">{{$deal_item->businessService->name}}</td>
            <td><input type="hidden" class="deal-price-{{$deal_item->businessService->id}}" name="deal_unit_price[]" value="{{$deal_item->unit_price}}">{{$settings->currency->currency_symbol}}  {{$deal_item->unit_price}}</td>
            <td style="width: 15%">
                <div class="input-group">
                    <div class="input-group-prepend">
                        <button type="button" class="btn btn-default quantity-minus" data-service-id="{{$deal_item->businessService->id}}"><i class="fa fa-minus"></i></button>
                    </div>
                    <input data-service-id="{{$deal_item->businessService->id}}" type="text" readonly name="deal_quantity[]" class="form-control deal-service-{{$deal_item->businessService->id}}" value="{{$deal_item->quantity}}">
                    <div class="input-group-append">
                        <button type="button" class="btn btn-default quantity-plus" data-service-id="{{$deal_item->businessService->id}}"><i class="fa fa-plus"></i></button>
                    </div>
                </div>
            </td>
            <td name="deal-subtotal[]" class="deal-subtotal-{{$deal_item->businessService->id}}">{{$settings->currency->currency_symbol}}{{$deal_item->unit_price*$deal_item->quantity}}</td>
            <td style="width: 15%">
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                    <span class="input-group-text" id="basic-addon1">{{$settings->currency->currency_symbol}}</span>
                    </div>
                    <input @if ($deal_item->deal->discount_type=="percentage") readonly @endif type="number" name="deal_discount[]" onkeypress="return isNumberKey(event)" class="form-control deal_discount" value="{{$deal_item->discount_amount}}">
                </div>
            </td>

            <td name="deal-total[]" class="deal-total-{{$deal_item->businessService->id}}">{{$settings->currency->currency_symbol}}{{$deal_item->total_amount}}</td>

            <td><a onclick="deleteRow({{$deal_item->businessService->id}}, '{{$deal_item->name}}')" href="javascript:;" class="btn btn-danger btn-sm btn-circle delete-cart-row" data-toggle="tooltip" data-original-title="Delete"><i class="fa fa-times" aria-hidden="true"></i></a></td>

        </tr>
        @php $subTotal += $deal_item->unit_price; @endphp
    @endforeach

    <tr>
        <td colspan="3"></td>
        <td id="deal-sub-total">{{$settings->currency->currency_symbol}}{{$deal_item->deal->original_amount}}</td>
        <td id="deal-discount-total">{{$settings->currency->currency_symbol}} {{$deal_item->deal->original_amount-$deal_item->deal->deal_amount}}</td>
        <td id="deal-total-price">{{$settings->currency->currency_symbol}}{{$deal_item->deal->deal_amount}}</td>
    </tr>
</table>


