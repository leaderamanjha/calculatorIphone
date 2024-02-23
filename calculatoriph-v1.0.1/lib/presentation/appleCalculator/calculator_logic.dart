import 'package:intl/intl.dart';

const MAX_FRACTION_DIGITS = 6;
final NumberFormat formatter = new NumberFormat("#,###.######")
  ..maximumFractionDigits = 6;
const PADDING = 13.5;

var calculatorOperations = {
  '/': (prevValue, nextValue) => prevValue / nextValue,
  '*': (prevValue, nextValue) => prevValue * nextValue,
  '+': (prevValue, nextValue) => prevValue + nextValue,
  '-': (prevValue, nextValue) => prevValue - nextValue,
  '=': (prevValue, nextValue) => nextValue
};

class CalculatorLogic {
  var value;
  var displayValue = '0';
  var operator;
  var waitingForOperand = false;

  void clearAll() {
    value = null;
    displayValue = '0';
    operator = null;
    waitingForOperand = false;
  }

  void clearDisplay() {
    displayValue = '0';
  }

  void toggleSign() {
    var newValue = double.parse(displayValue) * -1;
    displayValue = formatter.format(newValue).toString();
  }

  void inputPercent() {
    var currentValue = double.parse(displayValue);

    if (currentValue == 0) return;

    var fixedDigits = displayValue.replaceAll(new RegExp(r"^-?\d*\.?"), '');
    var newValue = double.parse(displayValue) / 100;

    displayValue =
        formatter.format(newValue.toStringAsFixed(fixedDigits.length + 2));
  }

  void inputDot() {
    if (!(new RegExp(r"\.")).hasMatch(displayValue)) {
      displayValue = displayValue + '.';
      waitingForOperand = false;
    }
  }

  void inputDigit(int digit) {
    if (waitingForOperand) {
      displayValue = digit.toString();
      waitingForOperand = false;
    } else {
      displayValue = displayValue == '0'
          ? digit.toString()
          : formatter.format(double.parse(
              (displayValue + digit.toString()).replaceAll(",", "")));
    }
  }

  void performOperation(String nextOperator) {
    var inputValue = double.parse(displayValue.replaceAll(",", ""));

    if (value == null) {
      value = inputValue;
    } else if (operator != null) {
      var currentValue = value ?? 0;
      var newValue = calculatorOperations[operator]!(currentValue, inputValue);
      value = newValue;
      displayValue = formatter.format(newValue).toString();
    }

    waitingForOperand = true;
    operator = nextOperator;
  }
}
