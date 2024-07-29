import 'package:flutter/material.dart';
import '../models/book.dart';  // Import the Book model

class HomeTab extends StatelessWidget {
  final List<Book> books;  // Declare a field to hold the books

  HomeTab({required this.books});  // Constructor to accept books list

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return ListTile(
            title: Text(book.name),  // Use 'title' if that’s what you have in the Book model
            subtitle: Text(book.author),
            leading: Image.asset(book.coverImage),
            // Add other UI elements as needed
          );
        },
      ),
    );
  }
}