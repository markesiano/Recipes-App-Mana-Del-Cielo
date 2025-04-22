import 'package:recipes_app_mana_del_cielo/src/domain/interfaces/IRepository.dart';
import './interfaces/IDataSource.dart';
import 'package:recipes_app_mana_del_cielo/src/domain/entities/Mix.dart';

class Repository extends IRepository<Mix> {
  final IDataSource<Mix> context;

  Repository(this.context);

  @override
  Future<Mix> createMix(Mix mix) async {
    return context.create(mix);
  }

  @override
  Future<void> deleteMix(int id) async {
    return context.delete(id);
  }

  @override
  Future<Mix> getMix(int id) async {
    return context.getOne(id);
  }

  @override
  Future<List<Mix>> getMixes() async {
    return context.getAll();
  }

  @override
  Future<Mix> updateMix(Mix mix) async {
    return context.update(mix);
  }
}
