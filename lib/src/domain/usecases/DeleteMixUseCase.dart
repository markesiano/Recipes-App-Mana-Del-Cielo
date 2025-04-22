import '../interfaces/IRepository.dart';

class DeleteMixesUseCase<TEntity, TOutPut> {
  final IRepository<TEntity> repository;

  DeleteMixesUseCase(this.repository);

  Future<void> excecute(int id) async {
    await repository.deleteMix(id);
  }
}
