// lib/models/motel_model.dart
class Motel {
  final String fantasia;
  final String logo;
  final String bairro;
  final double distancia;
  final List<Suite> suites;

  Motel({
    required this.fantasia,
    required this.logo,
    required this.bairro,
    required this.distancia,
    required this.suites,
  });

  factory Motel.fromJson(Map<String, dynamic> json) {
    var suitesList = json['suites'] as List;
    List<Suite> suites = suitesList.map((i) => Suite.fromJson(i)).toList();

    return Motel(
      fantasia: json['fantasia'] ?? '',
      logo: json['logo'] ?? '',
      bairro: json['bairro'] ?? '',
      distancia: json['distancia'] ?? '',
      suites: suites,
    );
  }
}

class Suite {
  final String nome;
  final List<String> fotos;
  final List<Periodo> periodos;

  Suite({
    required this.nome,
    required this.fotos,
    required this.periodos,
  });

  factory Suite.fromJson(Map<String, dynamic> json) {
    var periodosList = json['periodos'] as List;
    List<Periodo> periodos = periodosList.map((i) => Periodo.fromJson(i)).toList();

    return Suite(
      nome: json['nome'],
      fotos: List<String>.from(json['fotos']),
      periodos: periodos,
    );
  }
}

class Periodo {
  final String tempoFormatado;
  final double valor;

  Periodo({
    required this.tempoFormatado,
    required this.valor,
  });

  factory Periodo.fromJson(Map<String, dynamic> json) {
    return Periodo(
      tempoFormatado: json['tempoFormatado'],
      valor: json['valor'],
    );
  }
}