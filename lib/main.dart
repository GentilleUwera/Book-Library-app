import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/add_edit_book_screen.dart';
import 'screens/book_list_screen.dart';
import 'screens/book_detail_screen.dart';
import 'theme_notifier.dart';
import 'models/book.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isDarkMode = await ThemeNotifier.getThemePreference();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(isDarkMode),
      child: BookManagerApp(),
    ),
  );
}

class BookManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          title: 'Book Manager',
          theme: themeNotifier.currentTheme,
          home: HomeScreen(),
          routes: {
            '/addBook': (context) => AddEditBookScreen(),
            '/editBook': (context) => AddEditBookScreen(book: ModalRoute.of(context)!.settings.arguments as Book),
            '/bookDetail': (context) => BookDetailScreen(book: ModalRoute.of(context)!.settings.arguments as Book),
          },
        );
      },
    );
  }
}
