import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart'; // Import the package
import '../models/book.dart';
import '../widgets/drawer_menu.dart';
import 'book_detail_screen.dart';
import 'add_edit_book_screen.dart';
import 'search_screen.dart';
import 'book_list_screen.dart';
import '../screens/book_list_screen.dart';

const Color darkBlue = Color(0xFF003366);

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  List<Book> books = [
    Book('Harry Potter and The Philosopher\'s Stone', 'J.K. Rowling', 'assets/images/book1.jpg', 5.0, '1997-06-26', 'A young wizard embarks on an epic journey to defeat the dark wizard Voldemort.'),
    Book('UP', 'Lucas Martin', 'assets/images/book2.jpg', 4.0, '2010-05-29', 'A whimsical adventure of an old man who fulfills his lifelong dream with the help of a young boy.'),
    Book('The Fault In Our Stars', 'Emma Davis', 'assets/images/book3.jpg', 4.5, '2012-01-10', 'A touching story of two teenagers who find love while battling cancer.'),
    Book('The Cinderella', 'Lily Evans', 'assets/images/book4.jpg', 5.0, '2006-03-15', 'A modern retelling of the classic fairy tale with a twist.'),
    Book('Maleficent', 'Olivia Green', 'assets/images/book5.jpg', 4.5, '2014-10-14', 'The story of Maleficent’s transformation from misunderstood villain to beloved heroine.'),
    Book('Beauty and the Beast', 'Sophia Lewis', 'assets/images/book6.jpg', 3.5, '1991-11-13', 'A tale of love and redemption between a beautiful woman and a cursed prince.'),
    Book('Before I Fall', 'Isabella White', 'assets/images/book7.jpg', 3.0, '2017-03-07', 'A high school girl gets a chance to relive her last day over and over again.'),
    Book('Avatar', 'Aiden Scott', 'assets/images/book8.jpg', 5.0, '2009-12-18', 'An epic science fiction film about a human-alien interaction on the planet Pandora.'),
    Book('They Both Die at the End', 'Adam Silvera',  'assets/images/book9.jpg', 3.0, '2017-09-05', 'Two boys who are told they have only one day to live decide to spend their last day together.'),
    Book('The Pages of The Mind', 'Jeffe Kennedy', 'assets/images/book10.jpg', 5.0, '2016-05-31', 'A captivating story of magic and romance in a world where the mind’s power is central to life.'),
  ];

  List<Book> originalBooks = [];

  @override
  void initState() {
    super.initState();
    originalBooks = List.from(books); // Save the original order of books
    _loadSortingPreference();
  }

  void _loadSortingPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String sortOption = prefs.getString('sortOption') ?? 'original';
    if (sortOption != 'original') {
      _sortBooks(sortOption, savePreference: false);
    }
  }

  void _saveSortingPreference(String sortOption) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('sortOption', sortOption);
  }

  void _sortBooks(String sortOption, {bool savePreference = true}) {
    setState(() {
      if (sortOption == 'title') {
        books.sort((a, b) => a.name.compareTo(b.name));
      } else if (sortOption == 'author') {
        books.sort((a, b) => a.author.compareTo(b.author));
      } else if (sortOption == 'rating') {
        books.sort((a, b) => b.rating.compareTo(a.rating));
      }
      if (savePreference) {
        _saveSortingPreference(sortOption);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmate'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditBookScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(books: books),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              showSortDialog(context);
            },
          ),
        ],
      ),
      drawer: DrawerMenu(books: books),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Book',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Book List',
          ),
        ],
        selectedItemColor: darkBlue,
        unselectedItemColor: darkBlue,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          switch (index) {
            case 0:
              // Navigate to HomeScreen itself (already here)
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(books: books),
                ),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditBookScreen(),
                ),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookListScreen(books: books),
                ),
              );
              break;
          }
        },
      ),
      body: _currentIndex == 0 ? buildHomeContent() : Container(),
    );
  }

  Widget buildHomeContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(20.0),
          margin: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: darkBlue,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            'Welcome to Bookmate!\nExplore your favorite books and discover new ones.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return ListTile(
                leading: Image.asset(book.coverImage, fit: BoxFit.cover, width: 50, height: 50),
                title: Text(book.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Author: ${book.author}'),
                    RatingBar.builder(
                      initialRating: book.rating,
                      minRating: 1,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 20.0,
                      direction: Axis.horizontal,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {},
                    ),
                  ],
                ),
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
        ),
      ],
    );
  }

  void showSortDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sort By'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text('Title'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _sortBooks('title');
                  },
                ),
                ListTile(
                  title: Text('Author'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _sortBooks('author');
                  },
                ),
                ListTile(
                  title: Text('Rating'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _sortBooks('rating');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}