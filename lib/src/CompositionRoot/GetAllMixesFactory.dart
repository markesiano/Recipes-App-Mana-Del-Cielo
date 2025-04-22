import 'package:recipes_app_mana_del_cielo/src/data/Repository.dart';
import 'package:recipes_app_mana_del_cielo/src/domain/entities/Mix.dart';
import 'package:recipes_app_mana_del_cielo/src/domain/usecases/GetAllMixesUseCase.dart';
import 'package:recipes_app_mana_del_cielo/src/infraestructure/datasources/sqlite.dart';
import 'package:recipes_app_mana_del_cielo/src/presenters/MixPresenters.dart';
import 'package:recipes_app_mana_del_cielo/src/presenters/viewmodels/MixViewModel.dart';

class GetAllMixesFactory {
  static GetAllMixesUseCase<Mix, MixViewModel> createUseCase() {
    return GetAllMixesUseCase<Mix, MixViewModel>(
        createRepository(), MixPresenter());
  }

  static Repository createRepository() {
    return Repository(createDataSource());
  }

  static MixPresenter createPresenter() {
    return MixPresenter();
  }

  static createDataSource() {
    return SqliteDataSource.get();
  }
}
