import 'package:flutter/material.dart';

import '../../../domain/photos/photo.dart';
import '../../../extra/style/style.dart';
import 'photo_list_view_card.dart';

class PhotoListView extends StatelessWidget {
  const PhotoListView({
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
      child: ListView.separated(
        controller: controller,
        padding: const EdgeInsets.all(16),
        itemCount: photos.length,
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16);
        },
        itemBuilder: (context, index) {
          return PhotoListViewCard(photo: photos[index]);
        },
      ),
    );
  }
}
