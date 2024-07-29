import 'package:book_library_app/screens/book_detail_screen.dart';
import 'package:flutter/material.dart';
import '../models/book.dart';

class SearchScreen extends StatefulWidget {
  final List<Book> books;

  SearchScreen({required this.books});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late List<Book> _filteredBooks;
  late String _searchQuery;

  @override
  void initState() {
    super.initState();
    _filteredBooks = widget.books;
    _searchQuery = '';
  }

  void _filterBooks(String query) {
    setState(() {
      _searchQuery = query;
      _filteredBooks = widget.books.where((book) {
        return book.name.toLowerCase().contains(query.toLowerCase()) ||
               book.author.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Books'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56.0),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterBooks,
              decoration: InputDecoration(
                labelText: 'Search by title or author',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0), // Curved border radius
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0), // Same curvature for focused state
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0), // Same curvature for enabled state
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _filteredBooks.length,
        itemBuilder: (context, index) {
          final book = _filteredBooks[index];
          return ListTile(
            leading: Image.asset(book.coverImage, fit: BoxFit.cover, width: 50, height: 50),
            title: Text(book.name),
            subtitle: Text(book.author),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetailScreen(book: book),
                ),
              );
            },
          );
        },
      ),
    );
  }
}