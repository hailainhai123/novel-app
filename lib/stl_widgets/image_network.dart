import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer_widget/templates_shimmer_widget.dart';
import 'package:novel_app_client/constant/icons_path.dart';

class NetWorkImageApp extends StatelessWidget {
  final String urlImage;

  const NetWorkImageApp({super.key, required this.urlImage});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: urlImage,
      fit: BoxFit.cover,
      placeholder: (context, url) => Center(
        child: Image.asset(IconsPath.noImage),
      ),
      errorWidget: (context, url, error) => const SizedBox(),
    );
  }
}
