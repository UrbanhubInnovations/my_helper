import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../widgets/buttons/ink_well_material_button.dart';
import '../constants/theme_colors.dart';

@lazySingleton
class SnackBarAlert {
  OverlaySupportEntry? currentEntry;

  void showToast({required String message, Function? onTap, String? actionText, bool isTop = false}) {
    assert(onTap != null || (onTap == null && actionText == null));
    hide();

    currentEntry = showOverlayNotification(
      position: isTop ? NotificationPosition.top : NotificationPosition.bottom,
      duration: const Duration(seconds: 2),
      (context) => GestureDetector(
          onVerticalDragUpdate: (details) {
            if ((details.primaryDelta ?? 0) > 0) {
              hide();
            }
          },
          child: SafeArea(
            minimum: MediaQuery.viewInsetsOf(context),
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: ThemeColors.primaryBg.withOpacity(0.8),
                    offset: const Offset(0, 2),
                    blurRadius: 100,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: Material(
                color: ThemeColors.primary,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(top: 15, bottom: 15, start: 15),
                        child: Text(
                          message,
                          style: const TextStyle(
                            color: ThemeColors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    InkWellMaterialButton(
                      color: ThemeColors.primary,
                      borderRadius: 12,
                      onTap: () {
                        if (onTap != null) {
                          onTap();
                        }
                        hide();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          actionText ?? 'Dismiss',
                          style: const TextStyle(
                            color: ThemeColors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }

  void showCustomToast({required String message, required Function onTap, bool isTop = false}) {
    hide();
    currentEntry = showOverlayNotification(
      position: isTop ? NotificationPosition.top : NotificationPosition.bottom,
      duration: const Duration(seconds: 2),
      (context) => GestureDetector(
          onVerticalDragUpdate: (details) {
            if ((details.primaryDelta ?? 0) > 0) {
              hide();
            }
          },
          child: SafeArea(
            minimum: MediaQuery.viewInsetsOf(context),
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: ThemeColors.primaryBg.withOpacity(0.8),
                    offset: const Offset(0, 2),
                    blurRadius: 100,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: InkWellMaterialButton(
                color: ThemeColors.primary,
                borderRadius: 12,
                onTap: () {
                  onTap();
                  hide();
                },
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(top: 15, bottom: 15, start: 15),
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: ThemeColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
    );
  }

  void hide() {
    if (currentEntry != null) {
      currentEntry?.dismiss();
    }
  }
}
