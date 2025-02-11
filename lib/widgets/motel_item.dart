import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';  // Importando o pacote para cache de imagens
import '../models/motel_model.dart';

class MotelItem extends StatelessWidget {
  final Motel motel;

  MotelItem({required this.motel});

  @override
  Widget build(BuildContext context) {
    print('Imagem do motel: ${motel.logo}');  // Verificando a URL da imagem

    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        leading: CachedNetworkImage(
          imageUrl: motel.logo,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
          fadeInDuration: Duration(milliseconds: 500),
        ),
        title: Text(motel.fantasia),
        subtitle: Text('${motel.bairro} - ${motel.distancia} km'),
      ),
    );
  }
}
