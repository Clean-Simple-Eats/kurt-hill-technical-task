import 'package:flutter/material.dart';
import 'package:library_app/logic/models/book.dart';

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
  ScrollController? _scrollController;
  final _height = 200;
  bool _collapsedState = true;

  bool get _isCollapsed =>
      _scrollController != null &&
      _scrollController!.hasClients &&
      _scrollController!.offset > (_height - kToolbarHeight);

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_collapsedState != _isCollapsed) {
          setState(() {
            _collapsedState = _isCollapsed;
          });
        }
      });
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, _) {
          return [
            SliverAppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              pinned: true,
              expandedHeight: 350,
              centerTitle: true,
              foregroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: _isCollapsed
                  ? Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            widget.book.imageUrl,
                            fit: BoxFit.cover,
                            height: 35,
                            width: 35,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          widget.book.title,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                        ),
                      ],
                    )
                  : null,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: ClipRRect(
                  child: Hero(
                    tag: widget.book.title + widget.book.imageUrl,
                    child: Image.network(
                      widget.book.imageUrl,
                      fit: BoxFit.fill,
                      width: double.infinity,
                    ),
                  ),
                ),
                stretchModes: const [StretchMode.zoomBackground],
              ),
            )
          ];
        },
        body: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate.fixed(
                [
                  Text(widget.book.title),
                  Text(widget.book.author),
                  Text(widget.book.publisher),
                  Text(widget.book.publicationDate),
                  Text(widget.book.genre),
                  Row(
                    children: widget.book.tags.map((e) => Text(e)).toList(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

  // final String title;
  // final String author;
  // final String publisher;
  // final String publicationDate;
  // final String genre;
  // final List<String> tags;
  // final String imageUrl;
