import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneus/presentation/providers/providers.dart';

class GyroscopeBallScreen extends ConsumerWidget {
  const GyroscopeBallScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final gyroscope$ = ref.watch(gyroscopeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giroscopio'),
      ),
      body: SizedBox.expand(
        child: gyroscope$.when(
          data: (value) => _MovingBall(x: value.x, y: value.y), 
          error: (error, stackTrace) => Text('$error'), 
          loading: () => const Center(child: CircularProgressIndicator(strokeWidth: 2,))),
      )
    );
  }
}


class _MovingBall extends StatelessWidget {
  final double x;
  final double y;
  const _MovingBall({
    required this.x,
    required this.y
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double screenWidth = size.width;
    double screenHeight = size.height;

    double currentYPos = ( y * 150 );
    double currentXPos = ( x * 150 );

    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 1000),
          top: (currentXPos - 25) + screenHeight /2,
          left: (currentYPos - 25) + screenWidth /2,
          curve: Curves.easeInOut,
          child: const Ball()),
        Text('''
    y:$y
    x:$x
        '''),
      ],  
    );
  }
}

class Ball extends StatelessWidget {
  const Ball({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle
      ),
    );
  }
}