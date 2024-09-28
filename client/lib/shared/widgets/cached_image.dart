import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CachedImage extends StatelessWidget {
  final String url;
  final double? height;
  final double? width;

  const CachedImage({
    super.key,
    required this.url,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorWidget: (_, __, ___) {
        return const Center(
          child: Icon(
            Icons.error_outline,
            color: Colors.red,
          ),
        );
      },
      placeholderFadeInDuration: const Duration(milliseconds: 300),
      placeholder: (_, url) {
        return Shimmer.fromColors(
          child: ColoredBox(
            color: Colors.red,
            child: Container(),
          ),
          baseColor: Colors.grey.shade700,
          highlightColor: Colors.grey.shade900,
        );
      },
    );
  }
}
