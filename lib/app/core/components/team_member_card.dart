import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TeamMemberCard extends StatelessWidget {
  final String name;
  final VoidCallback? onRemove;
  final Widget? trailing;

  const TeamMemberCard({
    super.key,
    required this.name,
    this.onRemove,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Color(0xFFE3F2FD), // Light Blue
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person,
              color: Color(0xFF1565C0), // Darker Blue
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              name,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E1E1E), // Dark text
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (trailing != null)
            trailing!
          else if (onRemove != null)
            IconButton(
              icon: Icon(Icons.close, color: Colors.grey.shade600, size: 20),
              onPressed: onRemove,
              tooltip: 'Remover',
              splashRadius: 20,
            ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }
}
