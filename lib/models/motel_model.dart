
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

class CategoriaItem {
  final String nome;
  final String icone;

  CategoriaItem({
    required this.nome,
    required this.icone,
  });

  factory CategoriaItem.fromJson(Map<String, dynamic> json) {
    return CategoriaItem(
      nome: json['nome'],
      icone: json['icone'],
    );
  }
}

class Suite {
  final String nome;
  final List<String> fotos;
  final List<Periodo> periodos;
  final List<CategoriaItem> categoriaItens;  // Lista de itens de categoria

  Suite({
    required this.nome,
    required this.fotos,
    required this.periodos,
    required this.categoriaItens,  // Lista de itens de categoria
  });

  factory Suite.fromJson(Map<String, dynamic> json) {
    var periodosList = json['periodos'] as List? ?? [];
    List<Periodo> periodos = periodosList.map((i) => Periodo.fromJson(i)).toList();

    var categoriaItensList = json['categoriaItens'] as List? ?? [];  // Garante que a lista nunca será null
    List<CategoriaItem> categoriaItens = categoriaItensList.map((i) => CategoriaItem.fromJson(i)).toList();

    return Suite(
      nome: json['nome'] ?? '',
      fotos: List<String>.from(json['fotos'] ?? []),
      periodos: periodos,
      categoriaItens: categoriaItens,  // Garantir que a lista seja inicializada corretamente
    );
  }
}

class Periodo {
  final String tempoFormatado;
  final double valor;
  final double valorTotal;
  final Desconto? desconto;

  Periodo({
    required this.tempoFormatado,
    required this.valor,
    required this.valorTotal,
    this.desconto,
  });

  factory Periodo.fromJson(Map<String, dynamic> json) {
    return Periodo(
      tempoFormatado: json['tempoFormatado'],
      valor: json['valor'],
      valorTotal: json['valorTotal'] ?? json['valor'],
      desconto: json['desconto'] != null ? Desconto.fromJson(json['desconto']) : null,
    );
  }
}

class Desconto {
  final double desconto;

  Desconto({
    required this.desconto,
  });

  factory Desconto.fromJson(Map<String, dynamic> json) {
    return Desconto(
      desconto: json['desconto'],
    );
  }
}