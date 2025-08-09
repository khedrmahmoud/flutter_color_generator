import 'package:flutter_color_generator/core/utils/color_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ColorHelper', () {
    const int minColorValue = 0x00000000;
    const int maxColorValue = 0xFFFFFFFF;
    test('should generate a valid color hex code', () {
      final color = ColorHelper.generateRandomColor();
      expect(color.toARGB32(), inInclusiveRange(minColorValue, maxColorValue));
    });

    test('should convert Color to HEX string correctly', () {
      final color = ColorHelper.generateRandomColor();
      final hex = ColorHelper.toHex(color);
      expect(hex, matches(r'^#[0-9A-F]{6}$'));
    });
  });
}
