import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:replica_list_moteis/providers/motel_provider.dart';
import 'package:replica_list_moteis/services/api_service.dart';
import 'package:replica_list_moteis/models/motel_model.dart';

// Mock da classe ApiService
class MockApiService extends Mock implements ApiService {}

void main() {
  group('MotelProvider Tests', () {
    late MotelProvider provider;
    late MockApiService mockApiService;

    setUp(() {
      mockApiService = MockApiService();
      provider = MotelProvider(apiService: mockApiService);
    });

    test('fetchMotels updates motels list and isLoading state', () async {
      // Mockando o retorno de fetchAllMotels para um Future com uma lista de motéis vazia
      when(mockApiService.fetchAllMotels()).thenAnswer((_) async => <Motel>[]);

      // Verificando o estado inicial (deve ser falso, pois não há dados carregados ainda)
      expect(provider.isLoading, false);

      // Chamando o método para buscar os motéis
      await provider.fetchMotels();

      // Verificando o estado final (não deve estar carregando mais)
      expect(provider.isLoading, false);
      expect(provider.motels, <Motel>[]);  // Verifica que a lista de motéis está vazia

      // Verificando se o método fetchAllMotels foi chamado corretamente
      verify(mockApiService.fetchAllMotels()).called(1);
    });

  });
}
