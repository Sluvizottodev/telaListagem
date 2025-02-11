import 'package:flutter/material.dart';
import '../models/motel_model.dart';

class ItensSuitesWidget extends StatefulWidget {
  final Suite suite;

  const ItensSuitesWidget({super.key, required this.suite});

  @override
  _ItensSuitesWidgetState createState() => _ItensSuitesWidgetState();
}

class _ItensSuitesWidgetState extends State<ItensSuitesWidget> {
  bool _showDetails = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth * 0.023; // Tamanho de fonte responsivo

    return Column(
      children: [
        Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 16.0,
            runSpacing: 12.0,
            children: [
              ...widget.suite.categoriaItens.map((item) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Image.network(
                        item.icone,
                        fit: BoxFit.contain,
                      ),
                    ),
                    if (_showDetails)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          item.nome,
                          style: TextStyle(
                            fontSize: fontSize, // Tamanho de fonte adaptável
                            color: Colors.black,
                          ),
                        ),
                      ),
                  ],
                );
              }).toList(),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showDetails = !_showDetails;
                  });
                },
                child: Column(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Icon(
                        _showDetails
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        size: 24,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        _showDetails ? 'Ver menos' : 'Ver todos',
                        style: TextStyle(
                          fontSize: fontSize, // Tamanho de fonte adaptável
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
