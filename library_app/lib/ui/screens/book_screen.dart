import 'package:flutter/material.dart';
import 'package:library_app/logic/models/book.dart';
import 'package:library_app/ui/widgets/book_image.dart';

class BookScreen extends StatefulWidget {
  final Book book;

  const BookScreen({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  _buildBookImage(),
                  const SizedBox(height: 8),
                  _buildTitle(),
                  const SizedBox(height: 4),
                  _buildAuthor(),
                  const SizedBox(height: 16),
                  _buildPublicationInfo(),
                  const SizedBox(height: 2),
                  Container(
                    height: 1,
                    color: Colors.grey.withOpacity(0.8),
                  ),
                  const SizedBox(height: 8),
                  _buildDescription(),
                  const SizedBox(height: 16),
                  _buildTags(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBookImage() {
    return Hero(
      tag: widget.book.title + widget.book.imageUrl,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 6,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.shadow.withOpacity(0.33),
                blurRadius: 3,
              ),
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(9),
          child: BookImage(
            bookImageUrl: widget.book.imageUrl,
            width: MediaQuery.of(context).size.width / 1.5,
            height: (MediaQuery.of(context).size.width / 1.5) + 75,
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      widget.book.title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildAuthor() {
    return Text(
      'by ${widget.book.author}',
      style: const TextStyle(
        fontSize: 16,
      ),
    );
  }

  Widget _buildPublicationInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.book.publisher,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
        Text(
          widget.book.publicationDate,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return const Text(
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
      maxLines: 6,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildTags() {
    return Row(
      children: widget.book.tags.map((tag) {
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.withOpacity(0.4),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Text(tag),
            ),
          ),
        );
      }).toList(),
    );
  }
}
