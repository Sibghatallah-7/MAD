import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tech Gadgets Catalog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();

    _timer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MainCatalogPage()),
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade700,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.devices, size: 50, color: Colors.green),
                ),
                SizedBox(height: 24),
                Text(
                  'Tech Gadgets Catalog',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'MAD Assignment #2',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 40),
                CircularProgressIndicator(
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MainCatalogPage extends StatefulWidget {
  const MainCatalogPage({super.key});

  @override
  State<MainCatalogPage> createState() => _MainCatalogPageState();
}

class _MainCatalogPageState extends State<MainCatalogPage> {
  int _currentIndex = 0;

  final List<Map<String, String>> techDevices = const [
    {'name': 'iPhone 15 Pro Max', 'price': '\$1,199', 'feature': 'A17 Pro & Titanium'},
    {'name': 'MacBook Pro M3', 'price': '\$1,599', 'feature': 'M3 Max & 22hr Battery'},
    {'name': 'Sony WH-1000XM5', 'price': '\$399', 'feature': 'Industry-best ANC'},
    {'name': 'Apple Watch Ultra 2', 'price': '\$799', 'feature': 'Rugged Titanium Case'},
    {'name': 'iPad Pro M4', 'price': '\$999', 'feature': 'OLED & M4 Power'},
    {'name': 'Fujifilm X-T5', 'price': '\$1,699', 'feature': '40MP Vintage Body'},
    {'name': 'Steam Deck OLED', 'price': '\$549', 'feature': 'Portable Gaming'},
    {'name': 'Dell UltraSharp 32"', 'price': '\$799', 'feature': '4K 120Hz Monitor'},
    {'name': 'Keychron Q1 Pro', 'price': '\$199', 'feature': 'Wireless Mechanical'},
    {'name': 'DJI Mini 4 Pro', 'price': '\$759', 'feature': '4K/60fps HDR Drone'},
    {'name': 'Galaxy S24 Ultra', 'price': '\$1,299', 'feature': 'AI Zoom & S-Pen'},
  ];

  final List<Map<String, dynamic>> categories = const [
    {'title': 'Phones', 'count': '24 items', 'icon': Icons.phone_android},
    {'title': 'Laptops', 'count': '15 items', 'icon': Icons.laptop},
    {'title': 'Audio', 'count': '18 items', 'icon': Icons.headphones},
    {'title': 'Wearables', 'count': '12 items', 'icon': Icons.watch},
    {'title': 'Cameras', 'count': '10 items', 'icon': Icons.camera_alt},
    {'title': 'Accessories', 'count': '30 items', 'icon': Icons.cable},
  ];

  void _restartSplash(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const SplashScreen()),
      (route) => false,
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
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Restart Splash Screen',
            onPressed: () => _restartSplash(context),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              accountName: Text('Sibghatallah'),
              accountEmail: Text('sibghatallah@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 35, color: Colors.green),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home Screen'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _currentIndex = 0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Tech List (10+ items)'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _currentIndex = 1);
              },
            ),
            ListTile(
              leading: const Icon(Icons.grid_view),
              title: const Text('Gadget Categories (6 items)'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _currentIndex = 2);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.replay),
              title: const Text('Restart Splash Screen'),
              onTap: () {
                Navigator.pop(context);
                _restartSplash(context);
              },
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
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Tech List (10+)',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Categories (6)',
          ),
        ],
      ),
    );
  }

  String _getAppBarTitle() {
    if (_currentIndex == 0) return 'Tech Catalog Home';
    if (_currentIndex == 1) return 'Tech Devices (${techDevices.length})';
    return 'Gadget Categories (${categories.length})';
  }

  Widget _buildTabBody() {
    if (_currentIndex == 0) {
      return _buildHomeScreen();
    } else if (_currentIndex == 1) {
      return const ListScreenContent(showBackButton: false);
    } else {
      return _buildAboutScreen();
    }
  }

  Widget _buildHomeScreen() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tech Gadgets Hub',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Explore flagship smartphones, powerful laptops, and accessories. Built for MAD Assignment #2 with animations, navigation, lists, and grids.',
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          appBar: AppBar(
                            title: const Text('Tech Devices List'),
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                          body: const ListScreenContent(showBackButton: true),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Explore'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Quick Actions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.4,
              children: [
                _actionCard('View Devices', Icons.list, () => setState(() => _currentIndex = 1)),
                _actionCard('View Categories', Icons.grid_view, () => setState(() => _currentIndex = 2)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionCard(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.green.shade200),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.green, size: 32),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutScreen() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Gadget Categories (6 items Grid)',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            'Explore categories as required by Assignment #2.',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.1,
              ),
              itemBuilder: (context, index) {
                final cat = categories[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(cat['icon'] as IconData, color: Colors.green.shade800, size: 32),
                      const SizedBox(height: 12),
                      Text(
                        cat['title'] as String,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        cat['count'] as String,
                        style: const TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ListScreenContent extends StatelessWidget {
  final bool showBackButton;
  const ListScreenContent({super.key, this.showBackButton = false});

  final List<Map<String, String>> techDevices = const [
    {'name': 'iPhone 15 Pro Max', 'price': '\$1,199', 'feature': 'A17 Pro & Titanium'},
    {'name': 'MacBook Pro M3', 'price': '\$1,599', 'feature': 'M3 Max & 22hr Battery'},
    {'name': 'Sony WH-1000XM5', 'price': '\$399', 'feature': 'Industry-best ANC'},
    {'name': 'Apple Watch Ultra 2', 'price': '\$799', 'feature': 'Rugged Titanium Case'},
    {'name': 'iPad Pro M4', 'price': '\$999', 'feature': 'OLED & M4 Power'},
    {'name': 'Fujifilm X-T5', 'price': '\$1,699', 'feature': '40MP Vintage Body'},
    {'name': 'Steam Deck OLED', 'price': '\$549', 'feature': 'Portable Gaming'},
    {'name': 'Dell UltraSharp 32"', 'price': '\$799', 'feature': '4K 120Hz Monitor'},
    {'name': 'Keychron Q1 Pro', 'price': '\$199', 'feature': 'Wireless Mechanical'},
    {'name': 'DJI Mini 4 Pro', 'price': '\$759', 'feature': '4K/60fps HDR Drone'},
    {'name': 'Galaxy S24 Ultra', 'price': '\$1,299', 'feature': 'AI Zoom & S-Pen'},
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 120.0,
          floating: false,
          pinned: true,
          backgroundColor: Colors.green,
          automaticallyImplyLeading: false,
          leading: showBackButton
              ? IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                )
              : null,
          flexibleSpace: const FlexibleSpaceBar(
            title: Text('Tech Devices (10+ List)', style: TextStyle(fontSize: 16, color: Colors.white)),
            background: DecoratedBox(
              decoration: BoxDecoration(color: Colors.green),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(12),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final device = techDevices[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.green.shade100,
                      child: const Icon(Icons.devices, color: Colors.green),
                    ),
                    title: Text(device['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(device['feature']!),
                    trailing: Text(
                      device['price']!,
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 15),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                            deviceName: device['name']!,
                            devicePrice: device['price']!,
                            deviceFeature: device['feature']!,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              childCount: techDevices.length,
            ),
          ),
        ),
      ],
    );
  }
}

class DetailPage extends StatelessWidget {
  final String deviceName;
  final String devicePrice;
  final String deviceFeature;

  const DetailPage({
    super.key,
    required this.deviceName,
    required this.devicePrice,
    required this.deviceFeature,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(deviceName),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Icon(Icons.devices_other, size: 100, color: Colors.green),
            ),
            const SizedBox(height: 32),
            Text(
              deviceName,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'Price: $devicePrice',
              style: const TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Text(
              'Key Feature: $deviceFeature',
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                onPressed: () => Navigator.pop(context),
                child: const Text('Back to Catalog'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
