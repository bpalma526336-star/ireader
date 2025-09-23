import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ireader_web/model/schoolyear.dart';
import 'package:ireader_web/theme.dart';
import 'package:ireader_web/views/admin/admindashboard.dart';
import 'package:ireader_web/views/admin/practice_set/manage_practice_set.dart';

class ManageSchoolyear extends StatefulWidget {
  const ManageSchoolyear({super.key});

  @override
  State<ManageSchoolyear> createState() => _ManageSchoolyearState();
}

class _ManageSchoolyearState extends State<ManageSchoolyear> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> fetchPracticeSet() {
    Query query = _firestore.collection("schoolyear");

    return query.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _showSchoolYearDialog({SchoolYear? schoolYear}) async {
      final TextEditingController _controller = TextEditingController(
        text: schoolYear?.schoolyear ?? "",
      );

      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              schoolYear == null ? "Add School Year" : "Edit School Year",
            ),
            content: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "School Year (e.g., 2024-2025)",
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () async {
                  final input = _controller.text.trim();
                  if (input.isNotEmpty) {
                    if (schoolYear == null) {
                      // ✅ Add new
                      await _firestore.collection("schoolyear").add({
                        "schoolyear": input,
                      });
                    } else {
                      // ✅ Update existing
                      await _firestore
                          .collection("schoolyear")
                          .doc(schoolYear.id)
                          .update({"schoolyear": input});
                    }
                    Navigator.pop(context);
                  }
                },
                child: const Text("Save"),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        title: Text(
          "Manage School Year",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add_circle_outline,
              color: AppTheme.primaryColor,
            ),
            onPressed: () {
              _showSchoolYearDialog();
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: AppTheme.backgroundColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Image.asset(
                      'assets/Department-of-Education-DepEd-Seal-300x300.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'iReader',
                    style: TextStyle(
                      fontSize: 20,
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Admin',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppTheme.textPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.dashboard_customize_outlined,
                color: AppTheme.textPrimaryColor,
              ),
              title: const Text(
                'Admin Dashboard',
                style: TextStyle(
                  fontSize: 20,
                  color: AppTheme.textPrimaryColor,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AdminDashboard(),
                  ),
                );
              },
            ),
            SizedBox(height: 12),
            ListTile(
              leading: const Icon(Icons.book, color: AppTheme.textPrimaryColor),
              title: const Text(
                'Practice Set',
                style: TextStyle(
                  fontSize: 20,
                  color: AppTheme.textPrimaryColor,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ManagePracticeSet(),
                  ),
                );
              },
            ),
            SizedBox(height: 12),
            ListTile(
              leading: const Icon(
                Icons.calendar_month_outlined,
                color: AppTheme.primaryColor,
              ),
              title: const Text(
                'School Year',
                style: TextStyle(fontSize: 20, color: AppTheme.primaryColor),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ManageSchoolyear(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection("schoolyear")
            .orderBy('schoolyear')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error: "));
          }

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(color: AppTheme.primaryColor),
            );
          }

          final schoolyears = snapshot.data!.docs
              .map(
                (doc) => SchoolYear.fromMap(
                  doc.id,
                  doc.data() as Map<String, dynamic>,
                ),
              )
              .toList();

          if (schoolyears.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.category_outlined,
                    size: 64,
                    color: AppTheme.textSecondaryColor,
                  ),
                  SizedBox(height: 16),
                  Text(
                    "No School Year Yet",
                    style: TextStyle(
                      color: AppTheme.textSecondaryColor,
                      fontSize: 18,
                    ),
                  ),
                  // ElevatedButton(
                  //   // onPressed: () {
                  //   //   Navigator.push(
                  //   //     context,
                  //   //     MaterialPageRoute(
                  //   //       builder: (context) => AddCategoryScreen(),
                  //   //     ),
                  //   //   );
                  //   // },
                  //   child: Text("Add Category"),
                  // ),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: schoolyears.length,
            itemBuilder: (context, index) {
              final SchoolYear schoolyear = schoolyears[index];
              return Card(
                margin: EdgeInsets.only(bottom: 12),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),
                  leading: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.calendar_month_outlined,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  title: Text(
                    "School Year: ${schoolyear.schoolyear}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  trailing: PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: "edit",
                        child: ListTile(
                          leading: Icon(
                            Icons.edit,
                            color: AppTheme.primaryColor,
                          ),
                          title: Text("Edit"),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                      PopupMenuItem(
                        value: "delete",
                        child: ListTile(
                          leading: Icon(Icons.delete, color: Colors.redAccent),
                          title: Text("Delete"),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                    onSelected: (value) {
                      if (value == "edit") {
                        _showSchoolYearDialog(schoolYear: schoolyear);
                      } else if (value == "delete") {
                        _firestore
                            .collection("schoolyear")
                            .doc(schoolyear.id)
                            .delete();
                      }
                    },
                  ),
                  // onTap: () {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => ManageQuizesScreen(
                  //         categoryId: category.id,
                  //         categoryName: category.name,
                  //       ),
                  //     ),
                  //   );
                  // },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
