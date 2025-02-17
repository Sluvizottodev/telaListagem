import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:replica_list_moteis/controllers/motel_controller.dart';
import 'package:replica_list_moteis/providers/motel_provider.dart';

import '../view/motel_list_screen_test.dart';
import '../view/motel_list_screen_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MotelProvider>()])


void main() {
  late MotelController controller;
  late MockMotelProvider mockProvider;

  setUp(() {
    mockProvider = MockMotelProvider();
    controller = MotelController(mockProvider);
  });

  group('MotelController Tests', () {
    test('loadMotels should call provider fetchMotels', () async {
      when(mockProvider.fetchMotels()).thenAnswer((_) async {});

      await controller.loadMotels();

      verify(mockProvider.fetchMotels()).called(1);
    });

    test('loadMotels should handle errors', () async {
      when(mockProvider.fetchMotels())
          .thenThrow(Exception('Test error'));

      expect(() => controller.loadMotels(), throwsException);
    });
  });
}