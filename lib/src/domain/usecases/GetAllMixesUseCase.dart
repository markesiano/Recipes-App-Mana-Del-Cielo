import '../interfaces/IRepository.dart';
import '../interfaces/IPresenter.dart';

class GetAllMixesUseCase<TEntity, TOutPut> {
  final IRepository<TEntity> repository;
  final IPresenter<TEntity, TOutPut> presenter;

  GetAllMixesUseCase(this.repository, this.presenter);

  Future<List<TOutPut>> excecute() async {
    var mixes = await repository.getMixes();
    return presenter.present(mixes);
  }
}
