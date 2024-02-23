import '../controller/calculator_controller.dart';
import 'package:get/get.dart';

/// A binding class for the CalculatorScreen.
///
/// This class ensures that the CalculatorController is created when the
/// CalculatorScreen is first loaded.
class BuiltInCalculatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BuiltInCalculatorController());
  }
}
