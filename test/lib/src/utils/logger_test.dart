import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_copy/src/utils/logger.dart';
import 'package:logger/logger.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'logger_test.mocks.dart';

@GenerateNiceMocks([MockSpec<LogEvent>()])
void main() {
  test('MyPrinter log function test', () {
    final mockLogEvent = MockLogEvent();
    final sut = MyPrinter('test');
    when(mockLogEvent.level).thenReturn(Level.debug);
    when(mockLogEvent.message).thenReturn("i'm in test");
    final response = sut.log(mockLogEvent);

    expect(response, ["Level.debug  🐛 test - i'm in test"]);
  });
}
