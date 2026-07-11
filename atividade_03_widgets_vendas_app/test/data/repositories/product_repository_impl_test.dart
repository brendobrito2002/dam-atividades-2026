import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vendas_app/src/data/datasources/local/product/product_local_datasource.dart';
import 'package:vendas_app/src/data/repositories/product/product_repository_impl.dart';
import 'package:vendas_app/src/models/product_model.dart';

class MockProductLocalDatasource extends Mock implements ProductLocalDatasource {}
class FakeProductModel extends Fake implements ProductModel {}

void main() {
  late ProductRepositoryImpl repository;
  late MockProductLocalDatasource mockDatasource;

  setUpAll(() {
    registerFallbackValue(FakeProductModel());
  });

  setUp(() {
    mockDatasource = MockProductLocalDatasource();
    repository = ProductRepositoryImpl(mockDatasource);
  });

  group('ProductRepositoryImpl Tests', () {
    final tProduct = ProductModel(name: 'Test', price: 10.0, imageUrl: '');

    test('getAll should forward call to datasource', () async {
      when(() => mockDatasource.getAll()).thenAnswer((_) async => [tProduct]);
      
      final result = await repository.getAll();
      
      expect(result, [tProduct]);
      verify(() => mockDatasource.getAll()).called(1);
    });

    test('add should forward call to datasource', () async {
      when(() => mockDatasource.add(any())).thenAnswer((_) async {});
      
      await repository.add(tProduct);
      
      verify(() => mockDatasource.add(tProduct)).called(1);
    });

    test('update should forward call to datasource', () async {
      when(() => mockDatasource.update(any())).thenAnswer((_) async {});
      
      await repository.update(tProduct);
      
      verify(() => mockDatasource.update(tProduct)).called(1);
    });

    test('delete should forward call to datasource', () async {
      when(() => mockDatasource.delete(any())).thenAnswer((_) async {});
      
      await repository.delete('123');
      
      verify(() => mockDatasource.delete('123')).called(1);
    });
  });
}
