// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:offerzhub/core/dataset.dart';
import 'package:offerzhub/features/offers/data/offers/get_offers_api.dart';
import 'package:offerzhub/features/offers/domain/offers_model.dart';
import 'package:offerzhub/features/offers/domain/provider/offers_provider.dart';
import 'package:offerzhub/utlis/current_carousel.dart';
import 'package:offerzhub/utlis/screen_sizes.dart';
import 'package:offerzhub/utlis/url_launcher_func.dart';
import 'package:provider/provider.dart';

class OffersPage extends StatefulWidget {
  const OffersPage({
    super.key,
  });

  @override
  State<OffersPage> createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Consumer<OffersProvider>(builder: (context, model, child) {
      if (model.currentState.runtimeType == DataSucceed) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(),
                // Flexible(child: SearchBar()),
              ],
            ),

            const Text(
              '  *6895 are finding OfferMates currently',
              style: TextStyle(
                  color: Color(0xFF7255AF), fontWeight: FontWeight.w600),
            ),

            //offers

            offersListViewBuilder(listOfOffers.length, listOfOffers),
            // FloatingActionButton(
            //   onPressed: () {
            //     showDialog(
            //       context: context,
            //       builder: (context) {
            //         return AlertDialog(
            //           contentPadding: const EdgeInsets.all(2),
            //           content: Padding(
            //             padding: const EdgeInsets.all(15.0),
            //             child: UploadOfferDialog(
            //               cS: changingState,
            //             ),
            //           ),
            //         );
            //       },
            //     );
            //   },
            //   child: Icon(Icons.add),
            // ),
          ],
        );
      } else if (model.currentState.runtimeType == DataLoading) {
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(
              Color(0xFF7255AF),
            ),
            strokeWidth: 5,
          ),
        );
      } else if (model.currentState.runtimeType == DataFailed) {
        return Center(
          child: Text(model.currentState.error ?? 'Error loading. Sorry😥'),
        );
      } else {
        return const Center(
          child: Text('Error loading. Sorry😥'),
        );
      }
    }));
  }
}

Widget offersListViewBuilder(int count, List<OffersModel> modelList) {
  return Flexible(
    child: ListView.builder(
      itemBuilder: (context, index) {
        final OffersModel offerModel = modelList[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
          child: Card(
            elevation: 10,
            shadowColor: const Color(0xFFA37AFC),
            child: index == 3
                ? const CurrentCarousel()
                : GestureDetector(
                    onTap: () => context
                        .goNamed('offerDetail', extra: {offerModel: index}),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: sizes(context).height / 4,
                          width: sizes(context).width / 4,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              'https://www.shareicon.net/data/512x512/2015/11/01/665107_people_512x512.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(offerModel.brand,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontWeight: FontWeight.bold)),
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network(
                                      offerModel.img,
                                      height: 50,
                                    )),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  offerModel.offer,
                                  softWrap: true,
                                ),
                                Card(
                                  elevation: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(offerModel.uploader ?? '',
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
                                Text(
                                    ' The offer uploader is ${offerModel.location ?? ''} miles away',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(
                                          fontWeight: FontWeight.w200,
                                        )),
                                Card(
                                  elevation: 5,
                                  child: Text(
                                      '${Random().nextInt(25)} people have shown interest',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(
                                            fontWeight: FontWeight.w200,
                                          )),
                                ),
                                Row(
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          launchUrlFunc(offerModel.checkOffer);
                                        },
                                        child: const Text('check offer')),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
          ),
        );
      },
      itemCount: count,
    ),
  );
}

// class UploadOfferDialog extends StatefulWidget {
//   final Function cS;
//   const UploadOfferDialog({
//     super.key,
//     required this.cS,
//   });

//   @override
//   State<UploadOfferDialog> createState() => _UploadOfferDialogState();
// }

// class _UploadOfferDialogState extends State<UploadOfferDialog> {
//   final listOfTFs = List.generate(3, (index) => TextEditingController());
//   final isTFsEmpty = List.generate(3, (index) => true);
//   final listOfTFsText = [
//     'Brand*',
//     'OfferStmt*',
//     'Copy the offer url from browser and paste here*',
//   ];

//   // static String selectedItem = 'travel'; // Initially selected item

//   // static List<String> items = [
//   //   'travel',
//   //   'games',
//   //   'food',
//   //   'clothes',
//   //   'giftCard',
//   //   'other'
//   // ];

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         SizedBox(
//           height: sizes(context).height / 3,
//           child: ListView.builder(
//             itemBuilder: (context, index) {
//               final currentTF = listOfTFs[index];
//               return Padding(
//                 padding: const EdgeInsets.all(6.0),
//                 child: TextFormField(
//                   controller: currentTF,
//                   onChanged: (value) => currentTF.text.isNotEmpty
//                       ? isTFsEmpty[index] = false
//                       : null,
//                   decoration: InputDecoration(
//                       border: const OutlineInputBorder(),
//                       hintText: (listOfTFsText[index]),
//                       hintMaxLines: 2),
//                 ),
//               );
//             },
//             itemCount: 3,
//           ),
//         ),
//         ElevatedButton(
//             onPressed: () async {
//               if (!isGuest) {
//                 !checkifTFEmpty()
//                     ? {
//                         await OffersApi().userUploadsOffer(OffersUpload(
//                             brand: listOfTFs[0].text,
//                             stmt: listOfTFs[1].text,
//                             offerLink: listOfTFs[2].text)),
//                         widget.cS()
//                       }
//                     : {
//                         showToast('Enter all/valid inputs..'),
//                       };
//               } else {
//                 AppSnackBar.showSnackBar('login to upload', colorGreen: false);
//               }
//             },
//             child: const Text('Upload'))
//       ],
//     );
//   }

//   bool checkifTFEmpty() => (isTFsEmpty.contains(true)) ? true : false;
// }
