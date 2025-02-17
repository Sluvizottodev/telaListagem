import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:replica_list_moteis/providers/motel_provider.dart';
import 'package:replica_list_moteis/views/motel_list_screen.dart';

import '../controller/motel_controller_test.mocks.dart';

// Gera o arquivo de mock para MotelProvider
@GenerateNiceMocks([MockSpec<MotelProvider>()])

void main() {
  late MockMotelProvider mockProvider;

  setUp(() {
    mockProvider = MockMotelProvider();
    // Configuração padrão do mock
    when(mockProvider.motels).thenReturn([]);
    when(mockProvider.isLoading).thenReturn(false);
    when(mockProvider.selectedFilters).thenReturn(<String>{});
  });

  testWidgets('MotelListScreen should render', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<MotelProvider>.value(
          value: mockProvider,
          child: MotelListScreen(),
        ),
      ),
    );

    // Verifica se a AppBar está presente
    expect(find.byType(AppBar), findsOneWidget);

    // Verifica se o botão "Ir Agora" está presente
    expect(find.text('Ir Agora'), findsOneWidget);

    // Verifica se o botão "Ir Outro Dia" está presente
    expect(find.text('Ir Outro Dia'), findsOneWidget);
  });
}