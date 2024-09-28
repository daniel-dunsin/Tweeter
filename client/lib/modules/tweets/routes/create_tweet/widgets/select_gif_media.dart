import 'package:client/modules/tweets/routes/create_tweet/bloc/local/create_tweet_bloc.dart';
import 'package:client/modules/tweets/routes/create_tweet/models/gif_model.dart';
import 'package:client/modules/tweets/services/tweet_service.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/utils/debouncer.dart';
import 'package:client/shared/utils/network.dart';
import 'package:client/shared/widgets/cached_image.dart';
import 'package:client/shared/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectGifMedia extends StatefulWidget {
  SelectGifMedia({super.key});

  @override
  State<SelectGifMedia> createState() => _SelectGifMediaState();
}

class _SelectGifMediaState extends State<SelectGifMedia> {
  List<GifModel> gifs = [];
  bool isLoading = false;

  final tweetService = TweetService();
  final debouncer = Debouncer();

  fetchGifs(String? search) async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await tweetService.getGifs(search);

      final List<dynamic> gifsMap = response.data["data"];

      setState(() {
        gifs = gifsMap.map((gif) => GifModel.fromMap(gif)).toList();
      });
    } catch (e) {
      handleError(e: e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchGifs(null);
  }

  void selectGif(String url) {
    context.read<CreateTweetBloc>().add(AddGif(url));
    context.pop();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;

    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: appColors.backgroundColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: ContainedTextField(
                    fullWidth: true,
                    height: 45,
                    centerLabel: true,
                    labelText: "Search for GIFs",
                    onChangeValue: (search) {
                      debouncer.run(() {
                        fetchGifs(search);
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: Text(
                    "Done",
                    style: TextStyle(
                      fontSize: 12.h,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? Shimmer.fromColors(
                    baseColor: Colors.grey.shade700,
                    highlightColor: Colors.grey.shade900,
                    enabled: true,
                    child: ColoredBox(
                      color: Colors.red,
                      child: Container(),
                    ))
                : GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                    itemBuilder: (builder, index) {
                      final image = gifs[index].image;
                      return InkWell(
                        onTap: () {
                          selectGif(image.url!);
                        },
                        child: CachedImage(
                          url: image.url!,
                          width: image.width.toDouble(),
                          height: image.height.toDouble(),
                        ),
                      );
                    },
                    itemCount: gifs.length,
                  ),
          )
        ],
      ),
    );
  }
}
