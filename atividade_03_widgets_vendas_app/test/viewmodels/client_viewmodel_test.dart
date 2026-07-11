import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vendas_app/src/data/repositories/client/client_repository.dart';
import 'package:vendas_app/src/models/client_model.dart';
import 'package:vendas_app/src/features/client/client_viewmodel.dart';

class MockClientRepository extends Mock implements ClientRepository {}
class FakeClientModel extends Fake implements ClientModel {}

void main() {
  late ClientViewModel viewModel;
  late MockClientRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(FakeClientModel());
  });

  setUp(() {
    mockRepository = MockClientRepository();
    viewModel = ClientViewModel(mockRepository);
  });

  group('ClientViewModel Tests', () {
    final tClient = ClientModel(name: 'Test', email: 'test@test.com', phone: '123');
    final tClientsList = [tClient];

    test('loadClients should set isLoading and update clients list', () async {
      when(() => mockRepository.getAll()).thenAnswer((_) async => tClientsList);

      expect(viewModel.isLoading, false);
      
      final future = viewModel.loadClients();
      expect(viewModel.isLoading, true); // O notifyListeners é chamado antes do await

      await future;

      expect(viewModel.isLoading, false);
      expect(viewModel.clients, tClientsList);
      verify(() => mockRepository.getAll()).called(1);
    });

    test('addClient should call repository and reload list', () async {
      when(() => mockRepository.add(any())).thenAnswer((_) async {});
      when(() => mockRepository.getAll()).thenAnswer((_) async => tClientsList);

      registerFallbackValue(tClient); // Necessário para o any() com mocktail

      await viewModel.addClient(tClient);

      verify(() => mockRepository.add(any())).called(1);
      verify(() => mockRepository.getAll()).called(1);
      expect(viewModel.clients, tClientsList);
    });
  });
}
