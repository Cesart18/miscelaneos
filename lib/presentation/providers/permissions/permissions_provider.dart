import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final permissionsProvider = StateNotifierProvider<PermissionsNotifier, PermissionsState>((ref) {
  return PermissionsNotifier();
});

class PermissionsNotifier extends StateNotifier<PermissionsState> {
  PermissionsNotifier(): super(PermissionsState()){
    checkPermissions();
  }

  bool isAndroid = Platform.isAndroid;

  Future<void> checkPermissions() async {
    final permissionsArray = await Future.wait([
      Permission.camera.status,
      (isAndroid)? Permission.storage.status
      : Permission.photos.status,
      Permission.sensors.status,

      Permission.location.status,
      Permission.locationAlways.status,
      Permission.locationWhenInUse.status,
    ]);

    state = state.copyWith(
      camera           : permissionsArray[0],
      photoLibrary     : permissionsArray[1],
      sensors          : permissionsArray[2],

      locations        : permissionsArray[3],
      locationAlways   : permissionsArray[4],
      locationWhenInUse: permissionsArray[5],
    );
  }

  openSettingsScreen(){
    openAppSettings();
  }

  void _checkPermissionState( PermissionStatus status ){
    if( status == PermissionStatus.permanentlyDenied ){
      openSettingsScreen();
    }
  }

  requestCameraAccess() async {
    final status = await Permission.camera.request();
    state = state.copyWith(camera: status);

    _checkPermissionState(status);
  }
  requestPhotoLibraryAccess() async {
    final statusAndroid = await Permission.storage.request();
    final statusIos = await Permission.photos.request();
    state = state.copyWith(photoLibrary: (isAndroid)? statusAndroid : statusIos);

    _checkPermissionState((isAndroid)? statusAndroid : statusIos);
  }
  requestSensorsAccess() async {
    final status = await Permission.sensors.request();
    state = state.copyWith(sensors: status);

    _checkPermissionState(status);
  }



  requestLocationsAccess() async {
    final status = await Permission.location.request();
    state = state.copyWith(locations: status);

    _checkPermissionState(status);
  }
  
}



class PermissionsState {
  final PermissionStatus camera;
  final PermissionStatus photoLibrary;
  final PermissionStatus sensors;

  final PermissionStatus locations;
  final PermissionStatus locationAlways;
  final PermissionStatus locationWhenInUse;

  PermissionsState({
      this.camera            = PermissionStatus.denied,
      this.photoLibrary      = PermissionStatus.denied,
      this.sensors           = PermissionStatus.denied,
      this.locations         = PermissionStatus.denied,
      this.locationAlways    = PermissionStatus.denied,
      this.locationWhenInUse = PermissionStatus.denied
      });

      get cameraGranted{
        return camera == PermissionStatus.granted;
      }
      get photoLibraryGranted{
        return photoLibrary == PermissionStatus.granted;
      }
      get sensorsGranted{
        return sensors == PermissionStatus.granted;
      }
      get locationsGranted{
        return locations == PermissionStatus.granted;
      }
      get locationAlwaysGranted{
        return locationAlways == PermissionStatus.granted;
      }
      get locationWhenInUseGranted{
        return locationWhenInUse == PermissionStatus.granted;
      }


  PermissionsState copyWith({
    PermissionStatus? camera,
    PermissionStatus? photoLibrary,
    PermissionStatus? sensors,
    PermissionStatus? locations,
    PermissionStatus? locationAlways,
    PermissionStatus? locationWhenInUse,
  }) => 
      PermissionsState(
    camera            : camera ?? this.camera,
    photoLibrary      : photoLibrary ?? this.photoLibrary,
    sensors           : sensors ?? this.sensors,
    locations         : locations ?? this.locations,
    locationAlways    : locationAlways ?? this.locationAlways,
    locationWhenInUse : locationWhenInUse ?? this.locationWhenInUse,
  );
}
