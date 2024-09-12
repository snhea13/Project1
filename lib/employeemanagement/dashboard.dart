import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DITPL'),
        backgroundColor: Color(0xFF3A57C4),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: DashboardCard(
                      icon: Icons.time_to_leave_rounded,
                      title: 'Total PL',
                      value: '10',
                      color: Colors.blueAccent, // Replace with your data
                    ),
                  ),
                  Expanded(
                    child: DashboardCard(
                      icon: Icons.time_to_leave,
                      title: 'Total Present Day',
                      value: '20',
                      color: Colors.blueAccent, // Replace with your data
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: DashboardCard(
                      icon: Icons.card_membership,
                      title: 'Late Mark',
                      value: '5',
                      color: Colors.blueAccent, // Replace with your data
                    ),
                  ),
                  Expanded(
                    child: DashboardCard(
                      icon: Icons.time_to_leave_outlined,
                      title: 'Half Day',
                      value: '2',
                      color: Colors.blueAccent, // Replace with your data
                    ),
                  ),
                ],
              ),
              DashboardCard(
                icon: Icons.leave_bags_at_home,
                title: 'Total Absent',
                value: '1',
                color: Colors.blueAccent, // Replace with your data
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color; // Add a color parameter

  DashboardCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color, // Use the color parameter here
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, size: 40.0, color: Colors.white), // Change icon color to contrast with the card background
            SizedBox(height: 8.0),
            Text(
              value,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white), // Change text color to contrast with the card background
            ),
            Text(
              title,
              style: TextStyle(color: Colors.white), // Change text color to contrast with the card background
            ),
          ],
        ),
      ),
    );
  }
}
