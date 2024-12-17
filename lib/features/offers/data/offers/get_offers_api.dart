import 'package:offerzhub/core/globals.dart';
import 'package:offerzhub/features/offers/domain/offers_model.dart';

final List<OffersModel> listOfOffers = [];
final List<OffersModel> listOfNearbyOffers = [];
final List<UserModel> listOfUsers = [];

class OffersApi {
  Future<List<OffersModel>> getOffers() async {
    listOfOffers.clear();
    listOfNearbyOffers.clear();
    await firestore
        .collection('offers')
        .doc('companyUploaded')
        .get()
        .then((value) {
      value.data()?.forEach((key, value) {
        final OffersModel offerModel = OffersModel.fromApi(value);
        listOfOffers.add(offerModel);
      });
    });

    await firestore
        .collection('offers')
        .doc('userUploaded')
        .get()
        .then((value) {
      value.data()?.forEach((key, value) {
        value.forEach((city) async {
          await firestore
              .collection('offers')
              .doc('userUploaded')
              .collection(city)
              .doc('offers')
              .get()
              .then((value) {
            value.data()?.forEach((key, value) {
              final OffersModel offerModel = OffersModel.fromApi(value);
              userAdd == city
                  ? listOfNearbyOffers.add(offerModel)
                  : listOfOffers.add(offerModel);
            });
          });
        });
      });
    });

    listOfOffers.insertAll(0, listOfNearbyOffers);
    await firestore.collection('users').doc('madeUsers').get().then((value) {
      value.data()?.forEach((key, u) {
        final user = UserModel.fromApi(u);
        listOfUsers.add(user);
      });
    });

    // //getting mUsers and saving to List
    // await firestore
    //     .collection('offers')
    //     .doc('companyUploaded')
    //     .get()
    //     .then((value) {
    //   value.data()?.forEach((key, u) {
    //     final user = UserModel.fromApi(u);
    //     listOfUsers.add(user);
    //   });
    // });

    return listOfOffers;
  }
}
