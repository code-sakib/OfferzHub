import 'package:offerzhub/core/dataset.dart';

abstract class DomainApiRepoImpl {
  Future<DataState> getOffersFromApi();
}
         