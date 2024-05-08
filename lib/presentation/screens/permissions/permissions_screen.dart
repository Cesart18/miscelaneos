import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permissions'),
      ),
      body: const _PermissionsVeiw(),
    );
  }
}


class _PermissionsVeiw extends ConsumerWidget {
  const _PermissionsVeiw();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        CheckboxListTile(
          title: const Text('Camara'),
          subtitle: const Text('Estado actual'),
          value: true, onChanged: (value){
            
        }),

      ],
    );
  }
}