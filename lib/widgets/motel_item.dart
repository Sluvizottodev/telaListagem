import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/motel_model.dart';
import 'itens_suites.dart';  // Importa o widget de ícones da suíte

class MotelItem extends StatelessWidget {
  final Motel motel;

  MotelItem({required this.motel});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 32,
                  backgroundImage: CachedNetworkImageProvider(motel.logo),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    motel.fantasia,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              '${motel.bairro} - ${motel.distancia} km',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 16),

          CachedNetworkImage(
            imageUrl: motel.suites.isNotEmpty && motel.suites.first.fotos.isNotEmpty
                ? motel.suites.first.fotos.first
                : motel.logo,
            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 16),

          ItensSuitesWidget(suite: motel.suites.first),

          const SizedBox(height: 16),
          ...motel.suites.take(1).expand((suite) {
            return suite.periodos.take(3).map((periodo) {
              final valorComDesconto = periodo.desconto != null
                  ? periodo.valorTotal
                  : periodo.valor;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(periodo.tempoFormatado, style: const TextStyle(fontSize: 16)),
                    Text(
                      'R\$ ${valorComDesconto.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: periodo.desconto != null ? Colors.green : Colors.black,
                      ),
                    ),
                  ],
                ),
              );
            }).toList();
          }),
        ],
      ),
    );
  }
}