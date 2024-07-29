import 'package:flutter/material.dart';
import 'package:book_library_app/database_helper.dart';
import 'package:book_library_app/models/book.dart';
import 'edit_book_screen.dart';  // Make sure you have this import if you have an edit book screen

class BookDetailScreen extends StatefulWidget {
  final Book book;

  BookDetailScreen({required this.book});

  @override
  _BookDetailScreenState createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  bool isRead = false;

  void deleteBook(BuildContext context) async {
    final dbHelper = DatabaseHelper.instance;
    await dbHelper.deleteBook(widget.book.id!);
    Navigator.pop(context);
  }

  void toggleReadStatus() {
    setState(() {
      isRead = !isRead;
    });
  }

  @override
  Widget build(BuildContext context) {
    const double coverWidth = 150;
    const double coverHeight = 200;
    const TextStyle textStyle = TextStyle(fontSize: 18, fontFamily: 'Arial');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.name, style: TextStyle(fontSize: 24)),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              deleteBook(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Navigate to edit book screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditBookScreen(book: widget.book),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                widget.book.coverImage,
                fit: BoxFit.cover,
                width: coverWidth,
                height: coverHeight,
              ),
              SizedBox(height: 16),
              Text(
                widget.book.name,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'by ${widget.book.author}',
                style: textStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'Published on: ${widget.book.publicationDate}',
                style: textStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                'Bio:',
                style: textStyle.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                widget.book.bio,
                style: textStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Rating: ',
                    style: textStyle,
                  ),
                  ...List.generate(5, (index) {
                    return Icon(
                      index < widget.book.rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                    );
                  }),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: toggleReadStatus,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isRead ? Colors.blue.shade900 : Colors.white,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check, color: isRead ? Colors.white : Colors.blue.shade900),
                    SizedBox(width: 8),
                    Text(
                      'Mark as Read',
                      style: TextStyle(color: isRead ? Colors.white : Colors.blue.shade900),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
