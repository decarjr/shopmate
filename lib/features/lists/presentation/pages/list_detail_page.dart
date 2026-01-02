import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/list_models.dart';
import '../../state/lists_controller.dart';

class ListDetailPage extends StatelessWidget {
  const ListDetailPage({
    super.key,
    required this.listId,
  });

  final String listId;

  @override
  Widget build(BuildContext context) {
    return Consumer<ListsController>(
      builder: (context, controller, _) {
        final list = controller.getById(listId);

        if (list == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Lista não encontrada')),
            body: const Center(child: Text('Volte e crie uma nova lista.')),
          );
        }

        final uncheckedTotal =
            list.items.where((item) => !item.checked).fold<double>(0, (sum, item) => sum + item.total);

        return Scaffold(
          appBar: AppBar(
            title: Text(list.title),
            actions: [
              IconButton(
                onPressed: () => _editListTitle(context, list),
                icon: const Icon(Icons.edit_outlined),
              ),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: _ListSummaryCard(
                  totalEstimate: uncheckedTotal,
                  budget: list.budget,
                  itemsTotal: list.items.length,
                  itemsChecked: list.itemsChecked,
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) {
                    final item = list.items[index];
                    return Dismissible(
                      key: ValueKey(item.id),
                      background: Container(
                        color: Colors.red.shade100,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: const Icon(Icons.delete_outline, color: Colors.red),
                      ),
                      direction: DismissDirection.endToStart,
                      onDismissed: (_) => controller.removeItem(list.id, item.id),
                      child: ListTile(
                        leading: Checkbox(
                          value: item.checked,
                          onChanged: (value) =>
                              controller.toggleItem(list.id, item.id, value ?? false),
                        ),
                        title: Text(item.name),
                        subtitle: Text(
                          '${item.quantity} ${item.unit} · R\\$ ${item.price.toStringAsFixed(2)} (Total: R\\$ ${item.total.toStringAsFixed(2)})',
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit_outlined),
                          onPressed: () => _editItem(context, list.id, item),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemCount: list.items.length,
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _addItem(context, list.id),
            icon: const Icon(Icons.add),
            label: const Text('Adicionar item'),
          ),
        );
      },
    );
  }

  Future<void> _addItem(BuildContext context, String listId) async {
    final nameController = TextEditingController();
    final quantityController = TextEditingController(text: '1');
    final unitController = TextEditingController(text: 'UN');
    final priceController = TextEditingController(text: '0');

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Novo item',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Nome'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: quantityController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(labelText: 'Quantidade'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: unitController,
                  decoration: const InputDecoration(labelText: 'Unidade (ex: UN, kg, L)'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: priceController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(labelText: 'Preço unitário (R\\$)'),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.check),
                    label: const Text('Adicionar'),
                    onPressed: () {
                      final name = nameController.text.trim().isEmpty
                          ? 'Item sem nome'
                          : nameController.text.trim();
                      final quantity =
                          double.tryParse(quantityController.text.replaceAll(',', '.')) ?? 1;
                      final price = double.tryParse(priceController.text.replaceAll(',', '.')) ?? 0;
                      final unit = unitController.text.trim().isEmpty ? 'UN' : unitController.text.trim();

                      context.read<ListsController>().addItem(
                            listId,
                            name: name,
                            quantity: quantity,
                            unit: unit,
                            price: price,
                          );
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _editItem(BuildContext context, String listId, ListItem item) async {
    final nameController = TextEditingController(text: item.name);
    final quantityController = TextEditingController(text: item.quantity.toString());
    final unitController = TextEditingController(text: item.unit);
    final priceController = TextEditingController(text: item.price.toStringAsFixed(2));

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Editar item',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Nome'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: quantityController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(labelText: 'Quantidade'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: unitController,
                  decoration: const InputDecoration(labelText: 'Unidade'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: priceController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(labelText: 'Preço unitário'),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.save_outlined),
                    label: const Text('Salvar'),
                    onPressed: () {
                      final name = nameController.text.trim().isEmpty
                          ? 'Item sem nome'
                          : nameController.text.trim();
                      final quantity =
                          double.tryParse(quantityController.text.replaceAll(',', '.')) ?? 1;
                      final price = double.tryParse(priceController.text.replaceAll(',', '.')) ?? 0;
                      final unit = unitController.text.trim().isEmpty ? 'UN' : unitController.text.trim();

                      context.read<ListsController>().updateItem(
                            listId,
                            item.id,
                            name: name,
                            quantity: quantity,
                            unit: unit,
                            price: price,
                          );
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _editListTitle(BuildContext context, ShoppingList list) async {
    final titleController = TextEditingController(text: list.title);

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Renomear lista'),
          content: TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Título'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                final newTitle = titleController.text.trim().isEmpty
                    ? list.title
                    : titleController.text.trim();
                context.read<ListsController>().renameList(list.id, newTitle);
                Navigator.of(context).pop();
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }
}

class _ListSummaryCard extends StatelessWidget {
  const _ListSummaryCard({
    required this.totalEstimate,
    required this.budget,
    required this.itemsTotal,
    required this.itemsChecked,
  });

  final double totalEstimate;
  final double budget;
  final int itemsTotal;
  final int itemsChecked;

  @override
  Widget build(BuildContext context) {
    final progress = budget == 0 ? 0.0 : totalEstimate / budget;
    final budgetText = budget == 0
        ? 'Sem orçamento definido'
        : 'Orçamento: R\\$ ${budget.toStringAsFixed(2)}';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Resumo',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text('Itens: $itemsChecked/$itemsTotal'),
            const SizedBox(height: 4),
            Text('Total não comprado: R\\$ ${totalEstimate.toStringAsFixed(2)}'),
            const SizedBox(height: 4),
            Text(budgetText),
            const SizedBox(height: 12),
            LinearProgressIndicator(value: progress.clamp(0.0, 1.0)),
          ],
        ),
      ),
    );
  }
}
