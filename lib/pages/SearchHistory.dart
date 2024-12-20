import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchHistory extends StatefulWidget {
  const SearchHistory({super.key});

  @override
  _SearchHistoryState createState() => _SearchHistoryState();
}

class _SearchHistoryState extends State<SearchHistory> {
  List<String> searches = [];

  @override
  void initState() {
    super.initState();
    _loadSearchHistory();
  }

  Future<void> _loadSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      searches = prefs.getStringList('searchHistory') ?? [];
    });
  }

  Future<void> _clearSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      searches = [];
    });
    await prefs.setStringList('searchHistory', searches);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        title: const Text("Previous Searches"),
        actions: [
          IconButton(
              onPressed: _clearSearchHistory,
              icon: const Icon(Icons.delete)
          )
        ],
      ),
      body: searches.isEmpty
          ? const Center(child: Text("No searches yet."))
          : ListView.builder(
              itemCount: searches.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.history),
                  title: Text(searches[index]),
                  onTap: (){
                    Navigator.pushNamed(
                      context,
                      '/listings',
                      arguments: searches[index],
                    );
                  },
                );
              },
            ),
    );
  }
}