import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sales/app/modules/auth/controllers/auth_controller.dart';
import 'package:sales/app/modules/insights/views/widgets/filter_dialog.dart';
import 'package:sales/constants/enums.dart';

import '../controllers/insights_controller.dart';

class InsightsView extends GetView<InsightsController> {
  const InsightsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.arguments.type == InsightPageType.lastDay
            ? controller.arguments.date!
            : controller.arguments.type.pageTitle),
        centerTitle: true,
        actions: [
          if (AuthController.to.user.value!.authorization.privileged &&
              controller.arguments.showAllDetails)
            IconButton(
                onPressed: () => Get.dialog(const FilterWidget()),
                icon: const Icon(Icons.filter_list))
        ],
      ),
      body: controller.obx(
          (state) => SingleChildScrollView(
                child: SizedBox(
                    child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                      // horizontalMargin: 8,
                      headingRowHeight: kMinInteractiveDimension,
                      dataRowHeight: kMinInteractiveDimension,
                      columnSpacing: kMinInteractiveDimension,
                      dividerThickness: 0,
                      showBottomBorder: true,
                      columns: <DataColumn>[
                        if (AuthController
                                .to.user.value!.authorization.privileged &&
                            controller.arguments.showAllDetails)
                          DataColumn(
                            onSort: (columnIndex, ascending) {},
                            label: const Expanded(
                              child: Text(
                                'Salesman name',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                        const DataColumn(
                          label: Expanded(
                            child: Text(
                              'First name',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        const DataColumn(
                          label: Expanded(
                            child: Text(
                              'Middle name',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        const DataColumn(
                          label: Expanded(
                            child: Text(
                              'Last name',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        const DataColumn(
                          label: Expanded(
                            child: Text(
                              'Mobile no.',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        const DataColumn(
                          label: Expanded(
                            child: Text(
                              'Address',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        const DataColumn(
                          label: Expanded(
                            child: Text(
                              'Crop',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        const DataColumn(
                          label: Expanded(
                            child: Text(
                              'Land area',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        const DataColumn(
                          label: Expanded(
                            child: Text(
                              'Organic Farming',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        const DataColumn(
                          label: Expanded(
                            child: Text(
                              'Added on',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                      ],
                      rows: List.generate(
                          state!.length,
                          (index) => DataRow(
                                cells: <DataCell>[
                                  if (AuthController.to.user.value!
                                          .authorization.privileged &&
                                      controller.arguments.showAllDetails)
                                    DataCell(Text(state[index].salesmanName!)),
                                  DataCell(Text(state[index].cFirstName!)),
                                  DataCell(Text(controller
                                      .arguments.details[index].cMiddleName!)),
                                  DataCell(Text(state[index].cLastName!)),
                                  DataCell(Text(state[index].cMobileNo!)),
                                  DataCell(Text(controller
                                      .arguments.details[index].cFarmAddress!)),
                                  DataCell(Text(state[index].cropName!)),
                                  DataCell(Text(state[index].landArea!)),
                                  DataCell(Text(state[index].interested == 0
                                      ? 'Not Interested'
                                      : 'Interested')),
                                  DataCell(Text(
                                      DateFormat('dd MMMM yyyy hh:mm a').format(
                                          DateTime.parse(
                                                  state[index].createdDatetime!)
                                              .toLocal()))),
                                ],
                              ))),
                )),
              ),
          onEmpty: Center(
            child: Text(
              'Nothing to show here, try adjusting the filter!!!',
              style: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(.5)),
            ),
          )),
    );
  }
}
