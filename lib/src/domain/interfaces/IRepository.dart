abstract class IRepository<T> {
  Future<List<T>> getMixes();
  Future<T> getMix(int id);
  Future<T> createMix(T mix);
  Future<T> updateMix(T mix);
  Future<void> deleteMix(int id);
}
