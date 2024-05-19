import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:miscelaneus/presentation/providers/providers.dart';

class PokemonsScreen extends StatelessWidget {
  const PokemonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PokemonsView(),
    );
  }
}

class PokemonsView extends ConsumerStatefulWidget {
  const PokemonsView({super.key});

  @override
  PokemonsViewState createState() => PokemonsViewState();
}

class PokemonsViewState extends ConsumerState<PokemonsView> {

  final _scrollController = ScrollController();

  void infiniteScroll() {
    final currentPokemons = ref.read(pokemonIdsProvider);
    if( currentPokemons.length > 400 ){
      _scrollController.removeListener( infiniteScroll );
      return;
    }
    if( ( _scrollController.position.pixels + 200 ) > _scrollController.position.maxScrollExtent ){
      ref.read(pokemonIdsProvider.notifier).update((state) => [
        ...state, 
        ...List.generate(30, (index) => state.length + index + 1)
      ]);
    }

  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(infiniteScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
       controller: _scrollController,
      slivers: [
        SliverAppBar(
          title: const Text('Pokemons'),
          floating: true,
          backgroundColor: Colors.white.withOpacity(0.8),
        ),
        const _PokemonGrid()
      ],
    );
  }
}





class _PokemonGrid extends ConsumerWidget {
  const _PokemonGrid();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonIds = ref.watch(pokemonIdsProvider);
    return SliverGrid.builder(
      gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2),
        itemCount: pokemonIds.length,
       itemBuilder: (context, index) {
         return GestureDetector(
          onTap: (){
            context.push('/pokemons/${index + 1}');
          },
           child: Image.network(
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${ index + 1 }.png',
            fit: BoxFit.contain,
           ),
         );
       },);
  }
}