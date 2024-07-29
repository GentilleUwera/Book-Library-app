import 'dart:io';

import 'package:flutter/material.dart';
import 'package:book_library_app/models/book.dart';
import 'package:book_library_app/database_helper.dart';
import 'add_edit_book_screen.dart';

class BookListScreen extends StatefulWidget {
  final List<Book> books;

  const BookListScreen({Key? key, required this.books}) : super(key: key);
  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  List<Book> _books = [];

  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    final dbHelper = DatabaseHelper.instance;
    List<Book> books = await dbHelper.getBooks();
    setState(() {
      _books = books;
    });
  }

  void _deleteBook(int id) async {
    final dbHelper = DatabaseHelper.instance;
    await dbHelper.deleteBook(id);
    _fetchBooks(); // Refresh the list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddEditBookScreen()),
              ).then((_) {
                _fetchBooks(); // Refresh the list after adding a book
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _books.length,
        itemBuilder: (context, index) {
          final book = _books[index];
          return ListTile(
            leading: book.coverImage.isNotEmpty
                ? Image.file(
                    File(book.coverImage),
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/images/book1.jpg', // Provide a default cover image in your assets
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
            title: Text(book.name),
            subtitle: Text(book.author),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteBook(book.id!),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditBookScreen(book: book),
                ),
              ).then((_) {
                _fetchBooks(); // Refresh the list after editing a book
              });
            },
          );
        },
      ),
    );
  }
}
