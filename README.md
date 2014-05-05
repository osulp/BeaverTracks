# BeaverTracks

[![Build
Status](https://travis-ci.org/osulp/BeaverTracks.svg?branch=master)](https://travis-ci.org/osulp/BeaverTracks)

## Overview

BeaverTracks is a mobile website that provides information on historical locations and a walking tour of the Oregon State University campus in Corvallis, Oregon.

Building information and location data are stored in the database, and images on Flickr are pulled in via tags under the Special Collections and Archives Research Center's account.

If on campus, a walking tour can provide nearby locations on a map and directions to the next desired location.

## Setup

### Important Gems

* [flickraw-cached](http://hanklords.github.io/flickraw/)
* [gmaps4rails](https://github.com/apneadiving/Google-Maps-for-Rails)
* [RailsAdmin](https://github.com/sferik/rails_admin)

### API Accounts needed

* Flickr API
* Google Analytics

### Environment Variables

```
BEAVERTRACKS_FLICKR_API_KEY=
BEAVERTRACKS_FLICKR_SECRET=
BEAVERTRACKS_FLICKR_USER_ID=

BEAVERTRACKS_ADAPTER=mysql2
BEAVERTRACKS_DB_PREFIX=
BEAVERTRACKS_DB_USERNAME=
BEAVERTRACKS_DB_PASSWORD=
BEAVERTRACKS_DB_HOST=

BEAVERTRACKS_SECRET_KEY=
BEAVERTRACKS_DEVISE_KEY=

BEAVERTRACKS_GA_ID=
BEAVERTRACKS_GA_DOMAIN=
```

## Managing Content

### Buildings

Building information, including name, description, Flickr image URLs, etc. is managed via the RailsAdmin screens.
Current buildings (as of April 2014) are stored as fixtures, and can be loaded with: `rake db:fixtures:load`

#### Geocoding

To add a new building, the lat/long coordinates will need to be found. This can be done from the command line using Geocoder or some other method. https://github.com/alexreisner/geocoder#command-line-interface

### Photographs of Buildings

All Photographs are hosted on Flickr. Each building has a primary photo associated with it via direct Flickr image URL. 

Other images are included via a specific Flickr tag associated with a building, such as **Milam_Hall_Tour**. New images will be included when tagged appropriately on the Flickr account. 

### Users

Users can be added directly be the admin user or other users. User sign up is not enabled.


## Notes

### Directions

Directions are done via JavaScript accessing the Google Maps API directly, not using the gmaps4rails gem.
