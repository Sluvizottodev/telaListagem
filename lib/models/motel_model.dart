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
      distancia: json['distancia'] ?? 0.0,
      suites: suites,
    );
  }
}

class Suite {
  final String nome;
  final List<String> fotos;
  final List<Item> itens;
  final List<CategoriaItem> categoriaItens;
  final List<Periodo> periodos;

  Suite({
    required this.nome,
    required this.fotos,
    required this.itens,
    required this.categoriaItens,
    required this.periodos,
  });

  factory Suite.fromJson(Map<String, dynamic> json) {
    print('Processando Suite: ${json['nome']}');

    try {
      var itensList = json['itens'] as List? ?? [];
      List<Item> itens = itensList.map((i) => Item.fromJson(i)).toList();

      var categoriaItensList = json['categoriaItens'] as List? ?? [];
      print('categoriaItensList raw: $categoriaItensList');

      List<CategoriaItem> categoriaItens = [];
      try {
        categoriaItens = categoriaItensList
            .map((i) => CategoriaItem.fromJson(i))
            .toList();
      } catch (e) {
        print('Erro ao processar categoriaItens: $e');
      }

      var periodosList = json['periodos'] as List? ?? [];
      List<Periodo> periodos = periodosList.map((i) => Periodo.fromJson(i)).toList();

      return Suite(
        nome: json['nome'] ?? '',
        fotos: List<String>.from(json['fotos'] ?? []),
        itens: itens,
        categoriaItens: categoriaItens,
        periodos: periodos,
      );
    } catch (e) {
      print('Erro ao processar Suite: $e');
      return Suite(
        nome: json['nome'] ?? '',
        fotos: [],
        itens: [],
        categoriaItens: [],
        periodos: [],
      );
    }
  }
}

class Item {
  final String nome;

  Item({required this.nome});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      nome: json['nome'] ?? '',
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
    try {
      return CategoriaItem(
        nome: json['nome'] ?? '',
        icone: json['icone'] ?? '',
      );
    } catch (e) {
      print('Erro ao processar CategoriaItem: $e');
      return CategoriaItem(
        nome: '',
        icone: '',
      );
    }
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