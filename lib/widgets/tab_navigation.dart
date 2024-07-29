import 'package:flutter/material.dart';
import '../models/book.dart';  // Import the Book model
import '../screens/book_list_screen.dart';  // Import the BookListScreen
import '../widgets/home_tab.dart';  // Import the HomeTab widget
import '../screens/book_list_screen.dart';

// Define custom dark blue color
const Color darkBlue = Color(0xFF003366);

class TabNavigation extends StatefulWidget {
  @override
  _TabNavigationState createState() => _TabNavigationState();
}

class _TabNavigationState extends State<TabNavigation> {
  int _currentIndex = 0;

  // List of books
  final List<Book> books = [
    Book('Harry Potter and The Philosopher\'s Stone', 'J.K. Rowling', 'assets/images/book1.jpg', 5.0, 'Publication Date', 'Book Bio'),
    Book('UP', 'Lucas Martin', 'assets/images/book2.jpg', 4.0, 'Publication Date', 'Book Bio'),
    // Add the rest of the books here
  ];

  // List of widgets for different tabs
  List<Widget> get _children {
    return [
      HomeTab(books: books),  // Pass the books list to HomeTab
      Text('Search Page'),
      Text('Profile Page'),
      Container(),  // Placeholder for books list
    ];
  }

  void onTabTapped(int index) {
    setState(() {
      if (index == 3) {
        // Navigate to BookListScreen if the 'Books' tab is selected
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookListScreen(books: books)),
        );
      } else {
        _currentIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex != 3 ? _children[_currentIndex] : Container(),  // Show current tab content or empty container
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.orange,  // Set selected item color to orange
        unselectedItemColor: Colors.orange.withOpacity(0.6),  // Set unselected item color to a lighter orange
        backgroundColor: Colors.white,  // Set background color to white for the bottom navigation bar
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Books',
          )
        ],
      ),
    );
  }
}