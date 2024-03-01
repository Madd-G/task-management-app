import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget netImageCached(
  String url, {
  double width = 48,
  double height = 48,
  EdgeInsetsGeometry? margin,
  BoxFit? fit = BoxFit.cover,
}) {
  return CachedNetworkImage(
    imageUrl: url,
    imageBuilder: (context, imageProvider) => Container(
      height: height,
      width: width,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(54)),
        image: DecorationImage(
          image: imageProvider,
          fit: fit,
          // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn),
        ),
      ),
    ),
    errorWidget: (context, url, error) => const Image(
      image: AssetImage('assets/images/feature-1.png'),
    ),
  );
}
