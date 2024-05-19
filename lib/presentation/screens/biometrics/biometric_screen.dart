import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneus/presentation/providers/local_auth/local_auth_providers.dart';

class BiometricScreen extends ConsumerWidget {
  const BiometricScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final cancheckBiometricAsync = ref.watch(canCheckBiometricProvider);
    final localAuthState = ref.watch(localAuthProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Biometric screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.tonal(onPressed: (){
              ref.read(localAuthProvider.notifier).authenticateUser();
            }, child: const Text('Autenticar')),

            const SizedBox(height: 10,),

        cancheckBiometricAsync.when(
          data: (canCheck) => Text('Puede revisar biometricos: $canCheck'), 
          error: (error, stackTrace) => Text('$error'), 
          loading: () => const CircularProgressIndicator(strokeWidth: 2,)
          ),

          const SizedBox(height: 30,),
            const Text('Estado del biometrico', style: TextStyle(
              fontSize: 20
            ),),
            const SizedBox(height: 20,),
             Text('Estado: $localAuthState', style: const TextStyle(
              fontSize: 14
            ),),

          ],
        ),
      ),
    );
  }
}