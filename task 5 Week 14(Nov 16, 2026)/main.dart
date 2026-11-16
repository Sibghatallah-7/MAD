import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: const GalleryPage(),
    );
  }
}

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  int _currentIndex = 0; // 0: Photos, 1: Albums, 2: Favorites

  final List<String> allImages = const [
    'images/1.jpg',
    'images/2.jpg',
    'images/3.jpg',
    'images/4.jpg',
    'images/5.jpg',
  ];

  final Set<String> favoriteImages = {};

  void _toggleFavorite(String imagePath) {
    setState(() {
      if (favoriteImages.contains(imagePath)) {
        favoriteImages.remove(imagePath);
      } else {
        favoriteImages.add(imagePath);
      }
    });
  }

  void _openPage(BuildContext context, Widget page) {
    Navigator.pop(context); // Close the drawer
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(_getAppBarTitle()),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              accountName: Text('Sibghatallah'),
              accountEmail: Text('Sibghatallah@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 35, color: Colors.green),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.cake),
              title: const Text('Birthdays'),
              onTap: () => _openPage(context, const SimplePage(title: 'Birthdays')),
            ),
            ListTile(
              leading: const Icon(Icons.sentiment_satisfied),
              title: const Text('Gratitude'),
              onTap: () => _openPage(context, const SimplePage(title: 'Gratitude')),
            ),
            ListTile(
              leading: const Icon(Icons.access_alarm),
              title: const Text('Reminders'),
              onTap: () => _openPage(context, const SimplePage(title: 'Reminders')),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () => _openPage(context, const SimplePage(title: 'Settings')),
            ),
          ],
        ),
      ),
      body: _buildTabBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.photo),
            label: 'Photos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.collections_bookmark),
            label: 'Albums',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }

  String _getAppBarTitle() {
    if (_currentIndex == 0) return 'Photos (${allImages.length})';
    if (_currentIndex == 1) return 'My Gallery - Albums';
    return 'Favorites (${favoriteImages.length})';
  }

  Widget _buildTabBody() {
    if (_currentIndex == 0) {
      return _buildImageGrid(allImages);
    } else if (_currentIndex == 1) {
      return _buildAlbumsList();
    } else {
      return _buildImageGrid(favoriteImages.toList(), emptyText: 'No favorite photos yet!');
    }
  }

  Widget _buildAlbumsList() {
    final albums = [
      {'title': 'Camera', 'count': '${allImages.length} photos', 'image': allImages[0]},
      {'title': 'Favorites', 'count': '${favoriteImages.length} photos', 'image': favoriteImages.isNotEmpty ? favoriteImages.first : allImages[1]},
      {'title': 'Recents', 'count': '${allImages.length} photos', 'image': allImages[2]},
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: albums.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemBuilder: (context, index) {
        final album = albums[index];
        return GestureDetector(
          onTap: () {
            setState(() {
              _currentIndex = album['title'] == 'Favorites' ? 2 : 0;
            });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    album['image']!,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                album['title']!,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                album['count']!,
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImageGrid(List<String> images, {String emptyText = 'No images found'}) {
    if (images.isEmpty) {
      return Center(
        child: Text(
          emptyText,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: images.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final path = images[index];
        final isFav = favoriteImages.contains(path);

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(
                  imagePath: path,
                  isFavorite: isFav,
                  onToggleFavorite: () => _toggleFavorite(path),
                ),
              ),
            );
          },
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    path,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 6,
                right: 6,
                child: GestureDetector(
                  onTap: () => _toggleFavorite(path),
                  child: CircleAvatar(
                    backgroundColor: Colors.black45,
                    radius: 16,
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? Colors.red : Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class DetailPage extends StatefulWidget {
  final String imagePath;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  const DetailPage({
    super.key,
    required this.imagePath,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late bool isFav;

  @override
  void initState() {
    super.initState();
    isFav = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Image View'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: isFav ? Colors.red : Colors.white,
            ),
            onPressed: () {
              setState(() {
                isFav = !isFav;
              });
              widget.onToggleFavorite();
            },
          ),
        ],
      ),
      body: Center(
        child: InteractiveViewer(
          child: Image.asset(
            widget.imagePath,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

class SimplePage extends StatelessWidget {
  final String title;

  const SimplePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text(
          '$title Page',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}