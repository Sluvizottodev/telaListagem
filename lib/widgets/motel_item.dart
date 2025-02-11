import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/motel_model.dart';
import 'itens_suites.dart';

class MotelItem extends StatelessWidget {
  final Motel motel;

  const MotelItem({super.key, required this.motel});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0)),
            child: CachedNetworkImage(
              imageUrl: motel.suites.isNotEmpty && motel.suites.first.fotos.isNotEmpty
                  ? motel.suites.first.fotos.first
                  : motel.logo,
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      motel.fantasia,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    const Icon(Icons.favorite_border, color: Colors.grey),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.grey, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '${motel.bairro} - ${motel.distancia} km',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ItensSuitesWidget(suite: motel.suites.first),
                const SizedBox(height: 16),
                ..._buildPeriodWidgets(motel.suites.first),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPeriodWidgets(Suite suite) {
    return suite.periodos.take(2).map((periodo) {
      final valorComDesconto = periodo.desconto != null ? periodo.valorTotal : periodo.valor;
      return Container(
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(8.0),
        ),
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(periodo.tempoFormatado, style: const TextStyle(fontSize: 16, color: Colors.black)),
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 16),
                children: [
                  if (periodo.desconto != null)
                    TextSpan(
                      text: 'R\$ ${periodo.valor.toStringAsFixed(2)}  ',
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                      ),
                    ),
                  TextSpan(
                    text: 'R\$ ${valorComDesconto.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: periodo.desconto != null ? Colors.green : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      );
    }).toList();
  }
}

