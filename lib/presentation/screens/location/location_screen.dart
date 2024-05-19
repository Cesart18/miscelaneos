import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneus/presentation/providers/providers.dart';

class LocationScreen extends ConsumerWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final userLocationAsync = ref.watch(userLocationProvider);
    final watchLocation$ = ref.watch(watchLocationProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubicacion'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ! current Location
            const Text('Ubicacion Actual'),
            userLocationAsync.when(
              data: (data) => Text('$data'), 
              error: (error, stackTrace) => Text('$error'), 
              loading: () => const CircularProgressIndicator(strokeWidth: 2,)
              ),
            const SizedBox(height: 30,),
            // ! current location
            const Text('Seguimiento de ubicacion'),

            watchLocation$.when(
              data: (data) => Text('$data'),
               error: (error, stackTrace) => Text('$error'),
                loading: () => const CircularProgressIndicator(strokeWidth: 2,)
                )
          ],
        ),
      ),
    );
  }
}