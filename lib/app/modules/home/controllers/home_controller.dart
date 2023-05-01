import 'dart:async';

import 'package:aveo_api/aveo_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sales/app/data/sales_params.dart';
import 'package:sales/app/data/team_sales_response.dart';
import 'package:sales/app/modules/auth/controllers/auth_controller.dart';
import 'package:sales/app/modules/home/controllers/location_controller.dart';
import 'package:sales/app/modules/home/repository/home_repository.dart';
import 'package:sales/constants/colors.dart';

class HomeController extends GetxController with StateMixin<List<Details>> {
  RxString startDateString = ''.obs;
  RxString endDateString = ''.obs;
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  final LocationController locationController = Get.find<LocationController>();

  DateTime? startDate;
  DateTime? endDate;

  @override
  void onInit() {
    endDateString.value = _dateFormat.format(DateTime.now());
    super.onInit();
  }

  void refreshAll() {
    getAllData();
    locationController.fetchLocation();
  }

  @override
  void onReady() {
    bool initCall = true;
    if (CLStatus.instance.isConnected.value) {
      getAllData();
    } else {
      CLStatus.instance.isConnected.addListener(() {
        if (CLStatus.instance.isConnected.value && initCall) {
          getAllData();
          initCall = false;
        }
      });
    }
    super.onReady();
  }

  // double _calculateDistance() {
  //   if (_lastSentLocation == null) {
  //     return 10000;
  //   }
  //   double degToRadian = pi / 180;
  //   double earthRadius = 6371;
  //   double deltaLat =
  //       (_lastSentLocation!.latitude! - currentLocation.value!.latitude!) *
  //           degToRadian;
  //   double deltaLon =
  //       (_lastSentLocation!.longitude! - currentLocation.value!.longitude!) *
  //           degToRadian;
  //   double a = sin(deltaLat / 2) * sin(deltaLat / 2) +
  //       cos(degToRadian * _lastSentLocation!.latitude!) *
  //           cos(degToRadian * currentLocation.value!.latitude!) *
  //           sin(deltaLon / 2) *
  //           sin(deltaLon / 2);
  //   double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  //   double d = earthRadius * c; // Distance in km
  //   return d * 1000; // Distance in m
  // }

  void getAllData() async {
    change([], status: RxStatus.loading());
    try {
      List<Details> data =
          await Future.wait([getSalesManData(), getTeamData()]);
      change(data, status: RxStatus.success());
    } catch (e) {
      change([], status: RxStatus.error(e.toString()));
    }
  }

  void datePicked(BuildContext context) async {
    DateTimeRange? dateTimeRange = await showDateRangePicker(
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
                    onSurface: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                    background: const Color.fromRGBO(255, 218, 153, 1),
                    onBackground: RSColor.theme,
                  ),
            ),
            child: child!);
      },
    );

    if (dateTimeRange != null) {
      startDate = dateTimeRange.start;
      endDate = dateTimeRange.end;
      startDateString.value = _dateFormat.format(dateTimeRange.start);
      endDateString.value = _dateFormat.format(dateTimeRange.end);
      getAllData();
    }
  }

  Future<Details> getSalesManData() async {
    Completer<Details> future = Completer<Details>();
    String salesman = AuthController.to.user.value!.userName;
    HomeRepository.getSalesManData(
      salesParams: SalesParams(
          salesmanName: salesman,
          startDate: startDate ?? DateTime.now(),
          endDate: endDate ?? DateTime.now()),
      onSuccess: (statusCode, data) {
        try {
          SalesResponse salesResponse = SalesResponse.fromJson(data);
          Details? salesDetails;
          if (salesResponse.data!.isNotEmpty) {
            salesDetails = salesResponse.data!.first.details!;
          } else {
            salesDetails = Details(
                countEndDateDetails: 0,
                countPreviousWeekDetails: 0,
                countStartToEndDateDetails: 0,
                endDateDetails: [],
                previousWeekDetails: [],
                startToEndDateDetails: []);
          }
          future.complete(salesDetails);
        } catch (e) {
          future.completeError('Sent data does not fit criteria');
        }
      },
      onError: (statusCode, data) {
        future.completeError(data['msg'] ?? data['message']);
      },
    );
    return future.future;
  }

  Future<Details> getTeamData() async {
    Completer<Details> future = Completer<Details>();
    HomeRepository.getSalesTeamData(
      salesParams: SalesParams(
          startDate: startDate ?? DateTime.now(),
          endDate: endDate ?? DateTime.now()),
      onSuccess: (statusCode, data) {
        try {
          SalesResponse salesResponse = SalesResponse.fromJson(data);
          Details? salesDetails;
          if (salesResponse.data!.isNotEmpty) {
            salesDetails = salesResponse.data!.first.details!;
          } else {
            salesDetails = Details(
                countEndDateDetails: 0,
                countPreviousWeekDetails: 0,
                countStartToEndDateDetails: 0,
                endDateDetails: [],
                previousWeekDetails: [],
                startToEndDateDetails: []);
          }
          future.complete(salesDetails);
        } catch (e) {
          future.completeError('Sent data does not fit criteria');
        }
      },
      onError: (statusCode, data) {
        future.completeError(data['msg'] ?? data['message']);
      },
    );
    return future.future;
  }
}
