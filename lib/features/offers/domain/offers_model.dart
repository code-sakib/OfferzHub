class OffersModel {
  final String brand;
  final String img;
  final String? interested;
  final String? uploader;
  final String offer;
  final String? checkOffer;
  final String? location;
  final List? interestedUsers;
  OffersModel(
      {required this.brand,
      required this.img,
      required this.interested,
      required this.uploader,
      required this.offer,
      required this.checkOffer,
      required this.interestedUsers,
      this.location});

  factory OffersModel.fromApi(Map apiData) {
    final brand = apiData['brand'] as String;
    final img = apiData['img'] as String;
    const interested = '0';
    final uploader = apiData['uploader'];
    final offer = apiData['offer'] as String;
    final checkOffer = apiData['check'];
    final location = apiData['location'];
    final mUsers = apiData['interestedUsers'] ?? [];
    final rUsers = apiData['rInterestedUsers'] ?? [];

    return OffersModel(
        brand: brand,
        offer: offer,
        img: img,
        interested: interested,
        checkOffer: checkOffer,
        uploader: uploader,
        location: location,
        interestedUsers: List.from(mUsers) + List.from(rUsers));
  }
}

class UserModel {
  final String name;
  final String? dp;
  final String uID;
  final String? offerU;
  final String? rewardU;

  UserModel(
      {required this.name,
      required this.uID,
      this.dp,
      this.offerU,
      this.rewardU});

  factory UserModel.fromApi(Map apiData) {
    final name = apiData['name'] as String;
    final dp = apiData['img'];
    final offerU = apiData['offerU'] ?? '';
    final rewardU = apiData['rewardU'] ?? '';
    final uID = apiData['userId'];

    return UserModel(
        name: name, dp: dp, offerU: offerU, rewardU: rewardU, uID: uID);
  }
}
