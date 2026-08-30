import 'package:flutter_test/flutter_test.dart';
import 'package:protect/main.dart';

void main() {
  testWidgets('ProtectApp smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProtectApp());

    // Verify app builds cleanly
    expect(find.byType(ProtectApp), findsOneWidget);
  });
}
