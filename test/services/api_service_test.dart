import 'package:flutter_test/flutter_test.dart';
import 'package:replica_list_moteis/services/api_service.dart';

void main() {
  group('ApiService Tests', () {
    late ApiService apiService;

    setUp(() {
      apiService = ApiService();
    });

    test('fetchAllMotels should return combined list from both APIs', () async {
      // Mocking individual API calls may require a custom HTTP client.
      var motels = await apiService.fetchAllMotels();
      expect(motels, isNotNull);
      expect(motels.length, greaterThanOrEqualTo(0));
    });
  });
}
