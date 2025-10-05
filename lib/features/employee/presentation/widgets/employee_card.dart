import 'package:flutter/material.dart';
import 'package:recorder_app/core/constants/app_colors.dart';
import 'package:recorder_app/core/theme/app_text_styles.dart';
import '../../domain/entities/employee_entity.dart';

class EmployeeCard extends StatelessWidget {
  final EmployeeEntity employee;
  final bool isLastItem;

  const EmployeeCard({
    super.key,
    required this.employee,
    this.isLastItem = false,
  });

  @override
  Widget build(BuildContext context) {
    final isFemale = employee.gender.toLowerCase() == 'female';
    final cardBg = isFemale ? const Color(0xFFFFF3FC) : const Color(0xFFF4F9FF);
    final borderColor = isFemale ? const Color(0xFFFEB4EB) : const Color(0xFF77C2FF);
    final genderColor = isFemale ? AppColors.genderFemale : AppColors.genderMale;
    final genderIcon = isFemale ? Icons.female : Icons.male;

    return Container(padding: EdgeInsets.symmetric(vertical: isLastItem ? 24 : 16),
      width: 326,
      margin: EdgeInsets.only(
        left: 25,
        right: 25,

      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: borderColor, width: 1),
            ),
            color: cardBg,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text(
                    employee.fullName,
                    style: AppTextStyles.employeeName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    employee.email,
                    style: AppTextStyles.employeeEmail,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 20),

                  // Details
                  SizedBox(
                    width: 294,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow('Date of Birth', employee.formattedDob),
                        const SizedBox(height: 12),
                        _buildDetailRow('Registered on', employee.formattedRegisteredDate),
                        const SizedBox(height: 12),
                        _buildDetailRow('Phone No.', employee.phone),
                        const SizedBox(height: 12),
                        _buildGenderRow('Gender', genderIcon, genderColor,
                            isFemale ? 'Female' : 'Male'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: -20,
            right: 20,
            child: Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4),
              ),
              child: CircleAvatar(
                backgroundImage: NetworkImage(employee.pictureUrl),
                onBackgroundImageError: (_, __) {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return SizedBox(
      width: 294,
      height: 14,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // ← Figma alignment
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: AppTextStyles.employeeDetailLabel,
          ),
          Text(
            value,
            style: AppTextStyles.employeeDetailValue,
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }

  Widget _buildGenderRow(String label, IconData icon, Color color, String text) {
    return SizedBox(
      width: 294,
      height: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: AppTextStyles.employeeDetailLabel,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: color),
              const SizedBox(width: 4),
              Text(
                text,
                style: AppTextStyles.genderTextWithColor(color),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
