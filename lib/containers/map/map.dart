import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart' 
show MapView, MapOptions, MapViewType, CameraPosition, ToolbarAction, Marker;
import 'package:location/location.dart';

import '../../utils/composite_subs.dart';

// object that handles the map library events
class LocationMap{

  static final _mapView = new MapView();
  
  static show(initialPos){
    MapView.setApiKey("AIzaSyBqzm80H-5TfS2jtGyM5F6dTMnyE0UCsKU"); // library api key
    MapOptions options = new MapOptions(
      mapViewType: MapViewType.normal,
      showUserLocation: true,
      initialCameraPosition: new CameraPosition(initialPos, 6.0)
    );
    // show map view 
    _mapView.show(
      options,
      toolbarActions: [
        new ToolbarAction("Close", 1),
        new ToolbarAction("Get Location", 2)
      ]
    );
    // subscribe to map events
    CompositeSubscription.add(
      _mapView.onToolbarAction.listen((id) {
        if (id == 1) _closeMap();
        if (id == 2){
          _getCurrentLocation().then( (result){
            print(result);
            _mapView.addMarker(new Marker("1", "Home", result["latitude"], result["longitude"], color: Colors.purple));
            _mapView.setCameraPosition(result["latitude"], result["longitude"], 12.0);
          } )
          .catchError( (err) => print('error: $err') );
        }
      })
    );
    
  }

  static _closeMap(){
    _mapView.dismiss();
    CompositeSubscription.cancel();
  }

  static _getCurrentLocation() async => await new Location().getLocation;
}