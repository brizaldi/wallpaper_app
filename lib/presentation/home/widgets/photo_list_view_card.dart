import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../domain/photos/photo.dart';

class PhotoListViewCard extends StatelessWidget {
  const PhotoListViewCard({Key? key, required this.photo}) : super(key: key);

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: CachedNetworkImageProvider(
            photo.photoSource.landscape.value.fold(
              (_) => 'https://plchldr.co/i/150x300?text=No Image',
              (value) => value,
            ),
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(.5),
                  Colors.black.withOpacity(0),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: photo.photographerName.value.fold(
              (_) => const SizedBox(),
              (value) => Text(value),
            ),
          ),
        ],
      ),
    );
  }
}
