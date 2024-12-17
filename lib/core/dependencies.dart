import 'package:offerzhub/core/globals.dart';
import 'package:offerzhub/features/offers/data/data_repo_impl.dart';
import 'package:offerzhub/features/offers/domain/domain_repo_impl.dart';
import 'package:offerzhub/utlis/user_location.dart';

Future<void> initializeDependencies() async {
  //getit
  getIt.registerSingleton<DomainApiRepoImpl>(DataRepoImpl());

  await UserLocation.determinePosition();

  // gloabal_prefs = await SharedPreferences.getInstance();
}
