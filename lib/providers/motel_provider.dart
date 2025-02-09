import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../models/motel_model.dart';
import '../services/api_service.dart';

class MotelProvider with ChangeNotifier {
  List<Motel> _motels = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Motel> get motels => _motels;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final ApiService _apiService = ApiService();

  Future<void> fetchMotels() async {
    _isLoading = true;
    _errorMessage = null;
    // Agende a notificação para depois do frame
    SchedulerBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    try {
      _motels = await _apiService.fetchMotels();
    } catch (e) {
      debugPrint("Erro ao buscar motéis: $e");
      _errorMessage = "Falha ao carregar a lista de motéis.";
    } finally {
      _isLoading = false;
      // Agende a notificação para depois do frame
      SchedulerBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }
}
