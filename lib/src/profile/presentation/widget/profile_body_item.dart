import 'package:flutter/material.dart';

class ProfileBodyItem extends StatelessWidget {
  const ProfileBodyItem({
    super.key,
    required this.infoThemeColor,
    required this.infoIcon,
    required this.infoTitle,
    required this.infoValue,
  });

  final Color infoThemeColor;
  final Widget infoIcon;
  final String infoTitle;
  final String infoValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 160,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFE4E6EA),
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: infoThemeColor,
                shape: BoxShape.circle,
              ),
              child: infoIcon,
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  infoTitle,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  infoValue,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
