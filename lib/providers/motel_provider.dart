import 'package:flutter/material.dart';
import '../models/motel_model.dart';
import '../services/api_service.dart';

class MotelProvider with ChangeNotifier {
  List<Motel> _motels = [];
  bool _isLoading = false;
  ApiService apiService;

  MotelProvider({ApiService? apiService})
      : apiService = apiService ?? ApiService();

  List<Motel> get motels => _motels;
  bool get isLoading => _isLoading;

  Future<void> fetchMotels() async {
    _isLoading = true;
    notifyListeners();

    try {
      _motels = await apiService.fetchAllMotels();
      print("Motéis carregados: ${_motels.length}");
      print("Primeiro motel: ${_motels[0].logo}");
    } catch (e) {
      print("Erro ao carregar os motéis: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
