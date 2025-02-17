import 'package:flutter_test/flutter_test.dart';
import 'package:replica_list_moteis/models/motel_model.dart';

void main() {
  group('Motel Model Tests', () {
    test('should create Motel from JSON', () {
      final json = {
        'fantasia': 'Test Motel',
        'logo': 'test.png',
        'bairro': 'Test Area',
        'distancia': 1.5,
        'suites': [],
      };

      final motel = Motel.fromJson(json);

      expect(motel.fantasia, 'Test Motel');
      expect(motel.logo, 'test.png');
      expect(motel.bairro, 'Test Area');
      expect(motel.distancia, 1.5);
      expect(motel.suites, isEmpty);
    });

    test('should create Suite from JSON', () {
      final json = {
        'nome': 'Test Suite',
        'fotos': ['photo1.jpg'],
        'itens': [{'nome': 'TV'}],
        'categoriaItens': [
          {'nome': 'Hidro', 'icone': 'hidro.png'}
        ],
        'periodos': [
          {
            'tempoFormatado': '2 horas',
            'valor': 100.0,
            'valorTotal': 100.0,
          }
        ],
      };

      final suite = Suite.fromJson(json);

      expect(suite.nome, 'Test Suite');
      expect(suite.fotos.length, 1);
      expect(suite.itens.length, 1);
      expect(suite.categoriaItens.length, 1);
      expect(suite.periodos.length, 1);
    });
  });
}