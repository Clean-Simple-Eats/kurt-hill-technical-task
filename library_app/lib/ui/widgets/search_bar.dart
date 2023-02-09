import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final Function(String) onTextChanged;

  const SearchBar({
    Key? key,
    required this.onTextChanged,
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
        hintText: 'Search...',
        suffixIcon: const Icon(Icons.search_rounded),
      ),
      onChanged: (text) => widget.onTextChanged(text),
    );
  }
}
