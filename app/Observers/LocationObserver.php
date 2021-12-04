<?php

namespace App\Observers;

use App\Helper\SearchLog;
use App\Location;

class LocationObserver
{
    public function created(Location $location)
    {
        SearchLog::createSearchEntry($location->id, 'Location', $location->name, 'admin.locations.edit');

    }

    public function updating(Location $location)
    {
        SearchLog::updateSearchEntry($location->id, 'Location', $location->name, 'admin.locations.edit');
    }

    public function deleted(Location $location)
    {
        SearchLog::deleteSearchEntry($location->id, 'admin.locations.edit');
    }
}
