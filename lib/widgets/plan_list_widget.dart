import 'package:flutter/material.dart';
import 'package:gym_management_app/models/plan_model.dart';
import 'package:gym_management_app/constants/colors.dart';

class PlanListWidget extends StatelessWidget {
  final List<PlanModel> plans;
  final Function(PlanModel) onEdit;

  const PlanListWidget({
    Key? key,
    required this.plans,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primaryDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 24,
            headingRowColor: MaterialStateColor.resolveWith(
              (states) => AppColors.primary,
            ),
            columns: const [
              DataColumn(
                label: Text(
                  'Plan Name',
                  style: TextStyle(color: AppColors.white),
                ),
              ),
              DataColumn(
                label: Text(
                  'Validity',
                  style: TextStyle(color: AppColors.white),
                ),
              ),
              DataColumn(
                label: Text(
                  'Amount',
                  style: TextStyle(color: AppColors.white),
                ),
              ),
              DataColumn(
                label: Text(
                  'Edit',
                  style: TextStyle(color: AppColors.white),
                ),
              ),
            ],
            rows: plans.map((plan) {
              return DataRow(
                cells: [
                  DataCell(Text(plan.name,
                      style: const TextStyle(color: AppColors.white))),
                  DataCell(Text('${plan.validity}',
                      style: const TextStyle(color: AppColors.white))),
                  DataCell(Text('${plan.amount}',
                      style: const TextStyle(color: AppColors.white))),
                  DataCell(
                    ElevatedButton(
                      onPressed: () => onEdit(plan),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.yellow,
                        foregroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Edit'),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
