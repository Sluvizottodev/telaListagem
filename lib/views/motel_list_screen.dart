import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/motel_provider.dart';
import '../widgets/motel_item.dart';

class MotelListScreen extends StatefulWidget {
  @override
  _MotelListScreenState createState() => _MotelListScreenState();
}

class _MotelListScreenState extends State<MotelListScreen> {
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _loadMotels();
    });
  }

  Future<void> _loadMotels() async {
    try {
      await Provider.of<MotelProvider>(context, listen: false).fetchMotels();
      if (mounted) {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Ocorreu um erro ao carregar os dados.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final motelProvider = Provider.of<MotelProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Motéis Disponíveis'),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
          ? Center(child: Text(_errorMessage!))
          : ListView.builder(
        itemCount: motelProvider.motels.length,
        itemBuilder: (ctx, i) => MotelItem(motel: motelProvider.motels[i]),
      ),
    );
  }
}
