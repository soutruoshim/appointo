@extends('layouts.master')

@push('head-css')
    <link rel="stylesheet" href="{{ asset('assets/css/bootstrap-datepicker3.css') }}">
    <style>
        .chart_menu_li {
            margin: 0 0 7px 0;
        }
        .chart_menu {
            margin-bottom: 14px;
            list-style: none;
            margin-left: -40px;
        }
        .chart_menu li a {
            display: block;
            margin: 0 0 7px 0;
            background: #F7F5F2 ;
            font-size: 12px;
            color: #333;
            padding: 7px 10px 7px 12px;
            text-decoration: none;
        }

        .chart_menu li a:hover{ background: #EFEFEF; }
        .orange{ border-left: 5px solid #fd7e14; }
        .yellow{ border-left: 5px solid #ffc107; }
        .green{ border-left: 5px solid #28a745; }
        .teal{ border-left: 5px solid #20c997; }
        .cyan{ border-left: 5px solid #17a2b8; }
        .white{ border-left: 5px solid #ffffff; }
        .gray{ border-left: 5px solid #6c757d; }
        .primary{ border-left: 5px solid #007bff; }
        .secondary{ border-left: 5px solid #6c757d; }
        .success{ border-left: 5px solid #28a745; }
        .info{ border-left: 5px solid #17a2b8; }
        .warning{ border-left: 5px solid #ffc107; }
        .danger{ border-left: 5px solid #dc3545; }
        .light{ border-left: 5px solid #f8f9fa; }
        .blue { border-left: 5px solid #007bff; }
        .indigo { border-left: 5px solid #6610f2; }
        .purple { border-left:5px solid  #6f42c1; }
        .pink { border-left: 5px solid #e83e8c; }
        .red { border-left: 5px solid #dc3545; }

        /* .select2-container--default .select2-selection--single {
            background-color: #fff;
            border: 1px solid #fff;
            border-radius: 4px;
        } */
        /* span#earning_report_location:nth-of-type(3) {
            border: none;
        } */

    </style>
@endpush

@section('content')
    <ul class="nav nav-tabs mb-5" id="myTab" role="tablist">
        <li class="nav-item">
            <a class="nav-link active" id="earning-tab" data-toggle="tab" href="#earning" role="tab" aria-controls="earning"
                aria-selected="true">@lang('menu.earningReport')</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" id="sales-tab" data-toggle="tab" href="#sales" role="tab" aria-controls="sales"
                aria-selected="false">@lang('menu.salesReport')</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" id="tabular-report-tab" data-toggle="tab" href="#tabular-report" role="tab" aria-controls="tabular-report" aria-selected="false">
                @lang('report.tabularReport')
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" id="graphical-report-tab" data-toggle="tab" href="#graphical-report" role="tab" aria-controls="graphical-report" aria-selected="false">
                @lang('report.graphReport')
            </a>
        </li>
    </ul>
    <div class="tab-content" id="myTabContent">
        <div class="tab-pane fade show active" id="earning" role="tabpanel" aria-labelledby="earning-tab">@include('admin.report.earning')</div>
        <div class="tab-pane fade" id="sales" role="tabpanel" aria-labelledby="sales-tab">@include('admin.report.sales')</div>
        <div class="tab-pane fade" id="tabular-report" role="tabpanel" aria-labelledby="tabular-report-tab">@include('admin.report.tabular-report')</div>
        <div class="tab-pane fade" id="graphical-report" role="tabpanel" aria-labelledby="tabular-report-tab">@include('admin.report.graphical-report')</div>
    </div>
@endsection

@push('footer-js')
    <script src="{{ asset('assets/js/bootstrap-datepicker.min.js') }}"></script>
    @if ($settings->locale !== 'en')
        <script src="{{ 'https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.8.0/locales/bootstrap-datepicker.'.$settings->locale.'.min.js' }}" charset="UTF-8"></script>
    @endif
    <script>
        const renderTable = (tableId, url, data, columns=[]) => {
            $("#"+tableId).dataTable().fnDestroy();
            const table = $("#"+tableId).dataTable({
                dom: 'Bfrtip',
                buttons: [
                    { extend: 'csvHtml5', text: '@lang("app.exportCSV")' }
                ],
                responsive: true,
                // processing: true,
                serverSide: true,
                ajax: {'url' : url,
                    "data": function ( d ) {
                        return $.extend( {}, d, data );
                    }
                },
                language: languageOptions(),
                "fnDrawCallback": function( oSettings ) {
                    $("body").tooltip({
                        selector: '[data-toggle="tooltip"]'
                    });
                },
                columns: [
                    { data: 'DT_RowIndex'},
                    ...columns
                ]
            });
            new $.fn.dataTable.FixedHeader( table );
        }

        const generateChart = (labels, data, chartId, label) => {
            const ctx = document.getElementById(chartId).getContext('2d');
            const labelArray = labels;
            const dataArray = data;

            const myChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: [...labelArray],
                    datasets: [{
                        label: label,
                        data: [...dataArray],
                        backgroundColor: 'rgba(153, 102, 255, 0.2)',
                        borderColor: 'rgba(153, 102, 255, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        yAxes: [{
                            ticks: {
                                beginAtZero:true
                            }
                        }]
                    }
                }
            });
        }

        const chartRequest = (url, data, chartId, containerId, label) => {
            let token = "{{ csrf_token() }}";

            $.easyAjax({
                type: 'POST',
                url: url,
                data: {...data, '_token': token},
                success: function (response) {
                    if (response.status == "success") {
                        $.unblockUI();
                        resetCanvas(chartId, containerId);
                        generateChart(response.labels, response.data, chartId, label);
                    }
                }
            });
        }

        const resetCanvas = (chartId, containerId) => {
            $('#'+chartId).remove(); // this is my <canvas> element
            $('#'+containerId).append('<canvas id="'+chartId+'" style="height: 400px !important"><canvas>');
            canvas = document.querySelector('#'+chartId);
            ctx = canvas.getContext('2d');
            ctx.canvas.width = $('#graph').width(); // resize to parent width
            ctx.canvas.height = $('#graph').height(); // resize to parent height
            var x = canvas.width/2;
            var y = canvas.height/2;
            ctx.font = '10pt Verdana';
            ctx.textAlign = 'center';
            ctx.fillText('This text is centered on the canvas', x, y);
        }
    </script>
@endpush
