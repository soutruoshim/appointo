<?php

namespace App\Http\Controllers\Admin;

use App\BusinessService;
use App\Category;
use App\Helper\Files;
use App\Helper\Reply;
use App\Http\Requests\Service\StoreService;
use App\Location;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Requests\Service\CreateService;
use App\User;
use Illuminate\Support\Arr;

class BusinessServiceController extends Controller
{
    public function __construct()
    {
        parent::__construct();
        view()->share('pageTitle', __('menu.services'));

    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        abort_if(!$this->user->roles()->withoutGlobalScopes()->first()->hasPermission('read_business_service'), 403);

        if(\request()->ajax()){
            $services = BusinessService::with('users')->get();

            return \datatables()->of($services)
                ->addColumn('action', function ($row) {
                    $action = '';

                    if ($this->user->roles()->withoutGlobalScopes()->first()->hasPermission('update_business_service')) {
                        $action.= '<a href="' . route('admin.business-services.edit', [$row->id]) . '" class="btn btn-primary btn-circle"
                          data-toggle="tooltip" data-original-title="'.__('app.edit').'"><i class="fa fa-pencil" aria-hidden="true"></i></a>';
                    }

                    if ($this->user->roles()->withoutGlobalScopes()->first()->hasPermission('create_business_service')) {
                        $action.= ' <a href="javascript:;" class="btn btn-warning btn-circle duplicate-row"
                        data-toggle="tooltip" data-row-id="' . $row->id . '" data-original-title="'.__('app.duplicate').'"><i class="fa fa-clone" aria-hidden="true"></i></a>';
                    }

                    if ($this->user->roles()->withoutGlobalScopes()->first()->hasPermission('delete_business_service')) {
                        $action.= ' <a href="javascript:;" class="btn btn-danger btn-circle delete-row"
                          data-toggle="tooltip" data-row-id="' . $row->id . '" data-original-title="'.__('app.delete').'"><i class="fa fa-times" aria-hidden="true"></i></a>';
                    }

                    return $action;
                })
                ->addColumn('image', function ($row) {
                    return '<img src="'.$row->service_image_url.'" class="img" height="65em" width="65em" /> ';
                })
                ->editColumn('name', function ($row) {
                    return ucfirst($row->name);
                })
                ->editColumn('status', function ($row) {
                    if($row->status == 'active'){
                        return '<label class="badge badge-success">'.__("app.active").'</label>';
                    }
                    elseif($row->status == 'deactive'){
                        return '<label class="badge badge-danger">'.__("app.deactive").'</label>';
                    }
                })
                ->editColumn('location_id', function ($row) {
                    return ucfirst($row->location->name);
                })
                ->editColumn('category_id', function ($row) {
                    return ucfirst($row->category->name);
                })
                ->editColumn('price', function ($row) {
                    return $row->price;
                })
                ->editColumn('users', function ($row) {
                        $user_list = '';
                        foreach ($row->users as $key => $user) {
                            $user_list .= '<span style="margin:0.3em; padding:0.3em" class="badge badge-primary">'.$user->name.'</span>';
                        }
                        return $user_list=='' ? '--' : $user_list;
                })
                ->addIndexColumn()
                ->rawColumns(['action', 'image', 'status', 'users'])
                ->toJson();
        }

        return view('admin.business_service.index');
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(CreateService $request)
    {
        abort_if(!$this->user->roles()->withoutGlobalScopes()->first()->hasPermission('create_business_service'), 403);

        $categories = Category::orderBy('name', 'ASC')->get();
        $locations = Location::orderBy('name', 'ASC')->get();

        $variables = compact('categories', 'locations');

        if ($request->service_id) {
            $service = BusinessService::where('id', $request->service_id)->first();
            $variables = Arr::add($variables, 'service', $service);
        }

        $employees = User::AllEmployees()->get();

        $variables = Arr::add($variables, 'employees', $employees);

        return view('admin.business_service.create', $variables);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(StoreService $request)
    {
        abort_if(!$this->user->roles()->withoutGlobalScopes()->first()->hasPermission('create_business_service'), 403);

        $service = new BusinessService();
        $service->name = $request->name;
        $service->description = $request->description;
        $service->price = $request->price;
        $service->time = $request->time;
        $service->time_type = $request->time_type;
        $service->discount = $request->discount;
        $service->discount_type = $request->discount_type;
        $service->location_id = $request->location_id;
        $service->category_id = $request->category_id;
        $service->slug = $request->slug;
        $service->save();

        $service->slug = $request->employee_ids;

        /* Assign services to users */
        $employee_ids = $request->employee_ids;
        if($employee_ids)
        {
            $employees   = array();
            foreach ($employee_ids as $key => $service_id)
            {
                $employees[] = $employee_ids[$key];
            }
            $service->users()->attach($employees);
        }

        return Reply::dataOnly(['serviceID' => $service->id]);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit(BusinessService $businessService)
    {
        abort_if(!$this->user->roles()->withoutGlobalScopes()->first()->hasPermission('update_business_service'), 403);

        $categories = Category::orderBy('name', 'ASC')->get();
        $locations = Location::orderBy('name', 'ASC')->get();

        $images = [];
        if ($businessService->image) {
            foreach ($businessService->image as $image) {
                $reqImage['name'] = $image;
                $reqImage['size'] = filesize(public_path('/user-uploads/service/'.$businessService->id.'/'.$image));
                $reqImage['type'] = mime_content_type(public_path('/user-uploads/service/'.$businessService->id.'/'.$image));
                $images[] = $reqImage;
            }
        }
        $images = json_encode($images);

         /* push all previous assigned services to an array */
         $selectedUsers = array();
         $users = BusinessService::with(['users'])->find($businessService->id);
         foreach ($users->users as $key => $user)
         {
             array_push($selectedUsers, $user->id);
         }
        $employees = User::AllEmployees()->get();

        return view('admin.business_service.edit', compact('businessService', 'categories', 'locations', 'images', 'employees', 'selectedUsers'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(StoreService $request, $id)
    {
        abort_if(!$this->user->roles()->withoutGlobalScopes()->first()->hasPermission('update_business_service'), 403);

        $service = BusinessService::find($id);
        $service->name = $request->name;
        $service->description = $request->description;
        $service->price = $request->price;
        $service->time = $request->time;
        $service->time_type = $request->time_type;
        $service->discount = $request->discount;
        $service->discount_type = $request->discount_type;
        $service->category_id = $request->category_id;
        $service->location_id = $request->location_id;
        $service->status = $request->status;
        $service->slug = $request->slug;
        $service->save();

        $employee_ids = $request->employee_ids;
        if($employee_ids)
        {
            $employees   = array();
            foreach ($employee_ids as $key => $service_id)
            {
                $employees[] = $employee_ids[$key];
            }
            $service->users()->sync($employees);
        }
        else{
            $service->users()->detach();
        }

        return Reply::dataOnly(['serviceID' => $service->id, 'defaultImage' => $request->default_image ?? 0]);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        abort_if(!$this->user->roles()->withoutGlobalScopes()->first()->hasPermission('delete_business_service'), 403);

        BusinessService::destroy($id);
        return Reply::success(__('messages.recordDeleted'));
    }

    public function storeImages(Request $request) {
        if ($request->hasFile('file')) {
            $service = BusinessService::where('id', $request->service_id)->first();
            $service_images_arr = [];

            foreach ($request->file as $fileData) {
                array_push($service_images_arr, Files::upload($fileData, 'service/'.$service->id));
            }
            $service->image = json_encode($service_images_arr);
            $service->default_image = $service_images_arr[0];
            $service->save();
        }

        return Reply::redirect(route('admin.business-services.index'), __('messages.createdSuccessfully'));
    }

    public function updateImages(Request $request) {
        $service = BusinessService::where('id', $request->service_id)->first();

        $service_images_arr = [];
        $default_image_index = 0;

        if ($request->hasFile('file')) {
            if ($request->file[0]->getClientOriginalName() !== 'blob') {
                foreach ($request->file as $fileData) {
                    array_push($service_images_arr, Files::upload($fileData, 'service/'.$service->id));
                    if ($fileData->getClientOriginalName() == $request->default_image) {
                        $default_image_index = array_key_last($service_images_arr);
                    }
                }
            }
            if ($request->uploaded_files) {
                $files = json_decode($request->uploaded_files, true);
                foreach ($files as $file) {
                    array_push($service_images_arr, $file['name']);
                    if ($file['name'] == $request->default_image) {
                        $default_image_index = array_key_last($service_images_arr);
                    }
                }
                $arr_diff = array_diff($service->image, $service_images_arr);

                if (sizeof($arr_diff) > 0) {
                    foreach ($arr_diff as $file) {
                        Files::deleteFile($file, 'service/'.$service->id);
                    }
                }
            }
            else {
                if (!is_null($service->image) && sizeof($service->image) > 0) {
                    Files::deleteFile($service->image[0], 'service/'.$service->id);
                }
            }
        }

        $service->image = json_encode(array_values($service_images_arr));
        $service->default_image = sizeof($service_images_arr) > 0 ? $service_images_arr[$default_image_index] : null;
        $service->save();

        return Reply::redirect(route('admin.business-services.index'), __('messages.updatedSuccessfully'));
    }
}
