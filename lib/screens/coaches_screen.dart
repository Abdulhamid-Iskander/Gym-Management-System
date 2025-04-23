// ignore_for_file: unused_local_variable
import 'package:flutter/material.dart';
import 'package:gym_management_app/constants/colors.dart';
import 'package:gym_management_app/widgets/custom_drawer.dart';

class CoachesScreen extends StatefulWidget {
  const CoachesScreen({super.key});

  @override
  State<CoachesScreen> createState() => _CoachesScreenState();
}

class _CoachesScreenState extends State<CoachesScreen> {
  final List<Map<String, dynamic>> coaches = [
    {
      "name": "Mo'men Maher",
      "coachId": "SFM230IN1",
      "contact": "Mo_Maher@example.com",
      "expiration": "Feb 11, 2024"
    },
    {
      "name": "Ramy Adel",
      "coachId": "SFM230IN2",
      "contact": "Ramy@example.com",
      "expiration": "Feb 11, 2024"
    },
    {
      "name": "Peter",
      "coachId": "SFM230IN3",
      "contact": "peter@example.com",
      "expiration": "Feb 11, 2024"
    },
  ];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _coachIdController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _expirationController = TextEditingController();

  void _showAddCoachDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF332F4D),
          title: const Text(
            'Add New Coach',
            style: TextStyle(color: Colors.white),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField(_nameController, 'Name'),
                const SizedBox(height: 10),
                _buildTextField(_coachIdController, 'Coach ID'),
                const SizedBox(height: 10),
                _buildTextField(_contactController, 'Contact (Email/Phone)'),
                const SizedBox(height: 10),
                _buildDatePickerField(
                    _expirationController, 'Date Expiration (MM/DD/YYYY)'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: _saveCoach,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Color(0xFF332F4D),
              ),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
      ),
    );
  }

  Widget _buildDatePickerField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      readOnly: true,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          controller.text =
              "${pickedDate.month}/${pickedDate.day}/${pickedDate.year}";
        }
      },
    );
  }

  void _saveCoach() {
    setState(() {
      coaches.add({
        "name": _nameController.text,
        "coachId": _coachIdController.text,
        "contact": _contactController.text,
        "expiration": _expirationController.text,
      });
    });
    _clearControllers();
    Navigator.of(context).pop();
  }

  void _clearControllers() {
    _nameController.clear();
    _coachIdController.clear();
    _contactController.clear();
    _expirationController.clear();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _coachIdController.dispose();
    _contactController.dispose();
    _expirationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/logo.png'),
              radius: 15,
            ),
            const SizedBox(width: 18),
            const Text(
              'Coaches',
              style: TextStyle(color: AppColors.white),
            ),
          ],
        ),
        backgroundColor: AppColors.primary,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: AppColors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: AppColors.white),
            onPressed: () {
              // Implement logic here
            },
          ),
        ],
      ),
      drawer: const CustomDrawer(
        adminName: "CaesAr",
        adminEmail: "CaesAr@gmail.com", indexPage: 6,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Active Coaches',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildActionButtons(),
            const SizedBox(height: 20),
            _buildShowEntitiesDropdown(),
            const SizedBox(height: 20),
            _buildCoachesTable(),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton.icon(
          onPressed: _showAddCoachDialog,
          icon: const Icon(Icons.add),
          label: const Text('Add Coach'),
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.settings),
          label: const Text('Manage Coaches'),
        ),
      ],
    );
  }

  Widget _buildShowEntitiesDropdown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text('Show Entities:'),
        const SizedBox(width: 10),
        DropdownButton<int>(
          value: 10,
          items: [10, 25, 50, 100]
              .map((int value) => DropdownMenuItem<int>(
                    value: value,
                    child: Text('$value'),
                  ))
              .toList(),
          onChanged: (value) {
            // Handle dropdown change
          },
        ),
      ],
    );
  }

  Widget _buildCoachesTable() {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          color: const Color(0xFF332F4D),
          padding: const EdgeInsets.all(8.0),
          child: DataTable(
            headingRowColor: WidgetStateProperty.all(Colors.indigo[900]),
            dataRowColor: WidgetStateProperty.all(const Color(0xFF332F4D)),
            columnSpacing: 20.0,
            columns: const [
              DataColumn(
                label: Text('Name', style: TextStyle(color: Colors.white)),
              ),
              DataColumn(
                label: Text('Coach ID', style: TextStyle(color: Colors.white)),
              ),
              DataColumn(
                label: Text('Contact', style: TextStyle(color: Colors.white)),
              ),
              DataColumn(
                label: Text('Date Expiration',
                    style: TextStyle(color: Colors.white)),
              ),
              DataColumn(
                label: Text('Actions', style: TextStyle(color: Colors.white)),
              ),
            ],
            rows: coaches.asMap().entries.map((entry) {
              final index = entry.key;
              final coach = entry.value;
              return DataRow(
                cells: [
                  DataCell(Text(coach['name'],
                      style: const TextStyle(color: Colors.white))),
                  DataCell(Text(coach['coachId'],
                      style: const TextStyle(color: Colors.white))),
                  DataCell(Text(coach['contact'],
                      style: const TextStyle(color: Colors.white))),
                  DataCell(Text(coach['expiration'],
                      style: const TextStyle(color: Colors.white))),
                  DataCell(Row(
                    children: [
                      IconButton(
                          icon: const Icon(Icons.edit, color: Colors.amber),
                          onPressed: () {
                            // Implement edit functionality
                          }),
                    ],
                  )),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
