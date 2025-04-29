import 'package:flutter/material.dart';
import 'package:gym_management_app/constants/colors.dart';
import 'package:gym_management_app/widgets/custom_drawer.dart';
import 'package:gym_management_app/widgets/member_card.dart';
import 'package:gym_management_app/widgets/inventory_item.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DateTime? selectedDate;

  // Sample inventory data
  final List<Map<String, dynamic>> inventory = [
    {"name": "Treadmill", "quantity": 4, "status": "Available"},
    {"name": "Bench Press", "quantity": 2, "status": "Needs Maintenance"},
    {"name": "Dumbbells", "quantity": 20, "status": "Available"},
  ];

  // Sample coaches data
  final List<String> coaches = [
    "Mo'men Maher",
    "Ramy Adel",
  ];

  // Sample members data
  final List<Map<String, dynamic>> members = [
    {"name": "Yasser Ibrahim", "subscription": "Paid: Jan 1 - Expiry: Feb 1"},
    {"name": "Mohamed Ali", "subscription": "Paid: Jan 1 - Expiry: Feb 1"},
  ];

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Standardize drawer implementation
      drawer: const CustomDrawer(
        adminName: "CaeSer",
        adminEmail: "CaeSer@gmail.com",
        indexPage: 0,
      ),

      // AppBar with consistent styling
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/logo.png'),
              radius: 15,
            ),
            const SizedBox(width: 18),
            const Text(
              "Dashboard",
              style: TextStyle(color: AppColors.white),
            ),
          ],
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: AppColors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today, color: AppColors.white),
            onPressed: _pickDate,
          ),
          IconButton(
            icon: const Icon(Icons.notifications, color: AppColors.white),
            onPressed: () {
              // here implement logic
            },
          ),
        ],
      ),

      // Body
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              "Welcome to Dashboard",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),

            if (selectedDate != null)
              Text("Selected date: ${selectedDate.toString().split(' ')[0]}"),

            const SizedBox(height: 24),

            // Coaches & Sales Cards
            Row(
              children: [
                _buildCoachesCard(),
                const SizedBox(width: 16),
                _buildSalesCard(),
              ],
            ),

            const SizedBox(height: 24),

            // Active Members Section
            _buildMembersSection(),

            const SizedBox(height: 24),

            // Inventory Section
            _buildInventorySection(),
          ],
        ),
      ),
    );
  }

  Widget _buildCoachesCard() {
    return Expanded(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCardHeader("Coaches"),
              const SizedBox(height: 12),
              ...coaches.map((coach) => _buildCoachRow(coach)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSalesCard() {
    return Expanded(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCardHeader("Sales"),
              const SizedBox(height: 12),
              Center(
                child: CircularPercentIndicator(
                  radius: 50.0,
                  lineWidth: 10.0,
                  percent: 0.84,
                  center: const Text("84%",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  progressColor: AppColors.primary,
                  backgroundColor: Colors.grey.shade300,
                  circularStrokeCap: CircularStrokeCap.round,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {
            // Action for more options
          },
          tooltip: "More options",
        ),
      ],
    );
  }

  Widget _buildCoachRow(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 8),
          Expanded(
            // avoid overflow
            child: Text(
              name,
              overflow: TextOverflow.ellipsis, 
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMembersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Active Members",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),

        // Search Field
        TextField(
          decoration: InputDecoration(
            hintText: "Search",
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        const SizedBox(height: 16),

        // Filter Chips
        Wrap(
          spacing: 8,
          children: [
            _buildFilterChip("Sort by", icon: Icons.sort_by_alpha),
            _buildFilterChip("Date Paid"),
            _buildFilterChip("Date Expiry"),
            _buildFilterChip("Status"),
          ],
        ),
        const Divider(height: 32),

        // Member Cards
        ...members.map((member) => MemberCard(
              name: member['name'],
              subtitle: member['subscription'],
              onMorePressed: () {
                // Action for more options
              },
            )),
      ],
    );
  }

  Widget _buildInventorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Inventory",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...inventory.map((item) => InventoryItem(
              name: item['name'],
              quantity: item['quantity'],
              status: item['status'],
            )),
        Center(
          child: TextButton(
            onPressed: () {
              // Action for show all button
            },
            child: const Text("Show All"),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, {IconData? icon}) {
    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) Icon(icon, size: 16),
          if (icon != null) const SizedBox(width: 4),
          Text(label),
        ],
      ),
      onSelected: (bool value) {},
    );
  }
}
