import 'dart:convert';

class OffersModel {
  final String brand;
  final String img;
  final String? interested;
  final String? uploader;
  final String offer;
  final String? checkOffer;
  final String? location;
  OffersModel(
      {required this.brand,
      required this.img,
      required this.interested,
      required this.uploader,
      required this.offer,
      required this.checkOffer,
      this.location});

  factory OffersModel.fromApi(Map apiData) {
    final brand = apiData['brand'] as String;
    final img = apiData['img'] as String;
    const interested = '0';
    final uploader = apiData['uploader'];
    final offer = apiData['offer'] as String;
    final checkOffer = apiData['check'];
    final location = apiData['location'];
    return OffersModel(
        brand: brand,
        offer: offer,
        img: img,
        interested: interested,
        checkOffer: checkOffer,
        uploader: uploader,
        location: location);
  }

  OffersModel copyWith({
    String? brand,
    String? img,
    String? interested,
    String? uploader,
    String? offer,
    String? checkOffer,
  }) {
    return OffersModel(
      brand: brand ?? this.brand,
      img: img ?? this.img,
      interested: interested ?? this.interested,
      uploader: uploader ?? this.uploader,
      offer: offer ?? this.offer,
      checkOffer: checkOffer ?? this.checkOffer,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'brand': brand,
      'img': img,
      'interested': interested,
      'uploader': uploader,
      'offer': offer,
      'checkOffer': checkOffer,
    };
  }

  factory OffersModel.fromMap(Map<String, dynamic> map) {
    return OffersModel(
      brand: map['brand'] as String,
      img: map['img'] as String,
      interested: map['interested'] as String,
      uploader: map['uploader'] != null ? map['uploader'] as String : null,
      offer: map['offer'] as String,
      checkOffer: map['checkOffer'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OffersModel.fromJson(String source) =>
      OffersModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OffersModel(brand: $brand, img: $img, interested: $interested, uploader: $uploader, offer: $offer, checkOffer: $checkOffer)';
  }

  @override
  bool operator ==(covariant OffersModel other) {
    if (identical(this, other)) return true;

    return other.brand == brand &&
        other.img == img &&
        other.interested == interested &&
        other.uploader == uploader &&
        other.offer == offer &&
        other.checkOffer == checkOffer;
  }

  @override
  int get hashCode {
    return brand.hashCode ^
        img.hashCode ^
        interested.hashCode ^
        uploader.hashCode ^
        offer.hashCode ^
        checkOffer.hashCode;
  }
}

class UserModel {
  final String name;
  final String? dp;
  final String? offerU;
  final String? rewardU;

  UserModel({required this.name, this.dp, this.offerU, this.rewardU});

  factory UserModel.fromApi(Map apiData) {
    final name = apiData['name'] as String;
    final dp = apiData['img'];
    final offerU = apiData['offerU'];
    final rewardU = apiData['rewardU'];

    return UserModel(name: name, dp: dp, offerU: offerU, rewardU: rewardU);
  }
}
