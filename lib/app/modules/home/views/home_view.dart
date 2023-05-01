import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sales/app/modules/auth/controllers/auth_controller.dart';
import 'package:sales/app/modules/home/controllers/location_controller.dart';
import 'package:sales/app/modules/home/views/widgets/display_box_widget.dart';
import 'package:sales/app/modules/insights/controllers/insights_controller.dart';
import 'package:sales/app/routes/app_pages.dart';
import 'package:sales/constants/button_type_enums.dart';
import 'package:sales/constants/enums.dart';
import 'package:sales/constants/text_styles.dart';
import 'package:sales/core/dialog.dart';
import 'package:sales/core/elevated_buttons.dart';

import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WidgetsBindingObserver {
  final HomeController controller = Get.find<HomeController>();
  final LocationController locationController = Get.find<LocationController>();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      controller.refreshAll();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
        leading: AuthController.to.user.value!.authorization.privileged
            ? IconButton(
                onPressed: () => Get.toNamed(Routes.MAP_TRACK),
                icon: const Icon(Icons.map))
            : const SizedBox.shrink(),
        actions: [
          IconButton(
              onPressed: () => controller.refreshAll(),
              icon: const Icon(Icons.refresh)),
          IconButton(
              onPressed: () {
                Get.dialog(RSDialog(
                  message: 'Are you sure you want to Logout?',
                  actions: [
                    RSElevatedButton(
                      title: 'Logout',
                      action: () => AuthController.to.logOut(),
                      type: RSButtonType.primary,
                      width: Get.width * .7,
                      height: kToolbarHeight,
                    ),
                    RSElevatedButton(
                      title: 'No',
                      action: () => Get.back(),
                      type: RSButtonType.plainOnBlack,
                      width: Get.width * .7,
                      height: kToolbarHeight,
                    ),
                  ],
                ));
              },
              icon: Icon(
                Icons.power_settings_new,
                color: Theme.of(context).colorScheme.error,
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          onPressed: () => Get.toNamed(Routes.ADD_CUSTOMER_FORM),
          label: const Text('Add Lead')),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: controller.obx(
          (state) => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => OutlinedButton(
                    onPressed: () => controller.datePicked(context),
                    child: Text(controller.startDateString.value.isEmpty
                        ? 'Pick your interval'
                        : '${controller.startDateString} to ${controller.endDateString}'))),
                Text(
                  'Your Progress!!!',
                  style: RSTextStyles.h2.copyWith(fontSize: 25),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    DisplayBoxWidget(
                        title: 'During Interval',
                        details: InsightsArgument(
                            showAllDetails: true,
                            details: state!.first.startToEndDateDetails!,
                            type: InsightPageType.interval),
                        value:
                            state.first.countStartToEndDateDetails.toString()),
                    DisplayBoxWidget(
                        title: 'Last 7 days',
                        details: InsightsArgument(
                            showAllDetails: true,
                            details: state.first.previousWeekDetails!,
                            type: InsightPageType.last7Days),
                        value: state.first.countPreviousWeekDetails.toString()),
                    Obx(
                      () => DisplayBoxWidget(
                          title: controller.endDateString.value,
                          details: InsightsArgument(
                              showAllDetails: true,
                              details: state.first.endDateDetails!,
                              date: controller.endDateString.value,
                              type: InsightPageType.lastDay),
                          value: state.first.countEndDateDetails.toString()),
                    ),
                  ],
                ),
                const SizedBox.square(
                  dimension: 20,
                ),
                const Divider(),
                const SizedBox.square(
                  dimension: 20,
                ),
                Text(
                  'Your Team\'s Progress',
                  style: RSTextStyles.h2.copyWith(fontSize: 25),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    DisplayBoxWidget(
                        title: 'During Interval',
                        details: InsightsArgument(
                            showAllDetails: AuthController
                                    .to.user.value?.authorization.privileged ??
                                false,
                            details: state.last.startToEndDateDetails!,
                            type: InsightPageType.interval),
                        value:
                            state.last.countStartToEndDateDetails.toString()),
                    DisplayBoxWidget(
                        title: 'Last 7 days',
                        details: InsightsArgument(
                            showAllDetails: AuthController
                                    .to.user.value?.authorization.privileged ??
                                false,
                            details: state.last.previousWeekDetails!,
                            type: InsightPageType.last7Days),
                        value: state.last.countPreviousWeekDetails.toString()),
                    Obx(
                      () => DisplayBoxWidget(
                          title: controller.endDateString.value,
                          details: InsightsArgument(
                              showAllDetails: AuthController.to.user.value
                                      ?.authorization.privileged ??
                                  false,
                              details: state.last.endDateDetails!,
                              date: controller.endDateString.value,
                              type: InsightPageType.lastDay),
                          value: state.last.countEndDateDetails.toString()),
                    ),
                  ],
                ),
                const SizedBox.square(
                  dimension: 20,
                ),
                locationController.obx(
                  (state) => Center(
                    child: Text(
                      state!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(.5)),
                    ),
                  ),
                  onLoading: const Center(child: CircularProgressIndicator()),
                  onError: (error) => Center(
                    child: Column(
                      children: [
                        Text(
                          error ?? 'Something went wrong',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .error
                                  .withOpacity(.5)),
                        ),
                        const SizedBox.square(
                          dimension: 10,
                        ),
                        if ((locationController.state?.isEmpty ?? false))
                          RSElevatedButton(
                              title: 'Open settings',
                              action: () => openAppSettings()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          onLoading: const Center(child: CircularProgressIndicator()),
          onError: (error) => Center(
            child: Text(
              error ?? 'Something went wrong',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.error.withOpacity(.5)),
            ),
          ),
        ),
      ),
    );
  }
}
