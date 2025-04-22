import 'package:flutter/material.dart';
import 'package:gym_management_app/constants/colors.dart';

class PlanFormWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController validityController;
  final TextEditingController amountController;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const PlanFormWidget(
      {super.key,
      required this.nameController,
      required this.validityController,
      required this.amountController,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primaryDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildTextField(nameController, 'Plan Name'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTextField(validityController, 'Validity'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildTextField(amountController, 'Amount'),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  onPressed: onSave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.yellow,
                    foregroundColor: AppColors.primary,
                  ),
                  child: const Text('Save'),
                ),
                const SizedBox(width: 12),
                TextButton(
                  onPressed: onCancel,
                  child: const Text('Cancel'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.white,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
