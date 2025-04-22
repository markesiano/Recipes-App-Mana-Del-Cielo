import '../interfaces/IRepository.dart';
import '../interfaces/IMapper.dart';

class CreateMixUseCase<TDTO> {
  final IRepository repository;
  final IMapper mapper;

  CreateMixUseCase(this.repository, this.mapper);

  Future<String> excecute(TDTO mixDTO) async {
    var mix = mapper.ToEntity(mixDTO);
    await repository.createMix(mix);
    if (mix.title == null) {
      throw Exception('Title is required');
    }
    return mix.title;
  }
}
