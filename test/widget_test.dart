import 'package:flutter_test/flutter_test.dart';

import 'package:qoruz_flutter_sourav/main.dart';

void main() {
  testWidgets('App starts and shows splash screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const QoruzApp());

    // Verify that Qoruz splash screen appears
    expect(find.text('QORUZ'), findsOneWidget);
  });
}
