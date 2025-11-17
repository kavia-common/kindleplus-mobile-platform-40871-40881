import 'package:flutter_test/flutter_test.dart';
import 'package:admin_panel_web/main.dart';

void main() {
  testWidgets('renders Admin Login screen by default', (WidgetTester tester) async {
    // Pump the top-level app. Without stored tokens, it should show the login page.
    await tester.pumpWidget(const AdminPanelApp());
    await tester.pumpAndSettle();

    expect(find.text('Admin Login'), findsOneWidget);
  });
}
