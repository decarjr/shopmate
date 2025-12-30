import 'package:flutter/material.dart';

import '../../../../core/constants/app_routes.dart';

class ListsHomePage extends StatelessWidget {
  const ListsHomePage({super.key});

  void _openList(BuildContext context, String title) {
    Navigator.of(context).pushNamed(
      AppRoutes.listDetail,
      arguments: {'title': title},
    );
  }

  @override
  Widget build(BuildContext context) {
    final sampleLists = [
      {'title': 'Compras da Semana', 'items': 12, 'checked': 5, 'total': 127.5},
      {'title': 'Churrasco', 'items': 8, 'checked': 2, 'total': 210.0},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Listas'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final list = sampleLists[index];
          final progress =
              list['items'] == 0 ? 0.0 : (list['checked'] as int) / (list['items'] as int);

          return Card(
            child: ListTile(
              title: Text(list['title'] as String),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  LinearProgressIndicator(value: progress),
                  const SizedBox(height: 8),
                  Text(
                    '${list['checked']}/${list['items']} itens · Estimativa: R\$ ${(list['total'] as double).toStringAsFixed(2)}',
                  ),
                ],
              ),
              onTap: () => _openList(context, list['title'] as String),
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemCount: sampleLists.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openList(context, 'Nova Lista'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
