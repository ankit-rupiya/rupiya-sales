import 'package:aveo_api/aveo_api.dart';
import 'package:flutter/material.dart';
import 'package:sales/constants/button_type_enums.dart';

class RSElevatedButton extends StatelessWidget {
  final RSButtonType type;
  final String title;
  final Widget? icon;
  final Function action;
  final double? height;
  final double? width;
  const RSElevatedButton({
    super.key,
    required this.title,
    required this.action,
    this.type = RSButtonType.plain,
    this.icon,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CLStatus.instance.isConnected,
      builder: (context, isConnected, _) => SizedBox(
        height: height,
        width: width,
        child: icon == null
            ? ElevatedButton(
                onPressed: () {
                  if (isConnected) {
                    action.call();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: type == RSButtonType.plainOnBlack
                      ? type.color
                      : type.color.withOpacity(isConnected ? 1 : .6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(type.borderRadius),
                  ),
                ),
                child: Text(
                  title,
                  style: type.textStyle.copyWith(
                    color: Colors.white.withOpacity(isConnected ? 1 : .6),
                  ),
                ),
              )
            : Directionality(
                textDirection: TextDirection.rtl,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (isConnected) {
                      action.call();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: type == RSButtonType.plainOnBlack
                        ? type.color
                        : type.color.withOpacity(isConnected ? 1 : .6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(type.borderRadius),
                    ),
                  ),
                  icon: icon!,
                  label: Text(
                    title,
                    style: type.textStyle.copyWith(
                      color: Colors.white.withOpacity(isConnected ? 1 : .6),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
