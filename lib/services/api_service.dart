import 'dart:convert';
import 'dart:io';
import 'package:http/io_client.dart';
import '../models/motel_model.dart';

class ApiService {
  final List<String> apiUrls = [
    "https://jsonkeeper.com/b/1IXK",
    "https://www.npoint.io/docs/e728bb91e0cd56cc0711" // URL da API
  ];

  Future<List<Motel>> fetchMotels() async {
    List<Motel> combinedMotels = [];

    final HttpClient httpClient = HttpClient()
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final ioClient = IOClient(httpClient);

    for (String url in apiUrls) {
      try {
        final response = await ioClient.get(Uri.parse(url));

        if (response.statusCode == 200) {
          final contentType = response.headers['content-type'];

          if (contentType != null && contentType.contains('application/json')) {
            // Decodificando corretamente a resposta
            final data = json.decode(utf8.decode(response.bodyBytes));

            // Imprimindo o JSON recebido para depuração
            print("Resposta da API: $data");

            if (data['sucesso'] != null && data['sucesso'] == true && data['data'] != null) {
              final motelsList = data['data']['moteis'] as List<dynamic>;

              combinedMotels.addAll(
                motelsList.map((json) {
                  return Motel.fromJson(json);
                }).toList(),
              );
            } else {
              throw ApiException('Estrutura de dados inesperada na API: $url');
            }
          } else {
            throw ApiException('Resposta inesperada da API (não JSON): $url');
          }
        } else {
          throw HttpException(
              'Erro ao carregar os motéis da URL: $url. Status code: ${response.statusCode}');
        }
      } catch (e) {
        print("Erro ao buscar dados da API $url: $e");
        rethrow;
      }
    }

    return combinedMotels;
  }
}

class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  @override
  String toString() {
    return 'ApiException: $message';
  }
}
