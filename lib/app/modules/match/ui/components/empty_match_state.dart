import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qual_time/app/core/components/primary_button.dart';

class EmptyMatchState extends StatelessWidget {
  final String message;
  final String buttonLabel;
  final VoidCallback onTap;
  final bool isRegistration;

  const EmptyMatchState({
    super.key,
    required this.message,
    required this.buttonLabel,
    required this.onTap,
    this.isRegistration = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isRegistration
                  ? Icons.group_add_outlined
                  : Icons.sports_volleyball_outlined,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 24),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 32),
            PrimaryButton(label: buttonLabel, onTap: onTap),
          ],
        ),
      ),
    );
  }
}
