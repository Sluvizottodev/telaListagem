import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:replica_list_moteis/widgets/suite_widgets.dart';
import '../models/motel_model.dart';
import 'itens_suites_widgets.dart';

class MotelItem extends StatefulWidget {
  final Motel motel;

  const MotelItem({Key? key, required this.motel}) : super(key: key);

  @override
  _MotelItemState createState() => _MotelItemState();
}

class _MotelItemState extends State<MotelItem> {
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cabeçalho do Motel
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo do Motel
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    widget.motel.logo,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                // Informações do Motel
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.motel.fantasia.toLowerCase(),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${widget.motel.bairro.toLowerCase()} - ${widget.motel.distancia.toStringAsFixed(1)} km',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                // Botão de Favorito
                IconButton(
                  icon: Icon(
                    isFavorited ? Icons.favorite : Icons.favorite_border,
                    color: isFavorited ? Colors.red : Colors.grey,
                    size: 28,
                  ),
                  onPressed: () {
                    setState(() {
                      isFavorited = !isFavorited;
                    });
                  },
                ),
              ],
            ),
          ),
          // Suítes
          ...widget.motel.suites.map((suite) => SuiteItem(suite: suite)).toList(),
        ],
      ),
    );
  }
}