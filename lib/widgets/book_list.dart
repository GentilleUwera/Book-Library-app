import 'package:flutter/material.dart';
import '../models/book.dart';

class BookList extends StatelessWidget {
  final List<Book> books;

  BookList({required this.books});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Image.asset(books[index].coverImage),
          title: Text(books[index].name),
          subtitle: Text(books[index].author),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(books[index].rating.round(), (index) {
              return Icon(Icons.star, color: Colors.amber);
            }),
          ),
        );
      },
    );
  }
}