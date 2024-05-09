import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:miscelaneus/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 10,
            title: const Text('Miscelaneos'),
            actions: [
        IconButton(onPressed: (){
          context.push('/permissions');
        }, icon: const Icon(Icons.settings))
      ],
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            sliver: MainMenu()),
        ],
      ),
    );
  }
}


