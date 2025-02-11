import 'dart:convert';
import 'dart:io';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
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
        final responseBody = utf8.decode(response.bodyBytes);  // Decodificando a resposta como UTF-8

        if (responseBody.startsWith('{')) {
          Map<String, dynamic> data = json.decode(responseBody);
          if (data.containsKey('data') && data['data'].containsKey('moteis')) {
            List<dynamic> motelsList = data['data']['moteis'];
            return motelsList.map((json) => Motel.fromJson(json)).toList();
          } else {
            throw Exception('Resposta JSON mal formatada (API 1)');
          }
        } else {
          return _extractMotelsFromHtml(responseBody);
        }
      } catch (e) {
        print("Erro ao processar resposta da API 1: $e");
        throw Exception('Erro ao processar a resposta: $e');
      }
    } else {
      print("Falha ao carregar motéis da API 1. Status: ${response.statusCode}");
      throw Exception('Falha ao carregar motéis da API 1. Status: ${response.statusCode}');
    }
  }

  List<Motel> _extractMotelsFromHtml(String htmlContent) {
    final document = parse(htmlContent);  // Parse do HTML
    List<Motel> motels = [];

    var motelElements = document.querySelectorAll('.motel-item');

    for (var motelElement in motelElements) {
      var fantasia = motelElement.querySelector('.motel-fantasia')?.text ?? 'N/A';
      var logo = motelElement.querySelector('.motel-logo')?.attributes['src'] ?? '';
      var bairro = motelElement.querySelector('.motel-bairro')?.text ?? '';
      var distancia = double.tryParse(motelElement.querySelector('.motel-distancia')?.text ?? '0') ?? 0.0;

      motels.add(Motel(
        fantasia: fantasia,
        logo: logo,
        bairro: bairro,
        distancia: distancia,
        suites: [],
      ));
    }

    print("Motéis extraídos do HTML: ${motels.length}");
    return motels;
  }

  Future<List<Motel>> fetchMotelsFromApi2() async {
    final ioClient = IOClient(_httpClient);
    final response = await ioClient.get(Uri.parse(apiUrl2));

    if (response.statusCode == 200) {
      try {
        if (response.body.startsWith('{')) {
          Map<String, dynamic> data = json.decode(response.body);
          if (data.containsKey('data') && data['data'].containsKey('moteis')) {
            List<dynamic> motelsList = data['data']['moteis'];
            return motelsList.map((json) => Motel.fromJson(json)).toList();
          } else {
            throw Exception('Resposta JSON mal formatada (API 2)');
          }
        } else {
          return _extractMotelsFromHtml(response.body);  // Tratar HTML
        }
      } catch (e) {
        print("Erro ao processar resposta da API 2: $e");
        throw Exception('Erro ao processar a resposta: $e');
      }
    } else {
      print("Falha ao carregar motéis da API 2. Status: ${response.statusCode}");
      throw Exception('Falha ao carregar motéis da API 2. Status: ${response.statusCode}');
    }
  }

  Future<List<Motel>> fetchAllMotels() async {
    try {
      List<Motel> motelsFromApi1 = await fetchMotelsFromApi1();
      List<Motel> motelsFromApi2 = await fetchMotelsFromApi2();

      List<Motel> allMotels = [...motelsFromApi1, ...motelsFromApi2];

      print("Motéis totais carregados: ${allMotels.length}");
      return allMotels;
    } catch (e) {
      print("Erro ao carregar motéis de ambas as APIs: $e");
      throw Exception('Erro ao carregar motéis de ambas as APIs');
    }
  }
}
