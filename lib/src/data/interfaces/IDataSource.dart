// Interface of datasource class

abstract class IDataSource<T> {
  Future<List<T>> getAll();
  Future<T> getOne(int id);
  Future<T> create(T mix);
  Future<T> update(T mix);
  Future<void> delete(int id);
}
