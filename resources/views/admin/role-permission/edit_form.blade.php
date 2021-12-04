<form id="edit-role" data-role-id="{{ $role->id }}" class="ajax-form">
    @csrf
    @method('PUT')
    <div class="form-body">
        <h5>@lang('modules.rolePermission.editRole')</h5>
        <div class="row">
            <div class="col-sm-12 ">
                <div class="form-group">
                    <label>@lang('modules.rolePermission.forms.displayName')</label>
                    <input type="text" name="display_name" id="display_name" class="form-control" value="{{ $role->display_name }}">
                </div>
            </div>
            <div class="col-sm-12 ">
                <div class="form-group">
                    <label>@lang('modules.rolePermission.forms.description')</label>
                    <input type="text" name="description" id="description" class="form-control" value="{{ $role->description }}">
                </div>
            </div>
        </div>
    </div>
    <div class="form-actions">
        <button type="button" id="save-edit-role" class="btn btn-success"> <i class="fa fa-check"></i>
            @lang('app.update')</button>
        <button type="button" id="cancel-edit-role" class="btn btn-default"> <i class="fa fa-close"></i>
            @lang('app.cancel')</button>
    </div>
</form>
