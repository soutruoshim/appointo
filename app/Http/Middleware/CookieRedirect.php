<?php

namespace App\Http\Middleware;

use App\Helper\Reply;
use Closure;

class CookieRedirect
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {

        if ($request->hasCookie('deal')){
            return $next($request);
        }

        if (!$request->hasCookie('products')) {
            if ($request->ajax()) {
                return response(Reply::error(__('messages.front.errors.atleastOneProduct')));
            }
            else {
                return redirect()->route('front.index');
            }
        }

        if (!$request->hasCookie('bookingDetails') && $request->route()->getName() !== 'front.bookingPage') {
            return redirect()->route('front.bookingPage');
        }

        return $next($request);
    }
}
