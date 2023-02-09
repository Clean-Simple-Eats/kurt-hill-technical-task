import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class BookImage extends StatelessWidget {
  final String bookImageUrl;
  final double width;
  final double height;

  const BookImage({
    Key? key,
    required this.bookImageUrl,
    this.width = 150,
    this.height = 200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(9),
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        fit: BoxFit.cover,
        image: bookImageUrl,
        width: width,
        height: height,
      ),
    );
  }
}
