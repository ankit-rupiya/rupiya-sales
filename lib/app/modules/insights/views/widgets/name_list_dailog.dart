import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales/app/modules/insights/controllers/insights_controller.dart';
import 'package:sales/core/dialog.dart';
import 'package:sales/core/elevated_buttons.dart';

class NameListDialog extends GetView<InsightsController> {
  final List<String> names;
  const NameListDialog({super.key, required this.names});

  @override
  Widget build(BuildContext context) {
    return RSDialog(
        body: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(12)),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: names.length,
            separatorBuilder: (context, index) => const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Divider(),
            ),
            itemBuilder: (context, index) => ListTile(
              title: Text(
                names[index],
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            ),
          ),
        ),
        actions: [
          RSElevatedButton(title: 'Go Back', action: () => Get.back())
        ]);
  }
}
