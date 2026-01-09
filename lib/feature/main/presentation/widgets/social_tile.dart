import 'package:flutter/material.dart';

class SocialTile extends StatelessWidget {
  const SocialTile({
    super.key,
    required this.name,
    required this.title,
    this.isGit = false,
    required this.onTap,
  });

  final String name, title;
  final bool isGit;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.66,
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            leading: isGit
                ? Container(
              width: 34,
              height: 34,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(name, fit: BoxFit.contain),
            )
                : Image.asset(name, width: 32, height: 32),
            title: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
