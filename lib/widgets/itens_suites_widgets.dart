import 'package:flutter/material.dart';
import '../models/motel_model.dart';

class ItensSuitesWidget extends StatefulWidget {
  final Suite suite;

  const ItensSuitesWidget({Key? key, required this.suite}) : super(key: key);

  @override
  State<ItensSuitesWidget> createState() => _ItensSuitesWidgetState();
}

class _ItensSuitesWidgetState extends State<ItensSuitesWidget> {
  bool _showAllItems = false;

  @override
  Widget build(BuildContext context) {
    final items = _showAllItems
        ? widget.suite.categoriaItens
        : widget.suite.categoriaItens.take(5).toList();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 32.0,
            runSpacing: 16.0,
            children: [
              ...items.map((item) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.network(
                      item.icone,
                      width: 40,
                      height: 40,
                      color: Colors.grey[600],
                    ),
                  ],
                );
              }).toList(),
            ],
          ),
          if (widget.suite.categoriaItens.length > 4) ...[
            const SizedBox(height: 12),
            InkWell(
              onTap: () {
                setState(() {
                  _showAllItems = !_showAllItems;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _showAllItems ? 'ver menos' : 'ver mais',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    _showAllItems
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.grey[600],
                    size: 20,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}