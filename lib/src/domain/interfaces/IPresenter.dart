abstract class IPresenter<TEntity, TOutPut> {
  List<TOutPut> present(List<TEntity> data);
}
