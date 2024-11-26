import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  static final TextEditingController searchBarTextEditingController =
      TextEditingController();

  static final _searchBarFocusNode = FocusNode();
  static ValueNotifier<bool> isTFActive = ValueNotifier(false);
  @override
  void initState() {
    super.initState();
    _searchBarFocusNode.addListener(onFocusChange);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              // final List<String> listSearchRewards = [];
              // for (var reward in listOfRewards) {
              //   final brandname = RewardModel.fromApi(reward).brand;
              //   listSearchRewards.add(brandname);
              // }

              // CustomSearchDelegate(data: listSearchRewards);
            },
            child: TextFormField(
              controller: searchBarTextEditingController,
              focusNode: _searchBarFocusNode,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(5),
                  prefixIcon: const Icon(Icons.search_rounded),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: isTFActive,
            builder: (context, value, child) {
              return !value
                  ? Positioned(
                      top: 15,
                      left: 40,
                      child: Row(
                        children: [
                          const Text('search for '),
                          AnimatedTextKit(totalRepeatCount: 1, animatedTexts: [
                            TyperAnimatedText('Nike'),
                            TyperAnimatedText('Skull Candy'),
                            TyperAnimatedText('RedBus'),
                            TyperAnimatedText(
                                'offers to find your offermate for..'),
                          ])
                        ],
                      ))
                  : Container();
            },
          )
        ],
      ),
    );
  }

  void onFocusChange() {
    if (_searchBarFocusNode.hasFocus ||
        searchBarTextEditingController.text.isNotEmpty) {
      isTFActive.value = true;
    } else {
      isTFActive.value = false;
    }
  }
}
