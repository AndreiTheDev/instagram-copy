import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_copy/src/utils/debouncer.dart';

void main() {
  group('Debouncer Test Group', () {
    test('Debouncer calls function', () async {
      late final bool didCallFunction;
      final sut = Debounce(const Duration(seconds: 1));
      expect(sut.delay, const Duration(seconds: 1));
      sut.call(() {
        didCallFunction = true;
      });
      await Future.delayed(const Duration(milliseconds: 1500));
      expect(didCallFunction, true);
    });

    test('Debouncer disposed cancel function call', () async {
      bool didCallFunction = false;
      final sut = Debounce(const Duration(seconds: 1));
      expect(sut.delay, const Duration(seconds: 1));
      sut
        ..call(() {
          didCallFunction = true;
        })
        ..dispose();
      await Future.delayed(const Duration(milliseconds: 1500));
      expect(didCallFunction, false);
    });
  });
}
