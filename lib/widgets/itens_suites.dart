import 'package:flutter/material.dart';
import '../models/motel_model.dart';

class ItensSuitesWidget extends StatelessWidget {
  final Suite suite;

  const ItensSuitesWidget({super.key, required this.suite});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start, // Alinha os itens à esquerda
      spacing: 16.0, // Define o espaçamento horizontal entre os itens
      runSpacing: 12.0, // Define o espaçamento vertical entre as linhas
      children: suite.categoriaItens.map((item) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Usar CachedNetworkImage para carregar a imagem do ícone
            SizedBox(
              width: 48,
              height: 48,
              child: Image.network(
                item.icone,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              item.nome,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        );
      }).toList(),
    );
  }
}
