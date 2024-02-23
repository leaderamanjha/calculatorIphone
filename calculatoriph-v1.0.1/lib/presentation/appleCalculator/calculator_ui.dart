import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../theme/custom_button.dart';
import 'calculator_logic.dart';

// Global variables for width, height, and displayHeight
double? width, height, displayHeight;

// Font sizes based on device type
final fontSize32 = Device.get().isTablet ? 32 * 2.0 : 32.0;
final fontSize36 = Device.get().isTablet ? 36 * 2.0 : 36.0;

// StatefulWidget representing the Calculator
class Calculator extends StatefulWidget {
  @override
  CalculatorState createState() {
    return new CalculatorState();
  }
}

// State class for the Calculator widget
class CalculatorState extends State<Calculator> {
  CalculatorLogic _calculatorLogic = CalculatorLogic();

  @override
  Widget build(BuildContext context) {
    // Get device padding and size
    final padding = MediaQuery.of(context).padding;
    final size = MediaQuery.of(context).size;

    // Calculate width, height, and displayHeight
    width = size.width - padding.horizontal;
    height = size.height - padding.top;
    displayHeight = Math.max(
        height! - width! - width! / 5.0 + PADDING, fontSize32 + PADDING);

    // Building the UI from there
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: Stack(fit: StackFit.expand, children: [
        Container(
          padding: EdgeInsets.only(left: PADDING),
          color: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Display widget showing the current value
              CalculatorDisplay(value: _calculatorLogic.displayValue),

              // Rows of function keys, digit keys, and operator keys
              Flexible(
                child: Row(
                  children: <Widget>[
                    FunctionKey(
                      text: _calculatorLogic.displayValue != '0' ? 'C' : 'AC',
                      onPress: () {
                        setState(() {
                          // Reset CalculatorLogic instance on 'AC' press
                          if (_calculatorLogic.displayValue != '0') {
                            _calculatorLogic.clearDisplay();
                          } else {
                            _calculatorLogic.clearAll();
                          }
                        });
                      },
                    ),
                    FunctionKey(
                      text: "+/-",
                      onPress: () => setState(() {
                        _calculatorLogic.toggleSign();
                      }),
                    ),
                    FunctionKey(
                      text: "%",
                      onPress: () => setState(() {
                        _calculatorLogic.inputPercent();
                      }),
                    ),
                    OperatorKey(
                      text: "÷",
                      onPress: () => setState(() {
                        _calculatorLogic.performOperation('/');
                      }),
                    )
                  ],
                ),
              ),
              Flexible(
                child: Row(
                  children: <Widget>[
                    DigitKey(
                      text: "7",
                      onPress: () => setState(() {
                        _calculatorLogic.inputDigit(7);
                      }),
                    ),
                    DigitKey(
                      text: "8",
                      onPress: () => setState(() {
                        _calculatorLogic.inputDigit(8);
                      }),
                    ),
                    DigitKey(
                      text: "9",
                      onPress: () => setState(() {
                        _calculatorLogic.inputDigit(9);
                      }),
                    ),
                    OperatorKey(
                      text: "×",
                      onPress: () => setState(() {
                        _calculatorLogic.performOperation('*');
                      }),
                    )
                  ],
                ),
              ),
              Flexible(
                child: Row(
                  children: <Widget>[
                    DigitKey(
                      text: "4",
                      onPress: () => setState(() {
                        _calculatorLogic.inputDigit(4);
                      }),
                    ),
                    DigitKey(
                      text: "5",
                      onPress: () => setState(() {
                        _calculatorLogic.inputDigit(5);
                      }),
                    ),
                    DigitKey(
                      text: "6",
                      onPress: () => setState(() {
                        _calculatorLogic.inputDigit(6);
                      }),
                    ),
                    OperatorKey(
                      text: "-",
                      onPress: () => setState(() {
                        _calculatorLogic.performOperation('-');
                      }),
                    )
                  ],
                ),
              ),
              Flexible(
                child: Row(
                  children: <Widget>[
                    DigitKey(
                      text: "1",
                      onPress: () => setState(() {
                        _calculatorLogic.inputDigit(1);
                      }),
                    ),
                    DigitKey(
                      text: "2",
                      onPress: () => setState(() {
                        _calculatorLogic.inputDigit(2);
                      }),
                    ),
                    DigitKey(
                      text: "3",
                      onPress: () => setState(() {
                        _calculatorLogic.inputDigit(3);
                      }),
                    ),
                    OperatorKey(
                      text: "+",
                      onPress: () => setState(() {
                        _calculatorLogic.performOperation('+');
                      }),
                    )
                  ],
                ),
              ),
              Flexible(
                child: Row(
                  children: <Widget>[
                    DigitKey(
                      text: "0",
                      onPress: () => setState(() {
                        _calculatorLogic.inputDigit(0);
                      }),
                    ),
                    DigitKey(
                      text: ".",
                      onPress: () => setState(() {
                        _calculatorLogic.inputDot();
                      }),
                      fontSize: fontSize32 * 2,
                    ),
                    OperatorKey(
                      text: "=",
                      onPress: () => setState(() {
                        _calculatorLogic.performOperation('=');
                      }),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),

        // Positioned widget for the back button

        Positioned(
            left: 5,
            top: MediaQuery.of(context).padding.top,
            child: SizedBox(
              width: 40,
              height: 40,
              child: ClipOval(
                child: new CustomButton(
                    highlightColor: Colors.white54,
                    padding: EdgeInsets.all(0.0),
                    child: Center(
                        child: new Icon(
                      Device.get().isIos
                          ? Icons.arrow_back_ios
                          : Icons.arrow_back,
                      color: Colors.white,
                    )),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ),
            ))
      ]),
    );
  }
}

class CalculatorDisplay extends StatelessWidget {
  final String value;

  const CalculatorDisplay({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: displayHeight,
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.only(right: PADDING * 1.5, top: 15.0),
        child: Align(
          alignment: Alignment.bottomRight,
          child: AutoSizeText(
            value,
            style: TextStyle(
              fontSize: Device.get().isTablet ? 130 : 96,
              color: Colors.white,
            ),
            maxLines: 3,
          ),
        ),
      ),
    );
  }
}

class CalculatorKey extends StatelessWidget {
  final String? text;
  final Function? onPress;
  final Color? backgroundColor;
  final TextStyle? style;
  final bool isZeroKey;

  CalculatorKey(
      {Key? key, this.text, this.onPress, this.style, this.backgroundColor})
      : isZeroKey = text == '0',
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: isZeroKey ? 2 : 1,
      child: Container(
        padding: EdgeInsets.only(right: PADDING, bottom: PADDING),
        child: ClipRRect(
          borderRadius: new BorderRadius.circular(width! / 4),
          child: CustomButton(
            padding: EdgeInsets.all(0),
            color: backgroundColor,
            highlightColor: Color.alphaBlend(
                Colors.white.withOpacity(0.5), backgroundColor!),
            onPressed: onPress as void Function()?,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border(
                      top: BorderSide(color: new Color(0xFF777777)),
                      right: BorderSide(color: new Color(0xFF666666)))),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(right: isZeroKey ? width! / 4 : 0),
                  child: Text(
                    text!,
                    style: style,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FunctionKey extends StatelessWidget {
  final String text;
  final Function onPress;

  const FunctionKey({Key? key, required this.text, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CalculatorKey(
      text: text,
      onPress: onPress,
      backgroundColor: Color.fromARGB(240, 202, 202, 204),
      style: TextStyle(color: Colors.black, fontSize: fontSize32),
    );
  }
}

class OperatorKey extends StatelessWidget {
  final String text;
  final Function onPress;

  const OperatorKey({Key? key, required this.text, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CalculatorKey(
      text: text,
      onPress: onPress,
      backgroundColor: Colors.orangeAccent,
      style: TextStyle(color: Colors.white, fontSize: fontSize36),
    );
  }
}

class DigitKey extends StatelessWidget {
  final String text;
  final Function onPress;
  final double? fontSize;

  const DigitKey(
      {Key? key, required this.text, required this.onPress, this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CalculatorKey(
      text: text,
      onPress: onPress,
      backgroundColor: new Color(0xFF322f32),
      style: TextStyle(color: Colors.white, fontSize: fontSize ?? fontSize32),
    );
  }
}
