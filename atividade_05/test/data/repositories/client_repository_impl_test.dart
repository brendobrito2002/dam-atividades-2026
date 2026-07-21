import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vendas_app/src/data/datasources/local/client/client_local_datasource.dart';
import 'package:vendas_app/src/data/repositories/client/client_repository_impl.dart';
import 'package:vendas_app/src/models/client_model.dart';

class MockClientLocalDatasource extends Mock implements ClientLocalDatasource {}
class FakeClientModel extends Fake implements ClientModel {}

void main() {
  late ClientRepositoryImpl repository;
  late MockClientLocalDatasource mockDatasource;

  setUpAll(() {
    registerFallbackValue(FakeClientModel());
  });

  setUp(() {
    mockDatasource = MockClientLocalDatasource();
    repository = ClientRepositoryImpl(mockDatasource);
  });

  group('ClientRepositoryImpl Tests', () {
    final tClient = ClientModel(name: 'Test', email: 'test@test.com', phone: '123');

    test('getAll should forward call to datasource', () async {
      when(() => mockDatasource.getAll()).thenAnswer((_) async => [tClient]);
      
      final result = await repository.getAll();
      
      expect(result, [tClient]);
      verify(() => mockDatasource.getAll()).called(1);
    });

    test('add should forward call to datasource', () async {
      when(() => mockDatasource.add(any())).thenAnswer((_) async {});
      
      await repository.add(tClient);
      
      verify(() => mockDatasource.add(tClient)).called(1);
    });

    test('update should forward call to datasource', () async {
      when(() => mockDatasource.update(any())).thenAnswer((_) async {});
      
      await repository.update(tClient);
      
      verify(() => mockDatasource.update(tClient)).called(1);
    });

    test('delete should forward call to datasource', () async {
      when(() => mockDatasource.delete(any())).thenAnswer((_) async {});
      
      await repository.delete('123');
      
      verify(() => mockDatasource.delete('123')).called(1);
    });
  });
}
