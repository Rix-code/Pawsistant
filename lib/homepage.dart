import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  // Sample data for the stores (you can replace it with real data or API)
  final List<Map<String, String>> stores = [
    {'name': 'Store 1', 'image': 'assets/img/image1.jpg'},
    {'name': 'Store 2', 'image': 'assets/img/image2.jpg'},
    {'name': 'Store 3', 'image': 'assets/img/image3.jpg'},
    {'name': 'Store 4', 'image': 'assets/img/image4.jpg'},
    {'name': 'Store 5', 'image': 'assets/img/image1.jpg'},
  ];

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Column(
        children: [
          // Catalogue Section with Horizontal Scroll
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Featured',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          // Horizontal Scrollable ListView for stores
          // ignore: sized_box_for_whitespace
          Container(
            height: 200, // Set a fixed height for the horizontal scrollable area
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: stores.length,
              itemBuilder: (context, index) {
                final store = stores[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      // Handle store tap, e.g., navigate to store details page
                      // ignore: avoid_print
                      print('Tapped on ${store['name']}');
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        width: 150, // Width for each store item
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Replace with an actual image asset or network image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                store['image']!,
                                fit: BoxFit.cover,
                                height: 120,
                                width: 150,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              store['name']!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Catalogue Section with Horizontal Scroll
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Reccomended',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          // Horizontal Scrollable ListView for stores
          // ignore: sized_box_for_whitespace
          Container(
            height: 200, // Set a fixed height for the horizontal scrollable area
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: stores.length,
              itemBuilder: (context, index) {
                final store = stores[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      // Handle store tap, e.g., navigate to store details page
                      // ignore: avoid_print
                      print('Tapped on ${store['name']}');
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        width: 150, // Width for each store item
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Replace with an actual image asset or network image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                store['image']!,
                                fit: BoxFit.cover,
                                height: 120,
                                width: 150,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              store['name']!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              // Home - do nothing as we are already on the home page
              break;
            case 1:
              // Navigate to the ChatPage when the Chat button is tapped
              Navigator.pushNamed(context, '/chat');
              break;
            case 2:
              Navigator.pushNamed(context, '/profile');
              break;
          }
        },
      ),
    );
  }
}
