import '../providers/motel_provider.dart';

class MotelController {
  final MotelProvider _provider;

  MotelController(this._provider);

  Future<void> loadMotels() async {
    await _provider.fetchMotels();
  }
}