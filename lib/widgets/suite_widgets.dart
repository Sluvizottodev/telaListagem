import 'package:flutter/material.dart';

import '../models/motel_model.dart';
import 'itens_suites.dart';
import 'motel_item.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'periodo_widgets.dart';


class SuiteItem extends StatelessWidget {
  final Suite suite;

  const SuiteItem({Key? key, required this.suite}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Divisor entre suítes
        const Divider(
          height: 1,
          thickness: 1,
          color: Color(0xFFEEEEEE),
        ),
        // Foto da Suíte
        AspectRatio(
          aspectRatio: 16 / 9,
          child: CachedNetworkImage(
            imageUrl: suite.fotos.first,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: Colors.grey[200],
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              color: Colors.grey[200],
              child: const Icon(Icons.error),
            ),
          ),
        ),
        // Nome da Suíte (Centralizado)
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          child: Center(
            child: Text(
              suite.nome.toLowerCase(),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        // Widget de Ícones com "ver mais"
        ItensSuitesWidget(suite: suite),
        const SizedBox(height: 16),
        // Períodos e Preços
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              ...suite.periodos.take(3).map((periodo) => PeriodoItem(periodo: periodo)).toList(),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}