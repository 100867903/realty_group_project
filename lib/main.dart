import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'ListingsPage.dart';
import 'StarredListings.dart';
import 'AddListingPage.dart'; // Import the AddListingPage
import 'firebase_options.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => StarredListings(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('Error initializing Firebase');
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Error initializing Firebase'),
              ),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Realty Group',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
              useMaterial3: true,
            ),
            routes: {
              '/listings': (context) => const ListingsPage(),
              '/addListing': (context) => AddListingPage(), // Add route for AddListingPage
            },
            home: Scaffold(
              appBar: AppBar(
                title: const Text('Listings'),
              ),
              body: ListingsPage(),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/addListing'); // Navigate to AddListingPage
                },
                child: const Icon(Icons.add),
              ),
            ),
          );
        }

        return const MaterialApp(
          home: Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
