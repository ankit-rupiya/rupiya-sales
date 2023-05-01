import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales/app/modules/insights/controllers/insights_controller.dart';
import 'package:sales/app/routes/app_pages.dart';
import 'package:sales/constants/colors.dart';
import 'package:sales/constants/text_styles.dart';

class DisplayBoxWidget extends StatelessWidget {
  final String title;
  final String value;
  final InsightsArgument? details;
  const DisplayBoxWidget(
      {super.key, required this.title, required this.value, this.details});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => details != null &&
                details!.details.isNotEmpty &&
                details!.showAllDetails
            ? Get.toNamed(Routes.INSIGHTS, arguments: details)
            : null,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).dividerColor, width: 1),
          ),
          child: LayoutBuilder(builder: (context, constraints) {
            return SizedBox(
              height: constraints.maxWidth,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8, left: 8),
                      child: Text(
                        title,
                        style: RSTextStyles.bodyBold.copyWith(
                            fontSize: 12,
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(.7)),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        value,
                        style: RSTextStyles.h1
                            .copyWith(color: RSColor.theme, fontSize: 50),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
