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

  Widget _buildFilterChip(String filter, String label) {
    final motelProvider = Provider.of<MotelProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: FilterChip(
        label: Text(
          label,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 14,
          ),
        ),
        selected: motelProvider.selectedFilters.contains(filter),
        onSelected: (_) => motelProvider.toggleFilter(filter),
        backgroundColor: Colors.transparent,
        selectedColor: Colors.white,
        checkmarkColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        showCheckmark: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final motelProvider = Provider.of<MotelProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.flash_on, size: 20),
                  SizedBox(width: 5),
                  Text('Ir Agora'),
                ],
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[700],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.calendar_today, size: 20),
                  SizedBox(width: 5),
                  Text('Ir Outro Dia'),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight / 1.5),
          child: Container(
            color: Colors.red,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<String>(
                  isExpanded: false,
                  value: 'rio de janeiro',
                  icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                  iconSize: 20,
                  elevation: 16,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  underline: Container(height: 2, color: Colors.transparent),
                  onChanged: (String? newValue) {},
                  items: <String>['rio de janeiro', 'são paulo', 'minas gerais']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: FilterChip(
                    label: Row(
                      children: [
                        Icon(Icons.filter_list,
                            size: 18,
                            color: Colors.grey[600]
                        ),
                        const SizedBox(width: 4),
                        Text('filtros',
                            style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                    selected: false,
                    onSelected: (_) {},
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
                const SizedBox(width: 8),
                _buildFilterChip('desconto', 'com desconto'),
                const SizedBox(width: 8),
                _buildFilterChip('disponiveis', 'disponíveis'),
                const SizedBox(width: 8),
                _buildFilterChip('hidro', 'hidro'),
                const SizedBox(width: 8),
                _buildFilterChip('piscina', 'piscina'),
              ],
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _errorMessage != null
                ? Center(child: Text(_errorMessage!))
                : ListView.builder(
              itemCount: motelProvider.motels.length,
              itemBuilder: (ctx, i) => MotelItem(motel: motelProvider.motels[i]),
            ),
          ),
        ],
      ),
    );
  }
}