import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:aveo_api/aveo_api.dart';
import 'package:background_location/background_location.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sales/app/data/location_params.dart';
import 'package:sales/app/modules/auth/controllers/auth_controller.dart';
import 'package:sales/app/modules/home/repository/location_repository.dart';
import 'package:sales/constants/assets.dart';
import 'package:sales/utils/get_storage.dart';

class LocationController extends GetxController with StateMixin<String> {
  Timer? apiTimer;
  Timer? locationTimer;
  bool _initCall = true;
  Location? _lastSentLocation;
  final Duration _apiTimerDuration = const Duration(minutes: 15);
  final Duration _locationTimerDuration = const Duration(seconds: 5);
  final int _refreshLocationDuration =
      const Duration(minutes: 5).inMilliseconds;
  final double _minDistanceDelta = 10;
  Rx<Location?> currentLocation = Rx<Location?>(null);
  Rx<ServiceStatus?> serviceStatus = Rx<ServiceStatus?>(null);
  PermissionStatus? permissionStatus;

  @override
  void onReady() {
    _startLocationTimer();
    change('', status: RxStatus.loading());
    _startLocationTracker();
    _sendLostData();
    super.onReady();
  }

  _startLocationTimer() {
    locationTimer = Timer.periodic(_locationTimerDuration, (_) async {
      serviceStatus.value =
          (await Permission.location.serviceStatus) == ServiceStatus.enabled ||
                  (await Permission.locationAlways.serviceStatus) ==
                      ServiceStatus.enabled ||
                  (await Permission.locationWhenInUse.serviceStatus) ==
                      ServiceStatus.enabled
              ? ServiceStatus.enabled
              : ServiceStatus.disabled;
      if (permissionStatus == PermissionStatus.granted ||
          permissionStatus == PermissionStatus.limited) {
        if (serviceStatus.value == ServiceStatus.disabled) {
          change('_',
              status: RxStatus.error(
                  '😱 Seems like your location is turned off, turn it ON for work hour management'));
        } else {
          change(
              'Your location will be tracked, do not close the application while on clock',
              status: RxStatus.success());
        }
      }
    });
  }

  void _sendLostData() {
    CLStatus.instance.isConnected.addListener(() {
      String lostDataString = Storage.read('lostData') ?? '';
      if (lostDataString.trim().isNotEmpty) {
        List<Map<String, dynamic>> lostData =
            lostDataString.split('|').map<Map<String, dynamic>>((e) {
          try {
            return json.decode(e);
          } catch (_) {
            return {};
          }
        }).toList();
        lostData.removeWhere((element) => element == {});
        List<Map<String, dynamic>> tempList = lostData;
        lostData.forEach((element) async {
          await LocationRepository.sendLocation(
            params: element,
            onSuccess: (_, data) {
              tempList.remove(element);
              String tempString = '';
              tempList.forEach((item) {
                tempString = '$tempString|${json.encode(item)}';
              });
              log('inserted offline data tempString: $tempString');
              Storage.write('lostData', tempString);
              change(
                  'Your location will be tracked, do not close the application while on clock',
                  status: RxStatus.success());
            },
            onError: (statusCode, data) {},
          );
        });
      }
    });
  }

  void _submitLocationData() {
    if (CLStatus.instance.isConnected.value && _initCall) {
      _initCall = false;
      _locationApiCall();
      apiTimer = Timer.periodic(_apiTimerDuration, (_) {
        _locationApiCall();
      });
    } else if (_initCall) {
      CLStatus.instance.isConnected.addListener(() {
        if (CLStatus.instance.isConnected.value && _initCall) {
          _locationApiCall();
          apiTimer = Timer.periodic(_apiTimerDuration, (_) {
            _locationApiCall();
          });
          _initCall = false;
        }
      });
    }
  }

  void _locationApiCall() async {
    // double distance = _calculateDistance();
    // if (distance > _minDistanceDelta)

    _lastSentLocation = currentLocation.value;
    if (_lastSentLocation == null) {
      return;
    }
    Map<String, dynamic> locationParams = LocationParams(
            username: AuthController.to.user.value!.userName,
            latitude: _lastSentLocation!.latitude!.toString(),
            longitude: _lastSentLocation!.longitude!.toString(),
            timestamp: DateTime.now().toIso8601String())
        .toJson();

    serviceStatus.value = await Permission.location.serviceStatus;

    if (CLStatus.instance.isConnected.value == false) {
      String lostData = Storage.read('lostData') ?? '';
      lostData = lostData.isEmpty
          ? json.encode(locationParams)
          : '$lostData|${json.encode(locationParams)}';
      Storage.write('lostData', lostData);
      return;
    }
    LocationRepository.sendLocation(
      params: locationParams,
      onSuccess: (_, data) {
        if (serviceStatus.value == ServiceStatus.disabled) {
          Fluttertoast.showToast(
              msg:
                  'Your last known location was sent as your location is turned off',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
          change('_',
              status: RxStatus.error(
                  '😱 Seems like your location is turned off, turn it ON for work hour management'));
        } else {
          Fluttertoast.showToast(
              msg: data['msg'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
          change(
              'Your location will be tracked, do not close the application while on clock',
              status: RxStatus.success());
        }
      },
      onError: (statusCode, data) {
        change('', status: RxStatus.error(data['msg'] ?? data['message']));
        Fluttertoast.showToast(
            msg: data['msg'] ?? data['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      },
    );
  }

  void _startLocationTracker() async {
    try {
      await BackgroundLocation.setAndroidConfiguration(
          _refreshLocationDuration); // for android devices it will fetch location after every 14.5 minutes
      await BackgroundLocation.setAndroidNotification(
        title: 'Background service is running',
        message: 'Background location in progress',
        icon: '@drawable-xxxhdpi/ic_stat_name',
      );
      {
        BackgroundLocation.startLocationService(
                distanceFilter: _minDistanceDelta)
            .then((value) {
          fetchLocation();
        }, onError: (_) {
          change('',
              status: RxStatus.error(
                  'Please provide location permission or turn on location if turned off'));
        });
      }
    } catch (_) {
      change('',
          status: RxStatus.error(
              'Please provide location permission or turn on location if turned off'));
    }
  }

  Future<void> fetchLocation() async {
    permissionStatus = await Permission.location.status;
    if (permissionStatus == PermissionStatus.granted ||
        permissionStatus == PermissionStatus.limited) {
      serviceStatus.value = await Permission.location.serviceStatus;
      BackgroundLocation.getLocationUpdates((value) {
        currentLocation.value = value;
        _submitLocationData();
      });
      if (serviceStatus.value == ServiceStatus.enabled) {
        change(
            'Your location will be tracked, do not close the application while on clock',
            status: RxStatus.success());
      } else {
        change('_',
            status: RxStatus.error(
                '😱 Seems like your location is turned off, turn it ON for work hour management'));
      }
    } else {
      change('',
          status: RxStatus.error(
              'Please provide location permission or turn on location if turned off'));
    }
  }

  @override
  void onClose() {
    BackgroundLocation.stopLocationService();
    apiTimer?.cancel();
    locationTimer?.cancel();
    super.onClose();
  }
}
