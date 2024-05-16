import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneus/presentation/providers/permissions/permissions_provider.dart';

class AskLocationScreen extends ConsumerWidget {
  const AskLocationScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permiso requerido'),
      ),
      body: Center(
        child: FilledButton(onPressed: (){
          ref.read(permissionsProvider.notifier).requestLocationsAccess();
        }, child: const Text('Localizacion necesaria')),
      ),
    );
  }
}