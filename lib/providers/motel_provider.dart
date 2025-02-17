import 'package:flutter/material.dart';
import '../models/motel_model.dart';
import '../services/api_service.dart';

class MotelProvider with ChangeNotifier {
  List<Motel> _motels = [];
  List<Motel> _filteredMotels = [];
  Set<String> _selectedFilters = {};
  bool _isLoading = false;
  ApiService apiService;

  MotelProvider({ApiService? apiService})
      : apiService = apiService ?? ApiService();

  List<Motel> get motels => _filteredMotels;
  Set<String> get selectedFilters => _selectedFilters;
  bool get isLoading => _isLoading;

  void toggleFilter(String filter) {
    if (_selectedFilters.contains(filter)) {
      _selectedFilters.remove(filter);
    } else {
      _selectedFilters.add(filter);
    }
    _applyFilters();
    notifyListeners();
  }

  void _applyFilters() {
    if (_selectedFilters.isEmpty) {
      _filteredMotels = List.from(_motels);
      return;
    }

    _filteredMotels = _motels.where((motel) {
      return motel.suites.any((suite) {
        if (_selectedFilters.contains('desconto')) {
          bool hasDiscount = suite.periodos.any((periodo) => periodo.desconto != null);
          if (!hasDiscount) return false;
        }
        if (_selectedFilters.contains('hidro')) {
          bool hasHidro = suite.categoriaItens.any((item) =>
              item.nome.toLowerCase().contains('hidro'));
          if (!hasHidro) return false;
        }
        if (_selectedFilters.contains('piscina')) {
          bool hasPiscina = suite.categoriaItens.any((item) =>
              item.nome.toLowerCase().contains('piscina'));
          if (!hasPiscina) return false;
        }
        return true;
      });
    }).toList();
  }

  Future<void> fetchMotels() async {
    _isLoading = true;
    notifyListeners();

    try {
      _motels = await apiService.fetchAllMotels();
      _filteredMotels = List.from(_motels);
      print("Motéis carregados: ${_motels.length}");
    } catch (e) {
      print("Erro ao carregar os motéis: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}