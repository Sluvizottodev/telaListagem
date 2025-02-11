import 'package:flutter/material.dart';
import '../models/motel_model.dart';
import '../services/api_service.dart';

class MotelProvider with ChangeNotifier {
  List<Motel> _motels = [];
  bool _isLoading = false;

  List<Motel> get motels => _motels;
  bool get isLoading => _isLoading;

  final ApiService _apiService = ApiService();

  Future<void> fetchMotels() async {
    _isLoading = true;
    notifyListeners();

    try {
      _motels = await _apiService.fetchAllMotels();
      print("Motéis carregados: ${_motels.length}");
      print("Primeiro motel: ${_motels[0].logo}");  // Verificando o primeiro logo
    } catch (e) {
      print("Erro ao carregar os motéis: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
