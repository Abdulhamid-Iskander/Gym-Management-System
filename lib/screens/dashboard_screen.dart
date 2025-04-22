import 'package:flutter/material.dart';
import 'package:gym_management_app/widgets/custom_drawer.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DateTime? selectedDate;

// TODO: Replace this dummy inventory data with API response later
  final List<Map<String, dynamic>> inventory = [
    {"name": "Treadmill", "quantity": 4, "status": "Available"},
    {"name": "Bench Press", "quantity": 2, "status": "Needs Maintenance"},
    {"name": "Dumbbells", "quantity": 20, "status": "Available"},
  ];

// NOTE: This is temporary for testing. Might be handled by the backend later
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
      drawer: CustomDrawer(
        adminName: "CaesAr",
        adminEmail: "caesar@gmail.com",
        indexPage: 0,
      ),

// Drawer section
//       drawer: Drawer(
//         child: Column(
//           children: [
//             // User info
//             const UserAccountsDrawerHeader(
//               decoration: BoxDecoration(
//                 color: Color(0xFF0C1E6F),
//               ),
//               accountName: Text("CaesAr"),
//               accountEmail: Text("caesar@gmail.com"),
//               currentAccountPicture: CircleAvatar(
//                 backgroundColor: Colors.grey,
//                 child: Icon(Icons.person, color: Colors.white),
//               ),
//             ),
//             // component
//             ListTile(
//               leading: Icon(Icons.dashboard),
//               title: Text("Dashboard"),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => DummyScreen(title: "Dashboard"),
//                     ));
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.person),
//               title: Text("Admin Profile"),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => DummyScreen(title: "Admin Profile"),
//                     ));
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.app_registration),
//               title: Text("Registration"),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => DummyScreen(title: "Registration"),
//                     ));
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.payment),
//               title: Text("Payment"),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => DummyScreen(title: "Payment"),
//                     ));
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.list),
//               title: Text("Plan"),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => DummyScreen(title: "Plan"),
//                     ));
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.people),
//               title: Text("View Members"),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => DummyScreen(title: "View Members"),
//                     ));
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.inventory),
//               title: Text("Inventory"),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => DummyScreen(title: "Inventory"),
//                     ));
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.fitness_center),
//               title: Text("Coaches"),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => DummyScreen(title: "Coaches"),
//                     ));
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.bar_chart),
//               title: Text("Report"),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => DummyScreen(title: "Report"),
//                     ));
//               },
//             ),
//             Spacer(),
//             ListTile(
//               leading: Icon(Icons.logout),
//               title: Text("Logout"),
//               onTap: () {
//                 Navigator.pop(context);
// // TODO: Add logout logic here
//               },
//             ),
//           ],
//         ),
//       ),

// AppBar
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C1E6F),
        title: const Text("Dashboard", style: TextStyle(color: Colors.white)),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () =>
                Scaffold.of(context).openDrawer(), // ✅ فتح الدروار صح
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today, color: Colors.white),
            onPressed: _pickDate,
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
            const Text("Active Members",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

// Search Field
// NOTE: UI only - search functionality not implemented yet (will be added after API integration)
// TODO: implement search logic (filter members based on input)

            TextField(
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
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

// Members Cards
            _buildMemberCard("Yasser Ibrahim", "Paid: Jan 1 - Expiry: Feb 1"),
            _buildMemberCard("Mohamed Ali", "Paid: Jan 1 - Expiry: Feb 1"),

            const SizedBox(height: 24),

// Inventory Section
            const Text("Inventory",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...inventory.map((item) => Card(
                  child: ListTile(
                    title: Text(item['name']),
                    subtitle: Text(
                        "Quantity: ${item['quantity']} | Status: ${item['status']}"),
                    trailing: Icon(
                      item['status'] == "Available"
                          ? Icons.check_circle
                          : Icons.warning,
                      color: item['status'] == "Available"
                          ? Colors.green
                          : Colors.orange,
                    ),
                  ),
                )),
            TextButton(
              onPressed: () {
// TODO: Implement "Show All" navigation
              },
              child: const Text("Show All"),
            ),
          ],
        ),
      ),
    );
  }

// Drawer item builder to reduce redundancy
  // ignore: unused_element
  Widget _buildDrawerItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DummyScreen(title: title),
          ),
        );
      },
    );
  }

// Reusable method for filter chips
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

// Coaches Card
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
              _buildCoachRow("Maher Mo'men"),
              _buildCoachRow("Big Rami"),
              _buildCoachRow("Peter"),
            ],
          ),
        ),
      ),
    );
  }

// Sales Card
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
                  progressColor: const Color(0xFF0C1E6F),
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

// Card header row with title and more icon
  Widget _buildCardHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {
// TODO: Implement options logic
          },
        ),
      ],
    );
  }

// Single coach row
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
          Text(name),
        ],
      ),
    );
  }

// Member card
  Widget _buildMemberCard(String name, String subtitle) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.grey,
          child: Icon(Icons.person, color: Colors.white),
        ),
        title: Text(name),
        subtitle: Text(subtitle),
        trailing: InkWell(
          onTap: () {
// TODO: Implement member options
          },
          child: const Icon(Icons.more_vert),
        ),
      ),
    );
  }
}

// Temporary screen for navigation testing
// TODO: Remove this once all screens are implemented
class DummyScreen extends StatelessWidget {
  final String title;
  const DummyScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text("This is the $title page")),
    );
  }
}
