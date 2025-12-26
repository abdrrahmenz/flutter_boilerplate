import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../core.dart';

class BottomSheetImagePicker extends StatefulWidget {
  const BottomSheetImagePicker({
    super.key,
    required this.title,
    required this.onChanged,
    this.isPdf = false,
  });

  final String title;
  final ValueChanged<File?> onChanged;
  final bool isPdf;

  @override
  State<BottomSheetImagePicker> createState() => _BottomSheetImagePickerState();
}

class _BottomSheetImagePickerState extends State<BottomSheetImagePicker> {
  @override
  Widget build(BuildContext context) {
    return ContentSheet(
      expandContent: false,
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.dp24),
        child: Column(
          crossAxisAlignment: .start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, size: 32),
                ),
                Dimens.dp24.width,
                TitleText(widget.title)
              ],
            ),
            Dimens.dp32.height,
            Row(
              children: [
                buildTab(
                  context,
                  title: 'Kamera',
                  image: Icons.camera_alt,
                  type: 'camera',
                ),
                if (widget.isPdf) ...[
                  Dimens.dp16.width,
                  buildTab(
                    context,
                    title: 'PDF',
                    image: Icons.picture_as_pdf,
                    type: 'pdf',
                  ),
                ],
                Dimens.dp16.width,
                buildTab(
                  context,
                  title: 'Galeri',
                  image: Icons.image,
                  type: 'gallery',
                ),
              ],
            ),
            Dimens.dp32.height,
          ],
        ),
      ),
    );
  }

  void back() {
    Navigator.pop(context);
  }

  Widget buildTab(
    BuildContext context, {
    required String title,
    required IconData image,
    required String type,
  }) {
    return Expanded(
      child: InkWell(
        onTap: () async {
          if (type == 'pdf') {
            final result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['pdf'],
            );

            if (result != null) {
              widget.onChanged.call(File(result.files.single.path!));
            }
          } else {
            final image = await ImageHelper.getImage(type == 'camera');

            widget.onChanged.call(image);
          }

          back();
        },
        child: CardShadow(
          radius: Dimens.dp12,
          child: Column(
            children: [
              Icon(image, size: 40),
              Dimens.dp10.height,
              RegularText.medium(
                context,
                title,
                style: const TextStyle(fontWeight: .w500),
              )
            ],
          ),
        ),
      ),
    );
  }
}
