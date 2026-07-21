import 'package:vendas_app/src/models/client_model.dart';
import 'client_local_datasource.dart';

class ClientMemoryLocalDatasource implements ClientLocalDatasource {
  final List<ClientModel> _items = [];

  ClientMemoryLocalDatasource() {
    _items.addAll([
      ClientModel(
        name: 'João Silva',
        email: 'joao.silva@example.com',
        phone: '11999999999',
      ),
      ClientModel(
        name: 'Maria Souza',
        email: 'maria.souza@example.com',
        phone: '21988888888',
      ),
    ]);
  }

  @override
  Future<List<ClientModel>> getAll() async {
    return List.unmodifiable(_items);
  }

  @override
  Future<void> add(ClientModel client) async {
    _items.add(client);
  }

  @override
  Future<void> update(ClientModel client) async {
    final index = _items.indexWhere((c) => c.id == client.id);
    if (index != -1) {
      _items[index] = client;
    }
  }

  @override
  Future<void> delete(String id) async {
    _items.removeWhere((c) => c.id == id);
  }
}
