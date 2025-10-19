import 'package:flutter_test/flutter_test.dart';
import 'package:el_dorado_track/main.dart';

void main() {
  testWidgets('App starts without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const ElDoradoTrackApp());
    expect(find.byType(ElDoradoTrackApp), findsOneWidget);
  });
}