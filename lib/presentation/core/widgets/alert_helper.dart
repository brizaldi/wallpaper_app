import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

import '../../../extra/style/style.dart';

class AlertHelper {
  static void showRetrySnackBar(
    BuildContext context, {
    required String message,
    required VoidCallback onTapRetry,
  }) {
    showFlash(
      context: context,
      duration: const Duration(seconds: 10),
      builder: (_, controller) {
        final _brightness = Theme.of(context).brightness;
        final _textTheme = Theme.of(context).textTheme;

        return Flash(
          controller: controller,
          brightness: _brightness,
          backgroundColor: _brightness == Brightness.dark
              ? Palette.mineshaft
              : Palette.aquaHaze,
          position: FlashPosition.bottom,
          behavior: FlashBehavior.floating,
          child: FlashBar(
            content: Text(
              message,
              style: _textTheme.bodyText1!.copyWith(
                color: _brightness == Brightness.dark
                    ? Palette.aquaHaze
                    : Palette.mineshaft,
                fontWeight: FontWeight.w400,
              ),
            ),
            primaryAction: TextButton(
              onPressed: () {
                controller.dismiss();
                onTapRetry.call();
              },
              child: Text(
                'RETRY',
                style: _textTheme.button!.apply(
                  color: Palette.amaranth,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
