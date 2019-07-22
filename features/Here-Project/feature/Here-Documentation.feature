
  Feature: Validate documentation page

    Background:
      Given navigate to site

    Scenario Outline: Validate whether documentation page is loaded successfully
      And the page should load properly and return success status <status_code>
      Then check angular is initialized when page loads

      Examples:
        |status_code       |
        |200               |

    Scenario Outline: Validate the internal links for Global APIs and SDKs
      When navigate to internal links for Global APIs and SDKs <page_section>, <global_api_type>
      Then verify success status of internal links and Angular initialization when page loads <global_api_type>, <link>, <status_code>

      Examples:
        |page_section                     |global_api_type                                |link                                                             |status_code|
        |maps_section                     |INTERACTIVE MAPS                               |JS,Android Starter,Android Premium,iOS Starter,iOS Premium       |200        |
        |maps_section                     |MAP IMAGE                                      |Rest                                                             |200        |
        |maps_section                     |MAP TILE                                       |Rest                                                             |200        |
        |maps_section                     |VENUE MAPS                                     |Rest,iOS Premium,Android Premium                                 |200        |
        |maps_section                     |WEATHER                                        |Rest                                                             |200        |
        |maps_section                     |MAP FEEDBACK                                   |Rest,Mobile SDK,Web SDK                                          |200        |
        |maps_section                     |GEOSPATIAL DATA STORAGE & RENDERING WITH XYZ   |Documentation                                                    |200        |
        |search_and_geocoding_section     |GEOCODING                                      |Rest,JS,Android Starter,Android Premium,iOS Starter,iOS Premium  |200        |
        |search_and_geocoding_section     |GEOCODING AUTOCOMPLETE                         |Rest                                                             |200        |
        |search_and_geocoding_section     |BATCH GEOCODING                                |Rest                                                             |200        |
        |search_and_geocoding_section     |PLACES                                         |Rest,Android Starter,Android Premium,iOS Starter,iOS Premium     |200        |
        #ROUTING
        |routing_and_navigation_section   |ROUTING                                        |Rest,JS,Android Starter,Android Premium,iOS Starter,iOS Premium  |200        |
        #TRANSIT
        |routing_and_navigation_section   |TRANSIT                                        |Rest,Android Premium,iOS Premium                                 |200        |
        #INTERNALMODAL ROUTING
        |routing_and_navigation_section   |INTERNALMODAL ROUTING                          |Rest                                                             |200        |
        #TRAFFIC
        |routing_and_navigation_section   |TRAFFIC                                        |Rest,JS,Android Premium,iOS Premium                              |200        |
        #
        #fleet_telematics_section
        #FLEET TELEMATICS
        |fleet_telematics_section         |FLEET TELEMATICS                               |Rest                                                             |200        |
        #GEOFENCING
        |fleet_telematics_section         |GEOFENCING                                     |Rest,JS                                                          |200        |
        #CUSTOM LOCATIONS
        |fleet_telematics_section         |CUSTOM LOCATIONS                               |Rest,JS,Android Premium,iOS Premium                              |200        |
        #CUSTOM ROUTES
        |fleet_telematics_section         |CUSTOM ROUTES                                  |Rest                                                             |200        |
        #ADVANCED DATA SETS
        |fleet_telematics_section         |ADVANCED DATA SETS                             |Rest,JS,iOS Premium,Android Premium                              |200        |
        #ROUTE MATCHING
        |fleet_telematics_section         |ROUTE MATCHING                                 |Rest                                                             |200        |
        #TOLL COSTS
        |fleet_telematics_section         |TOLL COSTS                                     |Rest                                                             |200        |
        #WAYPOINTS SEQUENCE
        |fleet_telematics_section         |WAYPOINTS SEQUENCE                             |Rest                                                             |200        |
        #FLEET CONNECTIVITY
        |fleet_telematics_section         |FLEET CONNECTIVITY                             |Rest                                                             |200        |
        #
        #more_apis_and_sdks_section
        #TRACKING
        |more_apis_and_sdks_section       |TRACKING                                       |Rest                                                             |200        |
        #POSITIONING
        |more_apis_and_sdks_section       |POSITIONING                                    |Rest,Android Starter,Android Premium,iOS Starter,iOS Premium     |200        |
        |more_apis_and_sdks_section       |Geovisualization                               |Overview,Rest,JS                                                 |200        |
        #On-Demand
        |more_apis_and_sdks_section       |On-Demand                                      |Rest,Mobile SDK                                                  |200        |
        #Advertising Data Services
        |more_apis_and_sdks_section       |Advertising Data Services                      |Rest                                                             |200        |


    Scenario Outline: Validate the internal links for China specific APIs and SDKs
      When navigate to internal links for China specific APIs and SDKs <page_section>, <china_api_type>
      Then verify success status of internal links and Angular initialization when page loads <global_api_type>, <link>, <status_code>

      Examples:
        |page_section                     |china_api_type                                 |link                                                             |status_code|
        |maps_section                     |INTERACTIVE MAPS                               |JS                                                               |200        |
        |maps_section                     |MAP TILE                                       |Rest                                                             |200        |
        |search_and_geocoding_section     |GEOCODING                                      |Rest,JS                                                          |200        |
        |search_and_geocoding_section     |PLACES                                         |Rest                                                             |200        |
        |routing_and_navigation_section   |ROUTING                                        |Rest,JS                                                          |200        |
        |routing_and_navigation_section   |TRANSIT                                        |Rest                                                             |200        |
        |routing_and_navigation_section   |TRAFFIC                                        |Rest,JS                                                          |200        |
        |more_apis_and_sdks_section       |POSITIONING                                    |Rest                                                             |200        |



