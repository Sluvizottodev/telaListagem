import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:replica_list_moteis/models/motel_model.dart';
import 'package:replica_list_moteis/providers/motel_provider.dart';
import 'package:replica_list_moteis/services/api_service.dart';

import 'motel_provider_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ApiService>()])

void main() {
  late MotelProvider provider;
  late MockApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();
    provider = MotelProvider(apiService: mockApiService);
  });

  group('MotelProvider Tests', () {
    test('initial state should be correct', () {
      expect(provider.motels, isEmpty);
      expect(provider.selectedFilters, isEmpty);
      expect(provider.isLoading, isFalse);
    });

    test('toggleFilter should add and remove filters', () {
      provider.toggleFilter('hidro');
      expect(provider.selectedFilters.contains('hidro'), isTrue);

      provider.toggleFilter('hidro');
      expect(provider.selectedFilters.contains('hidro'), isFalse);
    });

    test('fetchMotels should update state correctly', () async {
      final mockMotels = [
        Motel(
          fantasia: 'Test Motel',
          logo: 'test.png',
          bairro: 'Test',
          distancia: 1.0,
          suites: [],
        )
      ];

      when(mockApiService.fetchAllMotels())
          .thenAnswer((_) async => mockMotels);

      await provider.fetchMotels();

      expect(provider.motels, equals(mockMotels));
      expect(provider.isLoading, isFalse);
    });
  });
}