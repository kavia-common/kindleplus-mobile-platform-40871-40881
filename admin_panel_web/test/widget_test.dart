import 'package:flutter_test/flutter_test.dart';
import 'package:admin_panel_web/main.dart';

void main() {
  testWidgets('Header shows Bookztron brand', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(find.text('Bookztron'), findsWidgets);
  });

  testWidgets('Home shows Genres and New Arrivals sections', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(find.text('Genres'), findsOneWidget);
    expect(find.text('New Arrivals'), findsOneWidget);
  });
}
