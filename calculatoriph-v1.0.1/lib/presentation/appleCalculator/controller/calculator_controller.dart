import 'package:calculatoriph/core/app_export.dart';
import 'package:calculatoriph/presentation/appleCalculator/models/calculator_model.dart';

/// A controller class for the BuiltInCalculatorScreen.
///
/// This class manages the state of the CalculatorScreen, including the
/// current CalculatorModelObj
class BuiltInCalculatorController extends GetxController {
  Rx<BuiltInCalculatorModel> builtInCalculatorModelObj =
      BuiltInCalculatorModel().obs;
}
