import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vendas_app/src/data/datasources/local/order/order_local_datasource.dart';
import 'package:vendas_app/src/data/repositories/order/order_repository_impl.dart';
import 'package:vendas_app/src/models/client_model.dart';
import 'package:vendas_app/src/models/order_model.dart';

class MockOrderLocalDatasource extends Mock implements OrderLocalDatasource {}
class FakeOrderModel extends Fake implements OrderModel {}

void main() {
  late OrderRepositoryImpl repository;
  late MockOrderLocalDatasource mockDatasource;

  setUpAll(() {
    registerFallbackValue(FakeOrderModel());
  });

  setUp(() {
    mockDatasource = MockOrderLocalDatasource();
    repository = OrderRepositoryImpl(mockDatasource);
  });

  group('OrderRepositoryImpl Tests', () {
    final tClient = ClientModel(name: 'Client', email: '', phone: '');
    final tOrder = OrderModel(client: tClient, items: []);

    test('getAll should forward call to datasource', () async {
      when(() => mockDatasource.getAll()).thenAnswer((_) async => [tOrder]);
      
      final result = await repository.getAll();
      
      expect(result, [tOrder]);
      verify(() => mockDatasource.getAll()).called(1);
    });

    test('add should forward call to datasource', () async {
      when(() => mockDatasource.add(any())).thenAnswer((_) async {});
      
      await repository.add(tOrder);
      
      verify(() => mockDatasource.add(tOrder)).called(1);
    });

    test('update should forward call to datasource', () async {
      when(() => mockDatasource.update(any())).thenAnswer((_) async {});
      
      await repository.update(tOrder);
      
      verify(() => mockDatasource.update(tOrder)).called(1);
    });

    test('delete should forward call to datasource', () async {
      when(() => mockDatasource.delete(any())).thenAnswer((_) async {});
      
      await repository.delete('123');
      
      verify(() => mockDatasource.delete('123')).called(1);
    });
  });
}
