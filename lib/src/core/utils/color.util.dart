import "package:flutter/material.dart";
import "package:flutter/scheduler.dart";

class ColorUtil {
  static bool get isLightMode {
    final brightness = SchedulerBinding.instance.window.platformBrightness;
    return brightness == Brightness.light;
  }

  static bool get isDarkMode {
    final brightness = SchedulerBinding.instance.window.platformBrightness;
    return brightness == Brightness.light;
  }

  static Color blackOrWhiteText(Color backgroundColor) {
    return backgroundColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }

  static MaterialColor generateMaterialColor(int customerPrimaryColorHex) {
    final Color customerPrimaryColor = Color(customerPrimaryColorHex);
    return MaterialColor(customerPrimaryColorHex, {
      50: customerPrimaryColor.withOpacity(.1),
      100: customerPrimaryColor.withOpacity(.2),
      200: customerPrimaryColor.withOpacity(.3),
      300: customerPrimaryColor.withOpacity(.4),
      400: customerPrimaryColor.withOpacity(.5),
      500: customerPrimaryColor.withOpacity(.6),
      600: customerPrimaryColor.withOpacity(.7),
      700: customerPrimaryColor.withOpacity(.8),
      800: customerPrimaryColor.withOpacity(.9),
      900: customerPrimaryColor.withOpacity(1),
    });
  }
}
