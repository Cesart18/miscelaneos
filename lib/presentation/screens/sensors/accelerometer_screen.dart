import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneus/presentation/providers/sensors/accelerometer_providers.dart';

class AccelerometerScreen extends ConsumerWidget {
  const AccelerometerScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final accelerometerGrativy$ = ref.watch(accelerometerGravityProvider);
    final accelerometerUser$ = ref.watch(accelerometerUserProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acelerometro'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Acelerometro con gravedad'),
            accelerometerGrativy$.when(
              data: (value) => Text(value.toString(),
              style: const TextStyle(fontSize: 30),),
               error: (error, stackTrace) => Text('$error'),
                loading: () => const CircularProgressIndicator(strokeWidth: 2,)),
            const Text('Acelerometro usuario'),
            accelerometerUser$.when(
              data: (value) => Text(value.toString(),
              style: const TextStyle(fontSize: 30),),
               error: (error, stackTrace) => Text('$error'),
                loading: () => const CircularProgressIndicator(strokeWidth: 2,))
          ],
        ),
      ),
    );
  }
}