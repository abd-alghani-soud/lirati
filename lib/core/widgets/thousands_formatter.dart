import 'package:flutter/services.dart';

class ThousandsFormatter extends TextInputFormatter {
  final int maxDigits;
  final String separator;

  ThousandsFormatter({required this.maxDigits, this.separator = ','});

  String _formatDigits(String digits) {
    if (digits.isEmpty) return '';
    final reversed = digits.split('').reversed.join();
    final chunks = RegExp(
      r'.{1,3}',
    ).allMatches(reversed).map((m) => m.group(0)).toList();
    final joined = chunks.join(separator);
    return joined.split('').reversed.join();
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String onlyDigits = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (onlyDigits.length > maxDigits) {
      onlyDigits = onlyDigits.substring(0, maxDigits);
    }
    final formatted = _formatDigits(onlyDigits);
    int digitIndex = 0;
    final cursorPosition = newValue.selection.baseOffset.clamp(
      0,
      newValue.text.length,
    );
    for (int i = 0; i < cursorPosition; i++) {
      if (i < newValue.text.length &&
          RegExp(r'\d').hasMatch(newValue.text[i])) {
        digitIndex++;
      }
    }
    int newOffset = 0;
    if (digitIndex == 0) {
      newOffset = 0;
    } else {
      int digitsSeen = 0;
      for (int i = 0; i < formatted.length; i++) {
        if (RegExp(r'\d').hasMatch(formatted[i])) digitsSeen++;
        if (digitsSeen == digitIndex) {
          newOffset = i + 1;
          break;
        }
      }
      if (digitsSeen < digitIndex) {
        newOffset = formatted.length;
      }
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: newOffset),
      composing: TextRange.empty,
    );
  }
}
