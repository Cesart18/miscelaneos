
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneus/domain/domain.dart';
import 'package:miscelaneus/infrastructure/infrasctructure.dart';


final pokemonRepositoryProvider = Provider<PokemonsRepository>((ref) => PokemonsRepositoryImpl());

final pokemonProvider = FutureProvider.family<Pokemon, String>((ref, pokemonId) async {
  final pokemonRepository = ref.watch( pokemonRepositoryProvider );

  final ( pokemon, error ) = await pokemonRepository.getPokemon(pokemonId);

  if( pokemon != null  ) return pokemon;
  
  throw error;

  });