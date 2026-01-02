class ShoppingList {
  const ShoppingList({
    required this.id,
    required this.title,
    required this.budget,
    required this.items,
  });

  final String id;
  final String title;
  final double budget;
  final List<ListItem> items;

  double get totalValue =>
      items.fold(0, (sum, item) => sum + (item.price * item.quantity));

  int get itemsChecked => items.where((item) => item.checked).length;

  ShoppingList copyWith({
    String? id,
    String? title,
    double? budget,
    List<ListItem>? items,
  }) {
    return ShoppingList(
      id: id ?? this.id,
      title: title ?? this.title,
      budget: budget ?? this.budget,
      items: items ?? this.items,
    );
  }
}

class ListItem {
  const ListItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unit,
    required this.price,
    this.checked = false,
  });

  final String id;
  final String name;
  final double quantity;
  final String unit;
  final double price;
  final bool checked;

  double get total => price * quantity;

  ListItem copyWith({
    String? id,
    String? name,
    double? quantity,
    String? unit,
    double? price,
    bool? checked,
  }) {
    return ListItem(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      price: price ?? this.price,
      checked: checked ?? this.checked,
    );
  }
}
