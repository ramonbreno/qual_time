import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TeamManagementCard extends StatelessWidget {
  final String teamName;
  final int playerCount;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  const TeamManagementCard({
    super.key,
    required this.teamName,
    required this.playerCount,
    this.onTap,
    this.onDelete,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              offset: const Offset(0, 4),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children: [
            // Left Edit Icon
            GestureDetector(
              onTap: onEdit,
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(Icons.edit, color: Colors.blue, size: 20),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Middle Content - Team Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    teamName,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    '$playerCount Jogadores registrados',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (onDelete != null)
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.grey),
                      onPressed: onDelete,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.drag_indicator,
                    color: Colors.grey.shade400,
                    size: 24,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
