import 'package:flutter/material.dart';
import 'package:offerzhub/core/dataset.dart';
import 'package:offerzhub/features/offers/domain/domain_repo_impl.dart';

class OffersProvider extends ChangeNotifier {
  OffersProvider(
    this.domainApiRepoImpl,
  );
  final DomainApiRepoImpl domainApiRepoImpl;

  DataState currentState = DataLoading();

  // Simulate an async task
  Future<void> performTask() async {
    final DataState state = await domainApiRepoImpl.getOffersFromApi();

    if (state.runtimeType == DataSucceed) {
      currentState = DataSucceed(data: state.data);
    } else {
      currentState = DataFailed(error: state.error.toString());
    }
    notifyListeners();
  }
}
