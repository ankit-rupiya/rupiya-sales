import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sales/app/modules/insights/controllers/insights_controller.dart';
import 'package:sales/core/dialog.dart';
import 'package:sales/core/elevated_buttons.dart';
import 'package:sales/core/text_felids.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FilterWidget extends GetView<InsightsController> {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    controller.isFilterSet.value = true;
    return RSDialog(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: SizedBox(
                width: Get.width * .7,
                height: Get.height * .25,
                child: PageView(
                  controller: controller.pageController,
                  onPageChanged: (value) => value == 0
                      ? controller.isFilterSet.value = true
                      : controller.isFilterSet.value = false,
                  children: [
                    Center(
                      child: DropdownButtonFormField(
                          hint: const Text('Select Salesman'),
                          items: List.generate(
                              controller.salesCount.length,
                              (index) => DropdownMenuItem<String>(
                                    value: controller.salesCount.keys
                                        .elementAt(index),
                                    child: Text(controller.salesCount.keys
                                        .elementAt(index)),
                                  )),
                          onChanged: (value) => controller.filterName = value!),
                    ),
                    Column(
                      children: [
                        RSTextField(
                          label: 'Sales count',
                          onChange: (value) => controller.filterIntCount =
                              double.parse(value).toInt(),
                          // validation: (value) =>
                          //     cannotBeEmpty(value: value, name: 'First name'),

                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                        TextButton(
                            onPressed: () => Get.dialog(RSDialog(
                                    message:
                                        '${controller.maxSalesSalesman.value} with ${controller.salesCount[controller.maxSalesSalesman.value]} sales',
                                    actions: [
                                      RSElevatedButton(
                                          title: 'Ok', action: Get.back)
                                    ])),
                            child: const Text('Highest Sales')),
                        TextButton(
                            onPressed: () => Get.dialog(RSDialog(
                                    message:
                                        '${controller.minSalesSalesman.value} with ${controller.salesCount[controller.minSalesSalesman.value]} sales',
                                    actions: [
                                      RSElevatedButton(
                                          title: 'Ok', action: Get.back)
                                    ])),
                            child: const Text('Lowest Sales')),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Center(
              child: SmoothPageIndicator(
                  controller: controller.pageController, // PageController
                  count: 2,
                  effect: ExpandingDotsEffect(
                    radius: 50,
                    dotHeight: 8,
                    dotWidth: 8,
                    activeDotColor: Theme.of(context).colorScheme.primary,
                  ), // your preferred effect
                  onDotClicked: (index) {
                    controller.pageController.jumpToPage(index);
                    if (index == 0) {
                      controller.isFilterSet.value = true;
                    } else {
                      controller.isFilterSet.value = false;
                    }
                  }),
            )
          ],
        ),
      ),
      actionArrangement: Axis.horizontal,
      actions: [
        if (controller.state!.length < controller.arguments.details.length)
          RSElevatedButton(
              title: 'Remove filter',
              action: () {
                controller.removeFilter();
              }),
        RSElevatedButton(title: 'Go back', action: Get.back),
        RSElevatedButton(
            title: 'Apply',
            action: () {
              controller.isFilterSet.value
                  ? controller.filter(controller.filterName)
                  : controller.showFilterCount(
                      count: controller.filterIntCount,
                      comparisons: controller.filterComparisons);
            }),
      ],
    );
  }
}
