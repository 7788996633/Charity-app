// ignore_for_file: library_private_types_in_public_api

import 'dart:ui';
import 'package:flutter/material.dart';

class AssociationInfoPage extends StatefulWidget {
  const AssociationInfoPage({super.key});

  @override
  _AssociationInfoPageState createState() => _AssociationInfoPageState();
}

class _AssociationInfoPageState extends State<AssociationInfoPage> {
  final List<Map<String, String>> _teamMembers = [
    {
      'name': 'John Doe',
      'role': 'Director',
      'image': 'https://via.placeholder.com/150'
    },
    {
      'name': 'Jane Smith',
      'role': 'Himma Team',
      'image': 'https://via.placeholder.com/150'
    },
    {
      'name': 'Alice Johnson',
      'role': 'Himma Team',
      'image': 'https://via.placeholder.com/150'
    },
    {
      'name': 'Bob Brown',
      'role': 'Volunteer',
      'image': 'https://via.placeholder.com/150'
    },
    {
      'name': 'Eve Davis',
      'role': 'Volunteer',
      'image': 'https://via.placeholder.com/150'
    },
  ];

  final ScrollController _scrollController = ScrollController();

  void _scrollToEnd() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> sortedTeamMembers = List.from(_teamMembers);
    sortedTeamMembers.sort((a, b) {
      if (a['role'] == 'Director') return -1;
      if (b['role'] == 'Director') return 1;
      if (a['role'] == 'Himma Team' && b['role'] == 'Volunteer') return -1;
      if (a['role'] == 'Volunteer' && b['role'] == 'Himma Team') return 1;
      return 0;
    });

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, Colors.purple],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 30),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(
                              0.1), // Adjust opacity for glass effect
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Text(
                              'About the Association',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Al-Khair Association is a non-profit organization aimed at helping those in need and improving community conditions through various voluntary programs and initiatives.',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Our Mission',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'To promote the spirit of cooperation and volunteering among community members and achieve sustainable development.',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Our Goals',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              '1. Helping those in need.\n2. Improving living conditions.\n3. Promoting education and health.\n4. Providing volunteering opportunities.',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Our Team',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ...sortedTeamMembers.map(
                              (member) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundImage:
                                            NetworkImage(member['image']!),
                                      ),
                                      const SizedBox(width: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            member['name']!,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            member['role']!,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 20,
            bottom: 20,
            child: FloatingActionButton(
              onPressed: _scrollToEnd,
              child: const Icon(Icons.arrow_downward),
            ),
          ),
        ],
      ),
    );
  }
}
