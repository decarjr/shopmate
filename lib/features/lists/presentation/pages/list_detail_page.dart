import 'package:flutter/material.dart';

class ListDetailPage extends StatelessWidget {
  const ListDetailPage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final items = [
      _ListItem(name: 'Arroz 5kg', qty: 1, unit: 'UN', price: 24.90, checked: false),
      _ListItem(name: 'Feijão 1kg', qty: 2, unit: 'UN', price: 8.50, checked: true),
      _ListItem(name: 'Leite Integral', qty: 3, unit: 'UN', price: 5.49, checked: false),
    ];

    final totalEstimate = items
        .where((item) => !item.checked)
        .fold<double>(0, (sum, item) => sum + (item.qty * item.price));

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: _ListSummaryCard(
              totalEstimate: totalEstimate,
              budget: 500,
              itemsTotal: items.length,
              itemsChecked: items.where((e) => e.checked).length,
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final item = items[index];
                return Dismissible(
                  key: ValueKey(item.name),
                  background: Container(
                    color: Colors.red.shade100,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: const Icon(Icons.delete_outline, color: Colors.red),
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (_) {},
                  child: ListTile(
                    leading: Checkbox(
                      value: item.checked,
                      onChanged: (_) {},
                    ),
                    title: Text(item.name),
                    subtitle: Text('${item.qty} ${item.unit} · R\$ ${item.price.toStringAsFixed(2)}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit_outlined),
                      onPressed: () {},
                    ),
                  ),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemCount: items.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Adicionar item'),
      ),
    );
  }
}

class _ListItem {
  _ListItem({
    required this.name,
    required this.qty,
    required this.unit,
    required this.price,
    required this.checked,
  });

  final String name;
  final double qty;
  final String unit;
  final double price;
  final bool checked;
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
            Text('Total estimado: R\$ ${totalEstimate.toStringAsFixed(2)}'),
            const SizedBox(height: 12),
            LinearProgressIndicator(value: progress.clamp(0.0, 1.0)),
          ],
        ),
      ),
    );
  }
}
