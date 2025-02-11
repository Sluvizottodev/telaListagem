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
        backgroundColor: Colors.red,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
          },
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // "Ir Agora"
              },
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
              onPressed: () {
                // "Ir Outro Dia"
              },
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
            onPressed: () {
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight / 1.5),
          child: Container(
            color: Colors.red,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, //Center the dropdown
              children: [
                DropdownButton<String>(
                  isExpanded: false,
                  value: 'rio de janeiro',
                  icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                  iconSize: 20,
                  elevation: 16,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  underline: Container(height: 2, color: Colors.transparent),
                  onChanged: (String? newValue) {
                  },
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
          // Filters
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FilterChip(
                    label: const Text('Filtros',
                        style: TextStyle(color: Colors.black)),
                    selected: false,
                    onSelected: (bool value) {},
                    backgroundColor: Colors.white.withOpacity(0.8), // Suavizar o fundo
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Colors.grey, width: 0.3), // Linha mais fina
                    ),
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text('Com desconto',
                        style: TextStyle(color: Colors.white)),
                    selected: false,
                    onSelected: (bool value) {},
                    backgroundColor: Colors.red.withOpacity(0.7), // Opacidade mais suave
                    checkmarkColor: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text('Disponíveis',
                        style: TextStyle(color: Colors.white)),
                    selected: false,
                    onSelected: (bool value) {},
                    backgroundColor: Colors.red.withOpacity(0.7),
                    checkmarkColor: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text('Hidro',
                        style: TextStyle(color: Colors.white)),
                    selected: false,
                    onSelected: (bool value) {},
                    backgroundColor: Colors.red.withOpacity(0.7),
                    checkmarkColor: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text('Piscina',
                        style: TextStyle(color: Colors.white)),
                    selected: false,
                    onSelected: (bool value) {},
                    backgroundColor: Colors.red.withOpacity(0.7),
                    checkmarkColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _errorMessage != null
                        ? Center(child: Text(_errorMessage!))
                        : ListView.builder(
                            itemCount: motelProvider.motels.length,
                            itemBuilder: (ctx, i) =>
                                MotelItem(motel: motelProvider.motels[i]),
                          ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
