<div class="row">
    <div class="col-md-12">
        <div class="row">
            <div class="col-12">
                <div class="row">
                    <div class="col-md-4">
                        <h6>@lang('app.dateRange')</h6>
                        <div id="reportmonth" class="form-group"
                            style="background: #fff; cursor: pointer; padding: 15px 20px; border: 1px solid #ccc;">
                            <i class="fa fa-calendar"></i>&nbsp;
                            <span>
                                <input type="text" readonly id="month_year" style="border: none; width: 88%" value="{{ \Carbon\Carbon::now()->isoFormat('MMMM, YYYY') }}">
                            </span> <i class="fa fa-caret-down pull-right"></i>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <h6>@lang('app.location')</h6>
                        <div id="" class="form-group"
                            style="background: #fff; cursor: pointer; padding: 10px 15px; border: 1px solid #ccc;">
                            <select class="form-control" style="width:100%; border: 1px solid #fdfeff; background: white;" selected name="sales_location" id="sales_location">
                                @foreach ($locations as $location)
                                    <option value="{{$location->id}}">{{$location->name}}</option>
                                @endforeach
                            </select>
                        </div>
                    </div>
                </div>
                <!-- Custom Tabs -->
                <div class="card">
                    <div class="card-header d-flex p-0">
                        <h3 class="card-title p-3">@lang('menu.salesReport')</h3>
                    </div>
                    <!-- /.card-header -->
                    <div class="card-body">
                        <div class="tab-content">
                            <div class="tab-pane active" id="tab_1">
                                <div id="sales-graph-container">
                                    <canvas id="salesChart" style="height: 400px !important"></canvas>
                                </div>

                                <hr>
                                <div class="table-responsive">

                                    <table id="salesTable" class="table" style="width: 100%">
                                        <thead>
                                            <tr>
                                                <th>@lang('app.service') #</th>
                                                <th>@lang('app.serviceName')</th>
                                                <th>@lang('app.customer')</th>
                                                <th>@lang('app.sales')</th>
                                                <th>@lang('app.amount')</th>
                                                <th>@lang('app.paid_on')</th>
                                            </tr>
                                        </thead>
                                    </table>

                                </div>

                            </div>
                            <!-- /.tab-content -->
                        </div>
                        <!-- /.card-body -->
                    </div>
                    <!-- ./card -->
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </div>
    </div>
</div>

@push('footer-js')
    <script>
        $(function() {
            $('#reportmonth').on('click', function () {
                $(this).find('input').datepicker('show')
            })

            $('#reportmonth input').datepicker({
                format: "MM, yyyy",
                language: "{{ $settings->locale }}",
                autoclose: true,
                viewMode: "months",
                minViewMode: "months"
            });

            function sales_cb(date, location) {
                chartRequest(
                    '{{ route("admin.reports.salesReportChart") }}',
                    {
                        month: moment(date).month()+1,
                        year: moment(date).year(),
                        location : location
                    },
                    'salesChart',
                    'sales-graph-container',
                    '@lang("app.sales")'
                );
                renderTable(
                    'salesTable',
                    '{!! route('admin.reports.salesTable') !!}',
                    {
                        month: moment(date).month()+1,
                        year: moment(date).year(),
                        location : location
                    },
                    [
                        { data: 'service_name', name: 'service_name' },
                        { data: 'customer_name', name: 'customer_name' },
                        { data: 'sales', name: 'sales' },
                        { data: 'amount', name: 'amount' },
                        { data: 'paid_on', name: 'paid_on' },
                    ]
                );
            }

            $('#reportmonth input').datepicker()
            .on('changeMonth', function(e) {
                sales_cb(e.date, $('#sales_location').val());
            });

            $('#sales_location').on('change', function(e){
                sales_cb(e.date, $(this).val());
            });

            sales_cb(moment().toISOString(), $('#sales_location').val());
        });
    </script>
@endpush
