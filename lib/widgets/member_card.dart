import 'package:flutter/material.dart';

class MemberCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final VoidCallback? onMorePressed;

  const MemberCard({
    super.key,
    required this.name,
    required this.subtitle,
    this.onMorePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.grey,
          child: Icon(Icons.person, color: Colors.white),
        ),
        title: Text(name),
        subtitle: Text(subtitle),
        trailing: IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: onMorePressed,
          tooltip: "Member options",
        ),
      ),
    );
  }
}
