import 'package:flutter/material.dart';
import '../models/motel_model.dart';

class ItensSuitesWidget extends StatelessWidget {
  final Suite suite;

  ItensSuitesWidget({required this.suite});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center, // Centraliza os itens
      spacing: 16.0, // Define o espaçamento horizontal entre os itens
      runSpacing: 12.0, // Define o espaçamento vertical entre as linhas
      children: suite.categoriaItens.map((item) {
        return Column(
          mainAxisSize: MainAxisSize.min, // Garante que a coluna ocupe apenas o necessário
          children: [
            Image.network(
              item.icone,
              width: MediaQuery.of(context).size.width * 0.12, // Responsividade (12% da largura da tela)
              height: MediaQuery.of(context).size.width * 0.12, // Responsividade (12% da largura da tela)
              fit: BoxFit.cover,
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
