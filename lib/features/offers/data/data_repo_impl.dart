

import 'package:offerzhub/core/dataset.dart';
import 'package:offerzhub/features/offers/data/offers/base_api.dart';
import 'package:offerzhub/features/offers/data/offers/get_offers_api.dart';
import 'package:offerzhub/features/offers/domain/domain_repo_impl.dart';

class DataRepoImpl extends BaseApi implements DomainApiRepoImpl {
  OffersApi offersApi = OffersApi();
  @override
  Future<DataState> getOffersFromApi() async {
    return await getStateOf(request: () async => offersApi.getOffers());
  }
}
