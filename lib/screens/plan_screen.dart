import 'package:flutter/material.dart';
import 'package:gym_management_app/models/plan_model.dart';
import 'package:gym_management_app/constants/colors.dart';
import 'package:gym_management_app/widgets/custom_drawer.dart';
import 'package:gym_management_app/widgets/plan_form_widget.dart';
import 'package:gym_management_app/widgets/plan_list_widget.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController validityController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  final List<PlanModel> _allPlans = [];
  int? editingIndex; 

  List<PlanModel> get filteredPlans {
    if (searchController.text.isEmpty) return _allPlans;
    return _allPlans
        .where((plan) => plan.name.toLowerCase().contains(searchController.text.toLowerCase()))
        .toList();
  }

  bool showForm = false;

  void _onSave() {
    final name = nameController.text;
    final validity = int.tryParse(validityController.text) ?? 0;
    final amount = double.tryParse(amountController.text) ?? 0.0;

    if (name.isNotEmpty && validity > 0 && amount > 0) {
      setState(() {
        if (editingIndex != null) {
          _allPlans[editingIndex!] = PlanModel(name: name, validity: validity, amount: amount);
          editingIndex = null;
        } else {
          _allPlans.add(PlanModel(name: name, validity: validity, amount: amount));
        }
        _clearForm();
        showForm = false;
      });
    } else {
      _showErrorMessage('Please enter valid data');
    }
  }

  void _onEdit(PlanModel plan) {
    final index = _allPlans.indexWhere(
      (p) => p.name == plan.name && p.validity == plan.validity && p.amount == plan.amount,
    );

    if (index != -1) {
      setState(() {
        editingIndex = index;
        nameController.text = plan.name;
        validityController.text = plan.validity.toString();
        amountController.text = plan.amount.toString();
        showForm = true;
      });
    }
  }

  void _onCancel() {
    setState(() {
      _clearForm();
      showForm = false;
    });
  }

  void _clearForm() {
    nameController.clear();
    validityController.clear();
    amountController.clear();
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(
        adminName: "CaesAr",
        adminEmail: "caesar@gmail.com",
        indexPage: 1,
      ),
      backgroundColor: AppColors.grayLight,
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.white,
              child: Image.asset(
                "assets/images/logo.png",
                height: 40,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Plan',
              style: TextStyle(color: AppColors.white),
            ),
          ],
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: AppColors.white),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Membership Plans',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      showForm = !showForm;
                      if (!showForm) _onCancel();
                    });
                  },
                  icon: Icon(showForm ? Icons.close : Icons.add),
                  label: Text(showForm ? 'Cancel' : 'Add Plan'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: showForm ? Colors.red : AppColors.primary,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (showForm)
              PlanFormWidget(
                nameController: nameController,
                validityController: validityController,
                amountController: amountController,
                onSave: _onSave,
                onCancel: _onCancel,
              ),
            const SizedBox(height: 20),
            Expanded(
              child: Card(
                color: AppColors.primaryDark,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          width: 250,
                          child: TextField(
                            controller: searchController,
                            onChanged: (_) => setState(() {}),
                            decoration: InputDecoration(
                              hintText: 'Search',
                              prefixIcon: const Icon(Icons.search),
                              filled: true,
                              fillColor: AppColors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: _allPlans.isEmpty
                            ? const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Text(
                                    'No plans added yet. Use the Add Plan button to create a new plan.',
                                    style: TextStyle(color: AppColors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            : PlanListWidget(
                                plans: filteredPlans,
                                onEdit: _onEdit,
                              ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    validityController.dispose();
    amountController.dispose();
    searchController.dispose();
    super.dispose();
  }
}
