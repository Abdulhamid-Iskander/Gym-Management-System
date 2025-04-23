import 'package:flutter/material.dart';
import 'package:gym_management_app/models/plan_model.dart';
import 'package:gym_management_app/constants/colors.dart';

class PlanListWidget extends StatelessWidget {
  final List<PlanModel> plans;
  final Function(PlanModel) onEdit;

  const PlanListWidget({
    super.key,
    required this.plans,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 24,
          headingTextStyle: const TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
          headingRowColor: WidgetStateColor.resolveWith(
            (states) => AppColors.primary,
          ),
          dataRowColor: WidgetStateColor.resolveWith(
            (states) => AppColors.primaryDark,
          ),
          border: TableBorder(
            horizontalInside: BorderSide(
              // ignore: deprecated_member_use
              color: AppColors.white.withOpacity(0.2),
              width: 1,
            ),
          ),
          columns: const [
            DataColumn(
              label: Text('Plan Name'),
            ),
            DataColumn(
              label: Text('Validity (Days)'),
              numeric: true,
            ),
            DataColumn(
              label: Text('Amount'),
              numeric: true,
            ),
            DataColumn(
              label: Text('Actions'),
            ),
          ],
          rows: plans.map((plan) {
            return DataRow(
              cells: [
                DataCell(
                  Text(
                    plan.name,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    '${plan.validity}',
                    style: const TextStyle(color: AppColors.white),
                  ),
                ),
                DataCell(
                  Text(
                    '\$${plan.amount.toStringAsFixed(2)}',
                    style: const TextStyle(color: AppColors.white),
                  ),
                ),
                DataCell(
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => onEdit(plan),
                        icon: const Icon(
                          Icons.edit,
                          color: AppColors.yellow,
                        ),
                        tooltip: 'Edit Plan',
                      ),
                      IconButton(
                        onPressed: () {
                          // implemint in future 'we hope'.
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                        ),
                        tooltip: 'Delete Plan',
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}