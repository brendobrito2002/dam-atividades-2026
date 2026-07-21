import 'package:flutter/material.dart';
import 'package:vendas_app/src/data/repositories/client/client_repository.dart';
import 'package:vendas_app/src/models/client_model.dart';

class ClientViewModel extends ChangeNotifier {
  final ClientRepository _repository;

  List<ClientModel> _clients = [];
  bool _isLoading = false;

  ClientViewModel(this._repository);

  List<ClientModel> get clients => _clients;
  bool get isLoading => _isLoading;

  Future<void> loadClients() async {
    _isLoading = true;
    notifyListeners();

    _clients = await _repository.getAll();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addClient(ClientModel client) async {
    await _repository.add(client);
    await loadClients(); // Recarrega a lista
  }
  
  Future<void> updateClient(ClientModel client) async {
    await _repository.update(client);
    await loadClients();
  }
  
  Future<void> deleteClient(String id) async {
    await _repository.delete(id);
    await loadClients();
  }
}
