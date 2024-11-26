
import 'package:offerzhub/features/offers/domain/offers_model.dart';

abstract class DataState<T> {
  final List<OffersModel>? data;
  final String? error;

  const DataState({this.data, this.error});
}

class DataSucceed<List> extends DataState {
  const DataSucceed({super.data});
}

class DataFailed<T> extends DataState {
  DataFailed({super.error});
}

class DataLoading<T> extends DataState {
  DataLoading();
}
