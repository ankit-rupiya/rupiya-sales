import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sales/app/data/location_logs_response.dart';
import 'package:sales/app/data/user_list_response.dart';
import 'package:sales/app/modules/map_track/repository/map_track_repository.dart';
import 'package:sales/constants/colors.dart';

class MapTrackController extends GetxController
    with StateMixin<List<LocationUIData>> {
  Completer<GoogleMapController> mapController = Completer();
  RxList<String> salesmans = <String>[].obs;
  String selectedSalesman = '';
  DateTime selectedDate = DateTime.now();
  late CameraPosition kGoogle;
  final Set<Marker> markers = {};
  final Set<Polyline> polyline = {};

  @override
  void onInit() {
    change([], status: RxStatus.empty());

    super.onInit();
  }

  @override
  void onReady() {
    getUsers();
    super.onReady();
  }

  void getUsers() async {
    MapTrackRepository.getSalesmanList(onSuccess: (_, json) {
      UserListResponse res = UserListResponse.fromJson(json);
      if ((res.data?.isEmpty ?? true) ||
          (res.data?.first.users?.isEmpty ?? true)) {
        change([], status: RxStatus.error('no data available'));
      } else {
        salesmans.value =
            res.data?.first.users?.map<String>((e) => e.username!).toList() ??
                [];
        change([], status: RxStatus.empty());
      }
    });
  }

  void getLocationLogs() async {
    markers.clear();
    polyline.clear();
    MapTrackRepository.getSalesmanMapData(
        salesman: selectedSalesman,
        datetime: selectedDate,
        onSuccess: (_, json) {
          change([], status: RxStatus.loading());
          LocationLogsResponse res = LocationLogsResponse.fromJson(json);
          if ((res.data?.isEmpty ?? true) ||
              (res.data?.first.locationDetails?.isEmpty ?? true)) {
            change([], status: RxStatus.empty());
          } else {
            List<LocationUIData> data = [];
            for (LocationDetails locationDetails
                in res.data!.first.locationDetails!) {
              int index = data.indexWhere((element) =>
                  element.sLatitude == locationDetails.sLatitude &&
                  element.sLongitude == element.sLongitude);
              if (index == -1) {
                data.add(locationDetails.toLocationUIData());
              } else {
                data[index] = data[index].incrementCount();
              }
            }
            data.forEach((element) {
              LatLng latLng = LatLng(double.parse(element.sLatitude),
                  double.parse(element.sLongitude));
              markers.add(Marker(
                markerId: MarkerId(latLng.toString()),
                position: latLng,
                infoWindow: InfoWindow(
                  title: 'For ${element.count} api calls',
                ),
                icon: BitmapDescriptor.defaultMarker,
              ));
              polyline.addAll([
                Polyline(
                  polylineId: const PolylineId('1'),
                  width: 2,
                  points: [latLng],
                  zIndex: 1,
                  color: Colors.lightBlueAccent,
                ),
                Polyline(
                  polylineId: const PolylineId('2'),
                  width: 2,
                  points: [latLng],
                  zIndex: 0,
                  color: Colors.blueAccent,
                )
              ]);
            });
            change(data,
                status: data.isEmpty ? RxStatus.empty() : RxStatus.success());
            if (data.isNotEmpty) {
              kGoogle =
                  CameraPosition(target: markers.first.position, zoom: 10);
            }
          }
        },
        onError: (_, error) {
          change([], status: RxStatus.error(error['msg'] ?? error['message']));
        });
  }

  Future<DateTime?> pickDate(BuildContext context) async {
    selectedDate = (await showDatePicker(
          initialDate: DateTime.now(),
          context: context,
          firstDate: DateTime(2019),
          lastDate: DateTime.now(),
          builder: (context, child) {
            return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: Theme.of(context).colorScheme.copyWith(
                        primary: RSColor.theme,
                        onPrimary: Colors.white,
                        surface: RSColor.theme,
                        onSurface:
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.black
                                : Colors.white,
                        background: const Color.fromRGBO(255, 218, 153, 1),
                        onBackground: RSColor.theme,
                      ),
                ),
                child: child!);
          },
        )) ??
        DateTime.now();
    if (selectedSalesman.isNotEmpty) {
      getLocationLogs();
    }
    return selectedDate;
  }
}
