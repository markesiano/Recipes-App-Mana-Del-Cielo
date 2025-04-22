import 'package:recipes_app_mana_del_cielo/src/data/Repository.dart';
import 'package:recipes_app_mana_del_cielo/src/domain/usecases/CreateMixUseCase.dart';
import 'package:recipes_app_mana_del_cielo/src/infraestructure/datasources/sqlite.dart';
import 'package:recipes_app_mana_del_cielo/src/mappers/DTOs/MixRequestDTO.dart';
import 'package:recipes_app_mana_del_cielo/src/mappers/MixMapper.dart';

class CreateMixFactory {
  static CreateMixUseCase<MixRequestDTO> createUseCase() {
    return CreateMixUseCase<MixRequestDTO>(createRepository(), createMapper());
  }

  static Repository createRepository() {
    return Repository(createDataSource());
  }

  static createDataSource() {
    return SqliteDataSource.get();
  }

  static MixMapper createMapper() {
    return MixMapper();
  }
}
