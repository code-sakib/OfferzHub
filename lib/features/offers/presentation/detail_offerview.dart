// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:offerzhub/features/offers/data/offers/get_offers_api.dart';
import 'package:offerzhub/features/offers/domain/offers_model.dart';
import 'package:offerzhub/utlis/random_select.dart';
import 'package:offerzhub/utlis/url_launcher_func.dart';

class DetailedOfferView extends StatelessWidget {
  final OffersModel offersModel;
  final int i;
  const DetailedOfferView({
    super.key,
    required this.offersModel,
    required this.i,
  });

  @override
  Widget build(BuildContext context) {
    listOfUsers.shuffle();
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 20,
              stretch: true,
              floating: true,
              expandedHeight: 200,
              forceMaterialTransparency: true,
              leading: IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded)),
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  'https://www.shareicon.net/data/512x512/2015/11/01/665107_people_512x512.png',
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate((context, i) {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(offersModel.brand,
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(fontWeight: FontWeight.bold)),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              offersModel.img,
                              height: 60,
                            )),
                      ],
                    ),
                    Text(offersModel.offer,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.w500)),
                    Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(offersModel.uploader ?? '',
                                softWrap: true,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(
                                      fontWeight: FontWeight.w200,
                                    )),
                            const Icon(
                              Icons.verified_rounded,
                              color: Colors.blue,
                              size: 15,
                            )
                          ],
                        ),
                      ),
                    ),
                    Text(' ${offersModel.location}'),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ElevatedButton(
                          onPressed: () {
                            launchUrlFunc(offersModel.checkOffer);
                          },
                          child: const Text('Check offer')),
                    ),
                    const Divider(indent: 20, endIndent: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          Icons.diversity_3_rounded,
                          size: 20,
                        ),
                        Text('Interested Offermates: ${listOfUsers.length}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              );
            }, childCount: 1)),
            SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              final UserModel user =
                  UserModel.fromApi(offersModel.interestedUsers?[index]);
              return GestureDetector(
                onTap: () => context.pushNamed('chat', extra: user),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                          radius: 25,
                          backgroundImage: user.dp != null
                              ? NetworkImage(
                                  user.dp!,
                                )
                              : null,
                          child: user.dp == null
                              ? Text(user.name[0].toUpperCase())
                              : null),
                      title: Text(user.name),
                      subtitle: Text(randomSubtitle()),
                    ),
                  ),
                ),
              );
            }, childCount: offersModel.interestedUsers?.length ?? 0)),
          ],
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Border radius of 20
              ),
              backgroundColor: const Color.fromARGB(255, 103, 58, 183)),
          child: const Text("u interested?"),
        ),
      ),
    ));
  }
}
