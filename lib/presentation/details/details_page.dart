import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../domain/photos/photo.dart';
import 'widgets/photo_description.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key, required this.photo}) : super(key: key);

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Hero(
            tag: photo.photoId.value.fold(
              (_) => 'tag',
              (value) => value,
            ),
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image(
                image: CachedNetworkImageProvider(
                  photo.photoSource.landscape.value.fold(
                    (_) => 'https://plchldr.co/i/150x300?text=No Image',
                    (value) => value,
                  ),
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: kToolbarHeight + 16,
            left: 8,
            child: FloatingActionButton(
              onPressed: () {
                context.router.pop();
              },
              tooltip: 'Close',
              heroTag: 'close',
              mini: true,
              child: const Icon(
                Icons.chevron_left,
              ),
            ),
          ),
          PhotoDescription(photo: photo),
        ],
      ),
    );
  }
}
