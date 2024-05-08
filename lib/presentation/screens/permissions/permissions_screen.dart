import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneus/presentation/providers/permissions/permissions_provider.dart';

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
    final permissions = ref.watch(permissionsProvider);
    return ListView(
      children: [
        CheckboxListTile(
          title: const Text('Camara'),
          subtitle:  Text('${permissions.camera}'),
          value: permissions.cameraGranted, onChanged: (_) => ref.read(permissionsProvider.notifier).requestCameraAccess()),
        CheckboxListTile(
          title: const Text('Galeria de fotos'),
          subtitle:  Text('${permissions.photoLibrary}'),
          value: permissions.photoLibraryGranted, onChanged: (_) => ref.read(permissionsProvider.notifier).requestPhotoLibraryAccess()),
        CheckboxListTile(
          title: const Text('Sensores'),
          subtitle:  Text('${permissions.sensors}'),
          value: permissions.sensorsGranted, onChanged: (_) => ref.read(permissionsProvider.notifier).requestSensorsAccess()),
        CheckboxListTile(
          title: const Text('Ubicacion'),
          subtitle:  Text('${permissions.locations}'),
          value: permissions.locationsGranted, onChanged: (_) => ref.read(permissionsProvider.notifier).requestLocationsAccess()),

      ],
    );
  }
}