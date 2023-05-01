import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales/app/data/team_sales_response.dart';
import 'package:sales/app/modules/auth/controllers/auth_controller.dart';
import 'package:sales/app/modules/insights/views/widgets/name_list_dailog.dart';
import 'package:sales/constants/enums.dart';

class InsightsController extends GetxController
    with StateMixin<List<EndDateDetails>> {
  InsightsArgument arguments = Get.arguments;
  RxBool isFilterSet = false.obs;
  RxBool showBestPerformer = false.obs;
  RxBool showLowPerformer = false.obs;
  Map<String, int> salesCount = {};
  RxString maxSalesSalesman = ''.obs;
  RxString minSalesSalesman = ''.obs;
  String filterName = '';
  int filterIntCount = 0;
  Comparisons filterComparisons = Comparisons.moreThenEquals;
  final PageController pageController = PageController();

  @override
  void onInit() {
    change(arguments.details,
        status:
            arguments.details.isEmpty ? RxStatus.empty() : RxStatus.success());
    if (AuthController.to.user.value!.authorization.privileged &&
        arguments.showAllDetails) {
      getCounts();
    }
    super.onInit();
  }

  void filter(String name) {
    List<EndDateDetails> filterEntries = [];
    filterEntries = arguments.details
        .where((element) => element.salesmanName == name)
        .toList();

    change(filterEntries,
        status:
            arguments.details.isEmpty ? RxStatus.empty() : RxStatus.success());
    Get.back();
  }

  List<String> filterCount(
      {required int count, required Comparisons comparisons}) {
    switch (comparisons) {
      case Comparisons.exact:
        return salesCount.entries
            .where((element) => element.value == count)
            .map<String>((e) => e.key)
            .toList();
      case Comparisons.moreThen:
        return salesCount.entries
            .where((element) => element.value > count)
            .map<String>((e) => e.key)
            .toList();
      case Comparisons.moreThenEquals:
        return salesCount.entries
            .where((element) => element.value >= count)
            .map<String>((e) => e.key)
            .toList();
      case Comparisons.lessThen:
        return salesCount.entries
            .where((element) => element.value < count)
            .map<String>((e) => e.key)
            .toList();
      case Comparisons.lessThenEquals:
        return salesCount.entries
            .where((element) => element.value <= count)
            .map<String>((e) => e.key)
            .toList();
      default:
        return [];
    }
  }

  void showFilterCount({required int count, required Comparisons comparisons}) {
    Get.back();
    List<String> result = filterCount(count: count, comparisons: comparisons);
    Get.dialog(NameListDialog(names: result));
  }

  void getWithMaxSales() {
    int max = 0;
    String salesman = '';
    salesCount.entries.forEach((element) {
      if (max < element.value) {
        max = element.value;
        salesman = element.key;
      }
    });
    maxSalesSalesman.value = salesman;
  }

  void getWithMinSales() {
    int min = salesCount.entries.first.value;
    String salesman = salesCount.entries.first.key;
    salesCount.entries.forEach((element) {
      if (min > element.value) {
        min = element.value;
        salesman = element.key;
      }
    });
    minSalesSalesman.value = salesman;
  }

  void getCounts() {
    arguments.details.forEach((element) {
      salesCount.update(element.salesmanName!, (value) => value + 1,
          ifAbsent: () => 1);
    });
    getWithMaxSales();
    getWithMinSales();
  }

  void removeFilter() {
    Get.back();
    change(arguments.details,
        status:
            arguments.details.isEmpty ? RxStatus.empty() : RxStatus.success());
  }
}

class InsightsArgument {
  final List<EndDateDetails> details;
  final InsightPageType type;
  final String? date;
  final bool showAllDetails;
  const InsightsArgument(
      {required this.details,
      required this.type,
      this.date,
      this.showAllDetails = true});
}
