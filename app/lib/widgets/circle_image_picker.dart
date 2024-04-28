import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CircleImagePicker extends StatefulWidget {
  final Function(Uint8List data) onSelect;
  final double radius;
  final ImageProvider? initialImage;
  final String label;

  const CircleImagePicker(
      {super.key,
      required this.onSelect,
      this.radius = 30,
      this.initialImage,
      this.label = "Select Photo"});

  @override
  State<CircleImagePicker> createState() => _CircleImagePickerState();
}

class _CircleImagePickerState extends State<CircleImagePicker> {
  final ImagePicker _picker = ImagePicker();
  final ImageCropper _cropper = ImageCropper();
  Uint8List imageBytes = Uint8List(0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        XFile? image = await _picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 45,
          maxHeight: 500,
          maxWidth: 500,
        );
        if (image != null) {
          CroppedFile? croppedFile = await _cropper.cropImage(
            sourcePath: image.path,
            aspectRatio: const CropAspectRatio(
              ratioX: 1,
              ratioY: 1,
            ),
            maxWidth: 500,
            maxHeight: 500,
            compressFormat: ImageCompressFormat.jpg,
            compressQuality: 45,
            cropStyle: CropStyle.circle,
          );
          if (croppedFile != null) {
            croppedFile.readAsBytes().then((value) {
              setState(() {
                imageBytes = value;
                widget.onSelect(imageBytes);
              });
            });
          }
        }
      },
      child: imageBytes.isNotEmpty || widget.initialImage != null
          ? CircleAvatar(
              radius: widget.radius,
              backgroundImage: imageBytes.isEmpty
                  ? widget.initialImage
                  : MemoryImage(imageBytes),
            )
          : CircleAvatar(
              radius: widget.radius,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add_photo_alternate),
                  Text(
                    widget.label,
                    style: TextStyle(fontSize: widget.radius * 0.25),
                  ),
                ],
              ),
            ),
    );
  }
}
