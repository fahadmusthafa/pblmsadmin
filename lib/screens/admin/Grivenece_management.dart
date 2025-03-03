import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pblmsadmin/models/admin_model.dart';
import 'package:pblmsadmin/provider/authprovider.dart';
import 'package:provider/provider.dart';

class AdminLeaveRequestScreen extends StatefulWidget {
  const AdminLeaveRequestScreen({super.key});

  @override
  _AdminLeaveRequestScreenState createState() => _AdminLeaveRequestScreenState();
}

class _AdminLeaveRequestScreenState extends State<AdminLeaveRequestScreen> {
  LeaveRequest? selectedLeave; // Holds the selected leave request

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<AdminAuthProvider>(context, listen: false).Adminfetchleaveprovider();
    });
  }

  @override
  Widget build(BuildContext context) {
    final leaveProvider = Provider.of<AdminAuthProvider>(context);
    final bugProvider = Provider.of<AdminAuthProvider>(context);
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Grievance Management"),
        backgroundColor: Colors.blue,
      ),
      body: isMobile
          ? Column(
              children: [
                Expanded(
                  flex: 3,
                  child: LeaveRequestList(
                    leaveProvider: leaveProvider,
                    onSelect: (leave) {
                      setState(() {
                        selectedLeave = leave;
                      });
                    },
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: selectedLeave == null
                      ? const Center(child: Text("Select a request to view details"))
                      : LeaveRequestDetails(
                          leave: selectedLeave!,
                          onUpdate: () {
                            setState(() {
                              selectedLeave = null; // Reset selection after update
                            });
                          },
                        ),
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  flex: 2,
                  child: LeaveRequestList(
                    leaveProvider: leaveProvider,
                    onSelect: (leave) {
                      setState(() {
                        selectedLeave = leave;
                      });
                    },
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: BugReportList(bugProvider: bugProvider),
                ),
                Expanded(
                  flex: 2,
                  child: selectedLeave == null
                      ? const Center(child: Text("Select a request to view details"))
                      : LeaveRequestDetails(
                          leave: selectedLeave!,
                          onUpdate: () {
                            setState(() {
                              selectedLeave = null;
                            });
                          },
                        ),
                ),
              ],
            ),
    );
  }
}

// Leave Request List
class LeaveRequestList extends StatelessWidget {
  final AdminAuthProvider leaveProvider;
  final Function(LeaveRequest) onSelect;

  const LeaveRequestList({required this.leaveProvider, required this.onSelect, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: leaveProvider.leave.length,
      itemBuilder: (context, index) {
        final leave = leaveProvider.leave[index];

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 3,
          child: ListTile(
            contentPadding: const EdgeInsets.all(10),
            title: Text(
              leave.student.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Email: ${leave.student.email}"),
                Text("Leave Date: ${DateFormat.yMMMd().format(leave.leaveDate)}"),
                Text("Reason: ${leave.reason}"),
                Text(
                  "Status: ${leave.status}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: leave.status == "pending"
                        ? Colors.orange
                        : leave.status == "approved"
                            ? Colors.green
                            : Colors.red,
                  ),
                ),
              ],
            ),
            trailing: leave.status == "pending"
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.check_circle, color: Colors.green),
                        onPressed: () async {
                          await leaveProvider.adminApproveleaveprovider(
                            leaveId: leave.leaveId,
                            status: "approved",
                          );
                          await leaveProvider.Adminfetchleaveprovider();
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.cancel, color: Colors.red),
                        onPressed: () async {
                          await leaveProvider.adminApproveleaveprovider(
                            leaveId: leave.leaveId,
                            status: "rejected",
                          );
                        },
                      ),
                    ],
                  )
                : null,
            onTap: () => onSelect(leave),
          ),
        );
      },
    );
  }
}

// Bug Report List
class BugReportList extends StatelessWidget {
  final AdminAuthProvider bugProvider;

  const BugReportList({required this.bugProvider, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: bugProvider.bug.length,
      itemBuilder: (context, index) {
        final bug = bugProvider.bug[index];

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 3,
          child: ListTile(
            contentPadding: const EdgeInsets.all(10),
            title: Text(
              bug.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Bug ID: ${bug.id}"),
                Text("Reported By (User ID): ${bug.userId}"),
                Text("Description: ${bug.description}"),
                Text(
                  "Status: ${bug.status}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: bug.status == "pending"
                        ? Colors.orange
                        : bug.status == "resolved"
                            ? Colors.green
                            : Colors.red,
                  ),
                ),
                Text("Reported On: ${DateFormat.yMMMd().format(bug.createdAt)}"),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Leave Request Details
class LeaveRequestDetails extends StatelessWidget {
  final LeaveRequest leave;
  final VoidCallback onUpdate;

  const LeaveRequestDetails({required this.leave, required this.onUpdate, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(left: BorderSide(color: Colors.grey.shade300, width: 1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Leave Request Details",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          Text("Student: ${leave.student.name}"),
          Text("Email: ${leave.student.email}"),
          Text("Leave Date: ${DateFormat.yMMMd().format(leave.leaveDate)}"),
          Text("Reason: ${leave.reason}"),
        ],
      ),
    );
  }
}
