import 'package:flutter/material.dart';
import 'package:library_app/ui/widgets/book_image.dart';

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
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: title + imageUrl,
            child: BookImage(bookImageUrl: imageUrl),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            author,
          ),
        ],
      ),
    );
  }
}
