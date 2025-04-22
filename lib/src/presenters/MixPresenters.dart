import './viewmodels/MixViewModel.dart';
import '../domain/entities/Mix.dart';
import '../domain/interfaces/IPresenter.dart';

class MixPresenter extends IPresenter<Mix, MixViewModel> {
  @override
  List<MixViewModel> present(List<Mix> data) {
    return data
        .map((e) => MixViewModel(
              id: e.id,
              title: e.title,
              description: e.description,
              minutes: e.minutes,
            ))
        .toList();
  }
}
