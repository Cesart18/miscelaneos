

  import 'package:dio/dio.dart';
import 'package:miscelaneus/domain/domain.dart';
import 'package:miscelaneus/infrastructure/mappers/pokemon_mapper.dart';

class PokemonsDatasourceImpl implements PokemonsDatasource{

  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://pokeapi.co/api/v2'));

  @override
  Future<(Pokemon?, String)> getPokemon(String id) async {

    try {
      final resp = await dio.get('/pokemon/$id');
      final pokemon = PokemonMapper.pokeApiResponseToEntity(resp.data);

      return (pokemon, 'Data obtenida correctamente');
    } catch (e) {
      return ( null, 'No se puro obtener el pokemon' );
    }

  }

}