
import 'package:anywhere_variant_two/features/wireviewer_fearture/data_layer/models/wireviewer_model.dart';
import 'package:anywhere_variant_two/features/wireviewer_fearture/presentation_layer/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test _loadCharacters function', (WidgetTester tester) async {
    List<WireViewerCharacter> dummyCharacters = [
      WireViewerCharacter(
        name: 'Haynes',
        firstUrl: 'https://duckduckgo.com/Augustus_Haynes',
        text: 'D\'oh!',
        imageUrl: '/i/872d317a.png',
        description: 'Haynes is a fictional character on the HBO drama The Wire.',
      ),
    ];

    await tester.pumpWidget(MaterialApp(
      home: HomeScreen(
        characters: dummyCharacters,
      ),
    ));

    // Verify that the loading indicator is initially shown
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Wait for the Future.delayed duration (2 seconds in this case) for loading to complete
    await tester.binding.delayed(const Duration(seconds: 2));

    // Verify that the loading indicator is no longer displayed
    await tester.pumpAndSettle();
    expect(find.byType(CircularProgressIndicator), findsNothing);

    // Verify that the filteredCharacters list has been updated with the dummyCharacters data
    expect(find.byType(CharacterListItem), findsOneWidget);

    // Verify that the character list is displayed with the correct number of items
    expect(find.byType(CharacterListItem), findsNWidgets(dummyCharacters.length));
  });
}
