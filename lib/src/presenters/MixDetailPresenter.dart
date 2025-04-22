import './viewmodels/MixDetailViewModel.dart';
import '../domain/entities/Mix.dart';
import '../domain/interfaces/IPresenter.dart';

class MixDetailPresenter extends IPresenter<Mix, MixDetailViewModel> {
  @override
  List<MixDetailViewModel> present(List<Mix> data) {
    return data
        .map((e) => MixDetailViewModel(
              id: e.id,
              title: e.title,
              description: e.description,
              ingredients: e.ingredients,
              mixer: e.mixer,
              minutes: e.minutes,
              notes: e.notes,
            ))
        .toList();
  }
}
