import 'dart:math';

import 'package:flutter/foundation.dart';

import '../data/list_models.dart';

class ListsController extends ChangeNotifier {
  ListsController({List<ShoppingList>? initialLists})
      : _lists = initialLists ?? [];

  factory ListsController.demo() {
    return ListsController(
      initialLists: [
        ShoppingList(
          id: 'lista-1',
          title: 'Compras da semana',
          budget: 300,
          items: [
            ListItem(
              id: 'item-1',
              name: 'Arroz 5kg',
              quantity: 1,
              unit: 'UN',
              price: 24.90,
            ),
            ListItem(
              id: 'item-2',
              name: 'Feijão 1kg',
              quantity: 2,
              unit: 'UN',
              price: 8.50,
              checked: true,
            ),
            ListItem(
              id: 'item-3',
              name: 'Leite integral',
              quantity: 3,
              unit: 'UN',
              price: 5.49,
            ),
          ],
        ),
        ShoppingList(
          id: 'lista-2',
          title: 'Churrasco',
          budget: 500,
          items: [
            ListItem(
              id: 'item-4',
              name: 'Carvão 5kg',
              quantity: 2,
              unit: 'UN',
              price: 22.50,
            ),
            ListItem(
              id: 'item-5',
              name: 'Picanha',
              quantity: 2,
              unit: 'kg',
              price: 79.90,
            ),
          ],
        ),
      ],
    );
  }

  final List<ShoppingList> _lists;

  List<ShoppingList> get lists => List.unmodifiable(_lists);

  ShoppingList? getById(String id) {
    try {
      return _lists.firstWhere((list) => list.id == id);
    } catch (_) {
      return null;
    }
  }

  void addList(String title, {double budget = 0}) {
    final list = ShoppingList(
      id: _generateId(prefix: 'lista'),
      title: title,
      budget: budget,
      items: [],
    );
    _lists.add(list);
    notifyListeners();
  }

  void renameList(String id, String title) {
    final index = _lists.indexWhere((list) => list.id == id);
    if (index == -1) return;
    _lists[index] = _lists[index].copyWith(title: title);
    notifyListeners();
  }

  void addItem(
    String listId, {
    required String name,
    required double quantity,
    required String unit,
    required double price,
  }) {
    final index = _lists.indexWhere((list) => list.id == listId);
    if (index == -1) return;

    final list = _lists[index];
    final item = ListItem(
      id: _generateId(prefix: 'item'),
      name: name,
      quantity: quantity,
      unit: unit,
      price: price,
    );

    _lists[index] = list.copyWith(items: [...list.items, item]);
    notifyListeners();
  }

  void toggleItem(String listId, String itemId, bool checked) {
    final index = _lists.indexWhere((list) => list.id == listId);
    if (index == -1) return;

    final list = _lists[index];
    final updatedItems = list.items
        .map(
          (item) => item.id == itemId ? item.copyWith(checked: checked) : item,
        )
        .toList();

    _lists[index] = list.copyWith(items: updatedItems);
    notifyListeners();
  }

  void updateItem(
    String listId,
    String itemId, {
    String? name,
    double? quantity,
    String? unit,
    double? price,
  }) {
    final index = _lists.indexWhere((list) => list.id == listId);
    if (index == -1) return;

    final list = _lists[index];
    final updatedItems = list.items
        .map(
          (item) => item.id == itemId
              ? item.copyWith(
                  name: name ?? item.name,
                  quantity: quantity ?? item.quantity,
                  unit: unit ?? item.unit,
                  price: price ?? item.price,
                )
              : item,
        )
        .toList();

    _lists[index] = list.copyWith(items: updatedItems);
    notifyListeners();
  }

  void removeItem(String listId, String itemId) {
    final index = _lists.indexWhere((list) => list.id == listId);
    if (index == -1) return;

    final list = _lists[index];
    final updatedItems = list.items.where((item) => item.id != itemId).toList();
    _lists[index] = list.copyWith(items: updatedItems);
    notifyListeners();
  }

  String _generateId({required String prefix}) {
    final random = Random();
    final randomPart = random.nextInt(999999);
    return '$prefix-$randomPart';
  }
}
