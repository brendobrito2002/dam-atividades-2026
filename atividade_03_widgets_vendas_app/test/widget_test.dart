import 'package:flutter_test/flutter_test.dart';

import 'package:vendas_app/src/app.dart';

void main() {
  testWidgets('App initialization test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const App());

    // Verify that our initial text is shown.
    expect(find.text('Vendas App'), findsOneWidget);
  });
}
