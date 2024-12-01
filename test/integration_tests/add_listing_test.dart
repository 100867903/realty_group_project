import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:realty_group_project/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('User adds a new listing', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Navigate to Add Listing Page
    final addButton = find.byIcon(Icons.add);
    await tester.tap(addButton);
    await tester.pumpAndSettle();

    // Fill out the form fields
    await tester.enterText(find.byLabelText('Address'), '123 Main St');
    await tester.enterText(find.byLabelText('Number of Bedrooms'), '3');
    await tester.enterText(find.byLabelText('Number of Bathrooms'), '2');
    await tester.enterText(find.byLabelText('Square Feet'), '1500');
    await tester.enterText(find.byLabelText('Price'), '350000');
    await tester.enterText(find.byLabelText('Image URL'), 'https://example.com/image.jpg');

    // Submit the form
    final submitButton = find.text('Add Listing');
    await tester.tap(submitButton);
    await tester.pumpAndSettle();

    // Verify the listing appears in the main listings page
    expect(find.text('123 Main St'), findsOneWidget);
    expect(find.text('3 beds, 2 baths, 1500 sqft'), findsOneWidget);
    expect(find.text('\$350,000.00'), findsOneWidget);
  });
}
