import 'package:book_library_app/database_helper.dart';
import 'package:book_library_app/models/book.dart';
import 'package:flutter/material.dart';

class AddEditBookScreen extends StatefulWidget {
  final Book? book;

  AddEditBookScreen({this.book});

  @override
  _AddEditBookScreenState createState() => _AddEditBookScreenState();
}

class _AddEditBookScreenState extends State<AddEditBookScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _author = '';
  String _coverImage = '';
  double _rating = 0.0;
  String _publicationDate = '';
  String _bio = '';

  @override
  void initState() {
    super.initState();
    if (widget.book != null) {
      _title = widget.book!.name;
      _author = widget.book!.author;
      _coverImage = widget.book!.coverImage;
      _rating = widget.book!.rating;
      _publicationDate = widget.book!.publicationDate;
      _bio = widget.book!.bio;
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final dbHelper = DatabaseHelper.instance;
      if (widget.book == null) {
        final book = Book(_title, _author, _coverImage, _rating, _publicationDate, _bio);
        await dbHelper.insertBook(book);
      } else {
        final book = Book(_title, _author, _coverImage, _rating, _publicationDate, _bio, widget.book!.id);
        await dbHelper.updateBook(book);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book == null ? 'Add Book' : 'Edit Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              TextFormField(
                initialValue: _author,
                decoration: InputDecoration(labelText: 'Author'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an author';
                  }
                  return null;
                },
                onSaved: (value) {
                  _author = value!;
                },
              ),
              TextFormField(
                initialValue: _coverImage,
                decoration: InputDecoration(labelText: 'Cover Image'),
                onSaved: (value) {
                  _coverImage = value!;
                },
              ),
              TextFormField(
                initialValue: _rating.toString(),
                decoration: InputDecoration(labelText: 'Rating'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a rating';
                  }
                  return null;
                },
                onSaved: (value) {
                  _rating = double.parse(value!);
                },
              ),
              TextFormField(
                initialValue: _publicationDate,
                decoration: InputDecoration(labelText: 'Publication Date'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a publication date';
                  }
                  return null;
                },
                onSaved: (value) {
                  _publicationDate = value!;
                },
              ),
              TextFormField(
                initialValue: _bio,
                decoration: InputDecoration(labelText: 'Bio'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a bio';
                  }
                  return null;
                },
                onSaved: (value) {
                  _bio = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(widget.book == null ? 'Add Book' : 'Update Book'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
