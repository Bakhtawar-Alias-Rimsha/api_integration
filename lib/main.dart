import 'package:flutter/material.dart';

void main() {
  runApp(const Week4ApiApp());
}

class Week4ApiApp extends StatelessWidget {
  const Week4ApiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API & Networking',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomeMenu(),
    );
  }
}

class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Integration'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _NavCard(
              title: 'Posts (JSONPlaceholder)',
              subtitle: 'HTTP request → parse JSON → ListView',
              icon: Icons.list_alt,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PostsListScreen()),
              ),
            ),
            const SizedBox(height: 16),
            _NavCard(
              title: 'User Profile (Random User)',
              subtitle: 'Fetch name, email, and profile picture',
              icon: Icons.person,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const UserProfileScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _NavCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Icon(icon, size: 36, color: Colors.teal),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Text(subtitle, style: const TextStyle(color: Colors.black54)),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.teal),
            ],
          ),
        ),
      ),
    );
  }
}

// Posts List Screen
class PostsListScreen extends StatefulWidget {
  const PostsListScreen({super.key});

  @override
  State<PostsListScreen> createState() => _PostsListScreenState();
}

class _PostsListScreenState extends State<PostsListScreen> {
  List<Map<String, dynamic>> posts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      posts = [
        {
          'id': 1,
          'title': 'Sample Post 1',
          'body': 'This is the body of the first sample post for demonstration purposes.',
          'userId': 1
        },
        {
          'id': 2,
          'title': 'Sample Post 2',
          'body': 'This is the body of the second sample post for demonstration purposes.',
          'userId': 1
        },
        {
          'id': 3,
          'title': 'Sample Post 3',
          'body': 'This is the body of the third sample post for demonstration purposes.',
          'userId': 2
        },
      ];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts List'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.teal))
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post['title'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(post['body']),
                  const SizedBox(height: 8),
                  Text(
                    'User ID: ${post['userId']}',
                    style: const TextStyle(color: Colors.teal),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// User Profile Screen
class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  Map<String, dynamic>? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      user = {
        'name': {'first': 'John', 'last': 'Doe'},
        'email': 'john.doe@example.com',
        'picture': {'large': 'https://randomuser.me/api/portraits/men/1.jpg'},
        'phone': '+1 (555) 123-4567',
        'location': {
          'city': 'New York',
          'country': 'United States'
        }
      };
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.teal))
          : Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(user!['picture']['large']),
            ),
            const SizedBox(height: 16),
            Text(
              '${user!['name']['first']} ${user!['name']['last']}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              user!['email'],
              style: const TextStyle(fontSize: 16, color: Colors.teal),
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _InfoRow(icon: Icons.phone, text: user!['phone']),
                    const SizedBox(height: 12),
                    _InfoRow(
                      icon: Icons.location_on,
                      text: '${user!['location']['city']}, ${user!['location']['country']}',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.teal),
        const SizedBox(width: 12),
        Text(text, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}