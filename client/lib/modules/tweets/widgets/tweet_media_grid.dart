import 'package:flutter/cupertino.dart';

class TweetMediaGrid extends StatelessWidget {
  final List<Widget> mediaList;

  const TweetMediaGrid({
    super.key,
    this.mediaList = const [],
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        child: Builder(
          builder: (context) {
            switch (mediaList.length) {
              case 1:
                return mediaList[0];
              case 2:
                return Placeholder();
              case 3:
                return Placeholder();
              case 4:
                return Placeholder();
              default:
                return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
