@extends('layouts.master')

@section('content')
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-body">
                    @permission('create_business_service')
                    <div class="d-flex justify-content-center justify-content-md-end mb-3">
                        <a href="{{ route('admin.business-services.create') }}" class="btn btn-rounded btn-primary mb-1"><i class="fa fa-plus"></i> @lang('app.createNew')</a>
                    </div>
                    @endpermission
                    <div class="table-responsive">
                        <table id="myTable" class="table w-100">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>@lang('app.image')</th>
                                    <th>@lang('app.name')</th>
                                    <th>@lang('app.location')</th>
                                    <th>@lang('app.category')</th>
                                    <th>@lang('app.price')</th>
                                    <th>@lang('app.assign') @lang('app.employee')</th>
                                    <th>@lang('app.status')</th>
                                    <th>@lang('app.action')</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection

@push('footer-js')
    <script>
        $(document).ready(function() {
            var table = $('#myTable').dataTable({
                responsive: true,
                processing: true,
                serverSide: true,
                ajax: '{!! route('admin.business-services.index') !!}',
                language: languageOptions(),
                "fnDrawCallback": function( oSettings ) {
                    $("body").tooltip({
                        selector: '[data-toggle="tooltip"]'
                    });
                },
                order: [[0, 'DESC']],
                columns: [
                    { data: 'DT_RowIndex'},
                    { data: 'image', name: 'image' },
                    { data: 'name', name: 'name' },
                    { data: 'location_id', name: 'location_id' },
                    { data: 'category_id', name: 'category_id' },
                    { data: 'price', name: 'price' },
                    { data: 'users', name: 'users' },
                    { data: 'status', name: 'status' },
                    { data: 'action', name: 'action', width: '20%' }
                ]
            });
            new $.fn.dataTable.FixedHeader( table );

            $('body').on('click', '.delete-row', function(){
                var id = $(this).data('row-id');
                swal({
                    icon: "warning",
                    buttons: ["@lang('app.cancel')", "@lang('app.ok')"],
                    dangerMode: true,
                    title: "@lang('errors.areYouSure')",
                    text: "@lang('errors.deleteWarning')",
                })
                .then((willDelete) => {
                    if (willDelete) {
                        var url = "{{ route('admin.business-services.destroy',':id') }}";
                        url = url.replace(':id', id);

                        var token = "{{ csrf_token() }}";

                        $.easyAjax({
                            type: 'POST',
                            url: url,
                            data: {'_token': token, '_method': 'DELETE'},
                            success: function (response) {
                                if (response.status == "success") {
                                    $.unblockUI();
                                    // swal("Deleted!", response.message, "success");
                                    table._fnDraw();
                                }
                            }
                        });
                    }
                });
            });

            $('body').on('click', '.duplicate-row', function () {
                var id = $(this).data('row-id');

                var url = "{{ route('admin.business-services.create').'?service_id=:id' }}";
                url = url.replace(':id', id);
                location.href = url;
            })
        } );
    </script>
@endpush
