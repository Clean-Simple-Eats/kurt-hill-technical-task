import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class BookListItem extends StatelessWidget {
  final String title;
  final String author;
  final String imageUrl;
  final VoidCallback onTap;

  const BookListItem({
    Key? key,
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Hero(
        tag: title + imageUrl,
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: imageUrl,
        ),
      ),
      title: Text(title),
      subtitle: Text(author),
      onTap: onTap,
    );
  }
}
