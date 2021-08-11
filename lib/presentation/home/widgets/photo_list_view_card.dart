import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../domain/photos/photo.dart';
import '../../../extra/routes/router.gr.dart';

class PhotoListViewCard extends StatelessWidget {
  const PhotoListViewCard({Key? key, required this.photo}) : super(key: key);

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.push(DetailsRoute(
        photo: photo,
      )),
      child: Hero(
        tag: photo.photoId.value.fold(
          (_) => 'tag',
          (value) => value,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            height: 100,
            imageUrl: photo.photoSource.medium.value.fold(
              (_) => 'https://plchldr.co/i/150x300?text=No Image',
              (value) => value,
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
