import 'package:flutter/cupertino.dart';

class TweetMediaGrid extends StatelessWidget {
  final bool isQuote;
  final List<Widget> mediaList;

  const TweetMediaGrid({
    super.key,
    this.mediaList = const [],
    this.isQuote = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: isQuote ? BorderRadius.circular(0) : BorderRadius.circular(20),
      child: Container(
        height: 300,
        child: Builder(
          builder: (context) {
            switch (mediaList.length) {
              case 1:
                return mediaList[0];
              case 2:
                return Row(
                  children: [
                    Expanded(child: mediaList[0]),
                    Expanded(child: mediaList[1]),
                  ],
                );
              case 3:
                return Row(
                  children: [
                    Expanded(child: mediaList[0]),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(child: mediaList[1]),
                          Expanded(child: mediaList[2]),
                        ],
                      ),
                    )
                  ],
                );
              case 4:
                return Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(child: mediaList[0]),
                          Expanded(child: mediaList[1]),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(child: mediaList[2]),
                          Expanded(child: mediaList[3])
                        ],
                      ),
                    ),
                  ],
                );
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
