import 'dart:convert';
import 'dart:io';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart'; // Importar o parser HTML
import '../models/motel_model.dart';

class ApiService {
  final String apiUrl1 = "https://jsonkeeper.com/b/1IXK";
  final String apiUrl2 = "https://www.npoint.io/docs/e728bb91e0cd56cc0711";

  HttpClient _httpClient = HttpClient();

  ApiService() {
    _httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }

  Future<List<Motel>> fetchMotelsFromApi1() async {
    final ioClient = IOClient(_httpClient);
    final response = await ioClient.get(Uri.parse(apiUrl1));

    if (response.statusCode == 200) {
      try {
        if (response.body.startsWith('{')) {
          // Resposta JSON
          Map<String, dynamic> data = json.decode(response.body);
          List<dynamic> motelsList = data['data']['moteis'];
          return motelsList.map((json) => Motel.fromJson(json)).toList();
        } else {
          // Resposta HTML
          return _extractMotelsFromHtml(response.body);
        }
      } catch (e) {
        throw Exception('Erro ao analisar a resposta: $e');
      }
    } else {
      throw Exception('Falha ao carregar motéis da API 1. Status: ${response.statusCode}');
    }
  }

  // Método para extrair motéis a partir do HTML
  List<Motel> _extractMotelsFromHtml(String htmlContent) {
    final document = parse(htmlContent);  // Parse do HTML
    List<Motel> motels = [];

    // Extrair informações necessárias do HTML
    var motelElements = document.querySelectorAll('.motel-item');  // Supondo que cada motel esteja em um elemento com a classe .motel-item

    for (var motelElement in motelElements) {
      var fantasia = motelElement.querySelector('.motel-fantasia')?.text ?? 'N/A';
      var logo = motelElement.querySelector('.motel-logo')?.attributes['src'] ?? '';
      var bairro = motelElement.querySelector('.motel-bairro')?.text ?? '';
      var distancia = double.tryParse(motelElement.querySelector('.motel-distancia')?.text ?? '0') ?? 0.0;

      // Adicionar mais campos conforme necessário

      motels.add(Motel(
        fantasia: fantasia,
        logo: logo,
        bairro: bairro,
        distancia: distancia,
        suites: [],  // Supondo que você não tem informações de suítes no HTML
      ));
    }

    return motels;
  }

  Future<List<Motel>> fetchMotelsFromApi2() async {
    final ioClient = IOClient(_httpClient);
    final response = await ioClient.get(Uri.parse(apiUrl2));
    if (response.statusCode == 200) {
      try {
        if (response.body.startsWith('{')) {
          Map<String, dynamic> data = json.decode(response.body);
          List<dynamic> motelsList = data['data']['moteis'];
          return motelsList.map((json) => Motel.fromJson(json)).toList();
        } else {
          return _extractMotelsFromHtml(response.body); // Tratar HTML
        }
      } catch (e) {
        throw Exception('Erro ao analisar a resposta: $e');
      }
    } else {
      throw Exception('Falha ao carregar motéis da API 2. Status: ${response.statusCode}');
    }
  }

  Future<List<Motel>> fetchAllMotels() async {
    List<Motel> motelsFromApi1 = await fetchMotelsFromApi1();
    List<Motel> motelsFromApi2 = await fetchMotelsFromApi2();

    List<Motel> allMotels = [...motelsFromApi1, ...motelsFromApi2];

    return allMotels;
  }
}
