import 'package:dhuwitku/component/button/primary_button.dart';
import 'package:dhuwitku/component/field/input_field.dart';
import 'package:dhuwitku/core/ui/app_colors.dart';
import 'package:dhuwitku/core/ui/text_app.dart';
import 'package:dhuwitku/util/extension/string_extension.dart';
import 'package:flutter/material.dart';

void showNominalBottomSheet({
  required BuildContext context,
  required ValueChanged<int> onSubmit,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return _CalculatorBottomSheet(onSubmit: onSubmit);
    },
  );
}

class _CalculatorBottomSheet extends StatefulWidget {
  final ValueChanged<int> onSubmit;

  const _CalculatorBottomSheet({required this.onSubmit});

  @override
  State<_CalculatorBottomSheet> createState() => _CalculatorBottomSheetState();
}

class _CalculatorBottomSheetState extends State<_CalculatorBottomSheet> {
  final TextEditingController amountCtrl = TextEditingController();
  String expression = "";

  // =========================
  // INPUT HANDLER
  // =========================

  void _onNominal(String value) {
    setState(() {
      expression = value.replaceAll('.', '');
      amountCtrl.text = formatExpression(expression);
    });
  }

  void _onKeyTap(String value) {
    setState(() {
      if (['+', '-', '×', '÷'].contains(value)) {
        if (expression.isEmpty) return;

        final last = expression[expression.length - 1];

        if (['+', '-', '×', '÷'].contains(last)) {
          expression = expression.substring(0, expression.length - 1);
        }
      }

      expression += value;

      amountCtrl.text = formatExpression(expression);
    });
  }

  void _onClear() {
    setState(() {
      expression = "";
      amountCtrl.clear();
    });
  }

  void _onBackspace() {
    if (expression.isEmpty) return;

    setState(() {
      expression = expression.substring(0, expression.length - 1);

      amountCtrl.text = expression.isEmpty ? '' : formatExpression(expression);
    });
  }

  // =========================
  // VALIDATION
  // =========================

  bool _isValidExpression(String exp) {
    final parsed = exp.replaceAll('×', '*').replaceAll('÷', '/');
    return RegExp(r'^\d+([\+\-\*\/]\d+)*$').hasMatch(parsed);
  }

  // =========================
  // EQUAL
  // =========================

  void _onEqual() {
    if (!_isValidExpression(expression)) return;

    try {
      final parsed = expression.replaceAll('×', '*').replaceAll('÷', '/');

      final result = double.parse(_simpleEval(parsed)).toStringAsFixed(0);

      setState(() {
        expression = result;
        amountCtrl.text = formatExpression(expression);
      });
    } catch (_) {}
  }

  // =========================
  // EVALUATOR
  // =========================

  String _simpleEval(String exp) {
    final tokens = RegExp(
      r'(\d+|\+|\-|\*|\/)',
    ).allMatches(exp).map((e) => e.group(0)!).toList();

    if (tokens.isEmpty) return "0";

    List<dynamic> stack = [];
    stack.add(double.parse(tokens[0]));

    for (int i = 1; i < tokens.length; i += 2) {
      final op = tokens[i];
      final num = double.parse(tokens[i + 1]);

      if (op == '*' || op == '/') {
        double prev = stack.removeLast();
        stack.add(op == '*' ? prev * num : prev / num);
      } else {
        stack.add(op);
        stack.add(num);
      }
    }

    double total = stack[0];

    for (int i = 1; i < stack.length; i += 2) {
      final op = stack[i];
      final num = stack[i + 1];

      if (op == '+') total += num;
      if (op == '-') total -= num;
    }

    return total.toString();
  }

  String formatExpression(String exp) {
    if (exp.isEmpty) return "";

    final buffer = StringBuffer();
    final regex = RegExp(r'(\d+|[+\-×÷])');

    final parts = regex.allMatches(exp).map((e) => e.group(0)!);

    for (var part in parts) {
      if (RegExp(r'\d+').hasMatch(part)) {
        buffer.write(part.toRupiah());
      } else {
        buffer.write(" $part ");
      }
    }

    return buffer.toString();
  }

  bool _canSubmit() {
    if (expression.isEmpty || expression == '0') return false;

    final last = expression[expression.length - 1];

    if (['+', '-', '×', '÷'].contains(last)) return false;

    if (!_isValidExpression(expression)) return false;

    return true;
  }

  // =========================
  // BUILD
  // =========================

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        16,
        16,
        16,
        MediaQuery.of(context).padding.bottom,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 6,
            decoration: BoxDecoration(
              color: AppColors.surfaceGrey,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(height: 16),

          InputField(
            title: 'Atur Nominal QRIS',
            hintText: '0',
            controller: amountCtrl,
            enabled: false,
            readOnly: true,
            textAlign: TextAlign.right,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),

          const SizedBox(height: 16),

          PrimaryButton(
            text: 'Buat QRIS',
            isEnabled: _canSubmit(),
            onPressed: () {
              if (expression.isEmpty || expression == '0') return;

              final parsed = expression
                  .replaceAll('×', '*')
                  .replaceAll('÷', '/');

              String result = expression;

              if (_isValidExpression(expression)) {
                try {
                  result = double.parse(_simpleEval(parsed)).toStringAsFixed(0);
                } catch (_) {}
              }

              Navigator.pop(context);

              widget.onSubmit(int.parse(result.replaceAll('.', '')));
            },
          ),

          const SizedBox(height: 16),

          _buildKeypad(),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // =========================
  // KEYPAD
  // =========================

  Widget _buildKeypad() {
    final keys = [
      ['10.000', '20.000', '50.000', '100.000'],
      ['7', '8', '9', '⌫'],
      ['4', '5', '6', '÷'],
      ['1', '2', '3', '×'],
      ['C', '0', '=', '+'],
    ];

    return Column(
      children: keys.map((row) {
        return Row(
          children: row.map((key) {
            final bool isOperator = ['÷', '×', '+', '-', '='].contains(key);
            final bool isClear = key == 'C';
            final bool isNominal = key.contains('.');

            return Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    if (key == 'C') {
                      _onClear();
                    } else if (key == '⌫') {
                      _onBackspace();
                    } else if (key == '=') {
                      _onEqual();
                    } else if (key.contains('.')) {
                      _onNominal(key);
                    } else {
                      _onKeyTap(key);
                    }
                  },
                  child: Container(
                    height: 52,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: isNominal
                          ? AppColors.darkGrey
                          : isClear
                          ? AppColors.error.withValues(alpha: 0.1)
                          : isOperator
                          ? AppColors.secondary.withValues(alpha: 0.1)
                          : AppColors.surfaceGrey,
                    ),
                    child: isNominal
                        ? TextApp.small(
                            key,
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                          )
                        : TextApp.h2(
                            key,
                            color: isClear
                                ? AppColors.error
                                : isOperator
                                ? AppColors.secondary
                                : AppColors.textPrimary,
                          ),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}
