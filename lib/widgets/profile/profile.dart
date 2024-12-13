import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int revisitCount = 0;

  @override
  Widget build(BuildContext context) {
    String imageUrl = 'https://picsum.photos/250?image=9';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(
            imageUrl: imageUrl,
          ))).then((value) {
            setState(() {
              revisitCount++;
            });
          });
        },
        child: Center(
          child: Column(
            children: [
              Hero(
                tag: imageUrl,
                child: Image.network(imageUrl)
              ),
              Text('Revisit count: $revisitCount')
            ],
          )
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  const DetailPage({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
      ),
      body: Center(
        child: Column(
          children: [
            Hero(
              tag: imageUrl,
              child: Image.network(imageUrl)
            ),
          ],
        ),
      ),
    );
  }
}