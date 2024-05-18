import 'package:miscelaneus/domain/domain.dart';
import 'package:miscelaneus/infrastructure/infrasctructure.dart';

class PokemonMapper {
  static Pokemon pokeApiResponseToEntity(Map<String, dynamic> json) {
    final poke = PokeApiPokemonResponse.fromJson(json);

    return Pokemon(
        id: poke.id, name: poke.name, spriteFront: poke.sprites.frontDefault);
  }
}
