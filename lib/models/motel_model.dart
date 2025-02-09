class Motel {
  final String name;
  final double price;
  final String imageUrl;

  Motel({
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  factory Motel.fromJson(Map<String, dynamic> json) {
    // Garantir que a chave 'name' exista
    String name = json['fantasia'] ?? 'Nome não disponível';
    double price = 0.0;

    // Garantir que a chave 'price' exista e seja convertida corretamente
    if (json['suites'] != null && json['suites'].isNotEmpty) {
      var suite = json['suites'][0];
      if (suite['periodos'] != null && suite['periodos'].isNotEmpty) {
        price = suite['periodos'][0]['valor']?.toDouble() ?? 0.0;
      }
    }

    String imageUrl = json['logo'] ?? 'URL da imagem não disponível';

    return Motel(
      name: name,
      price: price,
      imageUrl: imageUrl,
    );
  }
}
