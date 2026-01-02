import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_routes.dart';
import '../../data/list_models.dart';
import '../../state/lists_controller.dart';

class ListsHomePage extends StatelessWidget {
  const ListsHomePage({super.key});

  void _openList(BuildContext context, ShoppingList list) {
    Navigator.of(context).pushNamed(
      AppRoutes.listDetail,
      arguments: {'id': list.id},
    );
  }

  Future<void> _createList(BuildContext context) async {
    final titleController = TextEditingController();
    final budgetController = TextEditingController(text: '0');

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nova lista',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Título',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: budgetController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Orçamento (R\$ - opcional)',
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.check),
                    label: const Text('Criar'),
                    onPressed: () {
                      final title = titleController.text.trim().isEmpty
                          ? 'Minha Lista'
                          : titleController.text.trim();
                      final budget = double.tryParse(budgetController.text.replaceAll(',', '.')) ?? 0;
                      context.read<ListsController>().addList(title, budget: budget);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Listas'),
      ),
      body: Consumer<ListsController>(
        builder: (context, controller, _) {
          final lists = controller.lists;
          if (lists.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.list_alt_outlined, size: 48, color: Colors.grey),
                  const SizedBox(height: 8),
                  Text(
                    'Crie sua primeira lista',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () => _createList(context),
                    icon: const Icon(Icons.add),
                    label: const Text('Nova lista'),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final list = lists[index];
              final progress =
                  list.items.isEmpty ? 0.0 : list.itemsChecked / list.items.length;
              final budgetText = list.budget <= 0 ? 'Sem orçamento' : 'Orçamento: R\$ ${list.budget.toStringAsFixed(2)}';

              return Card(
                child: ListTile(
                  title: Text(list.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      LinearProgressIndicator(value: progress),
                      const SizedBox(height: 8),
                      Text(
                        '${list.itemsChecked}/${list.items.length} itens · Estimativa: R\$ ${list.totalValue.toStringAsFixed(2)}',
                      ),
                      Text(budgetText),
                    ],
                  ),
                  onTap: () => _openList(context, list),
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemCount: lists.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createList(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
