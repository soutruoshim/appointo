<?php

namespace App\Http\Requests\Pos;

use App\Http\Requests\CoreRequest;

class StorePos extends CoreRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'user_id' => 'required',
            'payment_gateway' => 'required',
            'time' => 'required',
            'date' => 'required',
            // 'date' => 'required|date_format:"'.$this->settings->date_format.'"',
        ];
    }
}
