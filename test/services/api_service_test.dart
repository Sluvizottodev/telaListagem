import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:replica_list_moteis/models/motel_model.dart';
import 'package:replica_list_moteis/services/api_service.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
import 'api_service_test.mocks.dart';

void main() {
  late ApiService apiService;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    apiService = ApiService();
  });

  group('ApiService Tests', () {
    test('fetchMotelsFromApi1 should return list of motels', () async {
      final result = await apiService.fetchMotelsFromApi1();
      expect(result, isA<List<Motel>>());

      if (result.isNotEmpty) {
        final motel = result.first;
        expect(motel.fantasia, isNotEmpty);
        expect(motel.logo, isNotEmpty);
        expect(motel.bairro, isNotEmpty);
        expect(motel.distancia, isA<double>());

        if (motel.suites.isNotEmpty) {
          final suite = motel.suites.first;
          expect(suite.nome, isNotEmpty);
          expect(suite.fotos, isA<List<String>>());
          expect(suite.periodos, isA<List<Periodo>>());
          expect(suite.categoriaItens, isA<List<CategoriaItem>>());
        }
      }
    });

    test('fetchAllMotels should return combined list', () async {
      final result = await apiService.fetchAllMotels();
      expect(result, isA<List<Motel>>());
      expect(result.isNotEmpty, isTrue);
    });

    test('should handle error response', () async {
      when(mockClient.get(any)).thenAnswer(
            (_) async => http.Response('Not Found', 404),
      );

      final apiServiceWithMock = ApiService();

      try {
        await apiServiceWithMock.fetchMotelsFromApi1();
        fail('A exceção esperada não foi lançada');
      } catch (e) {
        expect(e, isException);
      }
    });

    test('should handle malformed JSON response', () async {
      when(mockClient.get(any)).thenAnswer(
            (_) async => http.Response('{"invalid": "json"}', 200),
      );

      final apiServiceWithMock = ApiService();

      try {
        await apiServiceWithMock.fetchMotelsFromApi1();
        fail('A exceção esperada não foi lançada');
      } catch (e) {
        expect(e, isException);
      }
    });

    test('should parse suite items correctly', () async {
      final result = await apiService.fetchMotelsFromApi1();

      if (result.isNotEmpty && result.first.suites.isNotEmpty) {
        final suite = result.first.suites.first;

        expect(suite.categoriaItens, isA<List<CategoriaItem>>());

        if (suite.categoriaItens.isNotEmpty) {
          final item = suite.categoriaItens.first;
          expect(item.nome, isNotEmpty);
          expect(item.icone, isNotEmpty);
        }
      }
    });
  });
}
