import 'package:get/get.dart';
import '../presentation/appleCalculator/calculator_ui.dart';
import '../presentation/appleCalculator/binding/calculator_binding.dart';

class AppRoutes {
  static const String builtInCalculatorScreen = '/built_in_calculator_screen';

  static const String initialRoute = '/initialRoute';

  static List<GetPage> pages = [
    GetPage(
      name: builtInCalculatorScreen,
      page: () => Calculator(),
      bindings: [
        BuiltInCalculatorBinding(),
      ],
    ),
    GetPage(
      name: initialRoute,
      page: () => Calculator(),
      bindings: [
        BuiltInCalculatorBinding(),
      ],
    )
  ];
}
