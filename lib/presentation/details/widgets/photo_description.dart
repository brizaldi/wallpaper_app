import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/photos/photo.dart';
import '../../../extra/constants/strings.dart';
import '../../../extra/style/style.dart';

class PhotoDescription extends StatelessWidget {
  const PhotoDescription({Key? key, required this.photo}) : super(key: key);

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? Palette.mineshaft.withOpacity(.5)
            : Palette.aquaHaze.withOpacity(.5),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: photo.photographerName.value.fold(
                (_) => const SizedBox(),
                (value) => Text(
                  value,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  photo.photoUrl.value.fold(
                    (_) => context.showToast(Strings.invalidUrlErrorMessage),
                    (value) => _launchUrl(url: value),
                  );
                },
                tooltip: 'Open in browser',
                icon: const Icon(Icons.open_in_new),
              ),
              IconButton(
                onPressed: () {
                  photo.photoSource.original.value.fold(
                    (_) => context.showToast(Strings.invalidUrlErrorMessage),
                    (value) => _launchUrl(url: value),
                  );
                },
                tooltip: 'Download',
                icon: const Icon(Icons.download),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl({required String url}) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
