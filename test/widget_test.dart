import 'package:flutter_test/flutter_test.dart';
import 'package:qual_time/main.dart';

void main() {
  testWidgets('renders main navigation', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('JOGO'), findsOneWidget);
    expect(find.text('TIMES'), findsOneWidget);
    expect(find.text('RANKING'), findsOneWidget);
  });
}
