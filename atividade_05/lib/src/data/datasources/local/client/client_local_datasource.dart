import 'package:vendas_app/src/models/client_model.dart';

abstract class ClientLocalDatasource {
  Future<List<ClientModel>> getAll();
  Future<void> add(ClientModel client);
  Future<void> update(ClientModel client);
  Future<void> delete(String id);
}
