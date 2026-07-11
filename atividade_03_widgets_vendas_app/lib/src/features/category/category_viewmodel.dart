import 'package:flutter/material.dart';
import 'package:vendas_app/src/data/repositories/category/category_repository.dart';
import 'package:vendas_app/src/models/category_model.dart';

class CategoryViewModel extends ChangeNotifier {
  final CategoryRepository _repository;
  List<CategoryModel> _categories = [];
  bool _isLoading = false;

  CategoryViewModel(this._repository);

  List<CategoryModel> get categories => _categories;
  bool get isLoading => _isLoading;

  Future<void> loadCategories() async {
    _isLoading = true;
    notifyListeners();

    _categories = await _repository.getAll();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addCategory(String name) async {
    if (name.trim().isEmpty) return;
    final newCategory = CategoryModel(name: name.trim());
    await _repository.add(newCategory);
    await loadCategories();
  }

  Future<void> updateCategory(String id, String newName) async {
    if (newName.trim().isEmpty) return;
    final updatedCategory = CategoryModel(id: id, name: newName.trim());
    await _repository.update(updatedCategory);
    await loadCategories();
  }

  Future<void> deleteCategory(String id) async {
    await _repository.delete(id);
    await loadCategories();
  }
}
