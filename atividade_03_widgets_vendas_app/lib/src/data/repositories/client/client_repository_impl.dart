import 'package:vendas_app/src/models/client_model.dart';
import 'package:vendas_app/src/data/datasources/local/client/client_local_datasource.dart';
import 'client_repository.dart';

class ClientRepositoryImpl implements ClientRepository {
  final ClientLocalDatasource _localDatasource;

  ClientRepositoryImpl(this._localDatasource);

  @override
  Future<List<ClientModel>> getAll() {
    return _localDatasource.getAll();
  }

  @override
  Future<void> add(ClientModel client) {
    return _localDatasource.add(client);
  }

  @override
  Future<void> update(ClientModel client) {
    return _localDatasource.update(client);
  }

  @override
  Future<void> delete(String id) {
    return _localDatasource.delete(id);
  }
}
