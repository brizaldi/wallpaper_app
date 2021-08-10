import 'package:flutter/material.dart';

import '../../../domain/photos/photo.dart';
import '../../../extra/style/style.dart';
import 'photo_grid_view_card.dart';

class PhotoGridView extends StatelessWidget {
  const PhotoGridView({
    Key? key,
    required this.controller,
    required this.onRetry,
    required this.photos,
  }) : super(key: key);

  final ScrollController controller;
  final VoidCallback onRetry;
  final List<Photo> photos;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Palette.amaranth,
      onRefresh: () async => onRetry.call(),
      child: GridView.builder(
        controller: controller,
        padding: const EdgeInsets.all(10),
        itemCount: photos.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: .5,
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return PhotoGridViewCard(
            photo: photos[index],
          );
        },
      ),
    );
  }
}
