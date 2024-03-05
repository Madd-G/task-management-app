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
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        image: DecorationImage(
          image: imageProvider,
          fit: fit,
          // colorFilter: ColorFilter.mode(AppColor.redColor, BlendMode.colorBurn),
        ),
      ),
    ),
    errorWidget: (context, url, error) => const ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(100.0)),
      child: Image(
        image: NetworkImage(
            'https://static.vecteezy.com/system/resources/thumbnails/002/387/693/small/user-profile-icon-free-vector.jpg'),
      ),
    ),
  );
}
