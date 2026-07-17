import 'package:flutter_test/flutter_test.dart';
import 'package:vendas_app/src/models/client_model.dart';

void main() {
  group('ClientModel Tests', () {
    test('Should create a ClientModel with a generated id when not provided', () {
      final client = ClientModel(
        name: 'John Doe',
        email: 'john@example.com',
        phone: '123456789',
      );

      expect(client.id, isNotEmpty);
      expect(client.name, 'John Doe');
      expect(client.email, 'john@example.com');
      expect(client.phone, '123456789');
    });

    test('Should create a ClientModel with the provided id', () {
      const customId = 'custom-id-123';
      final client = ClientModel(
        id: customId,
        name: 'John Doe',
        email: 'john@example.com',
        phone: '123456789',
      );

      expect(client.id, customId);
    });

    test('copyWith should return a new instance with updated values', () {
      final client = ClientModel(
        name: 'John Doe',
        email: 'john@example.com',
        phone: '123456789',
      );

      final updatedClient = client.copyWith(
        name: 'Jane Doe',
        phone: '987654321',
      );

      expect(updatedClient.id, client.id); // ID must remain the same
      expect(updatedClient.name, 'Jane Doe');
      expect(updatedClient.email, 'john@example.com'); // Unchanged
      expect(updatedClient.phone, '987654321');
    });
  });
}
