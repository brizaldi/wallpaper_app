import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../domain/photos/photo.dart';

class PhotoGridViewCard extends StatelessWidget {
  const PhotoGridViewCard({Key? key, required this.photo}) : super(key: key);

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: CachedNetworkImage(
        imageUrl: photo.photoSource.medium.value.fold(
          (_) => 'https://plchldr.co/i/150x300?text=No Image',
          (value) => value,
        ),
        fit: BoxFit.cover,
      ),
    );
  }
}
