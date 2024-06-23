import 'package:flutter/material.dart';
import 'package:project_1/data/model/member_model.dart';
import 'package:project_1/data/services/member_service.dart';
import 'package:project_1/screens/editMember.dart';
import 'package:project_1/screens/transaction.dart';
import 'package:project_1/utils/utils.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final MemberService memberService = MemberService();
  List<Member>? memberList;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      List<Member> members = await memberService.fetchMembers(context);
      setState(() {
        this.memberList = members;
      });
    } catch (error) {
      print('Error fetching members: $error');
    }
  }

  void deleteMember(BuildContext context, int id) async {
    try {
      await memberService.deleteMember(context, id);
      setState(() {
        memberList = memberList?.where((member) => member.id != id).toList();
      });
    } catch (error) {
      print('Error deleting member: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Text(
          'Anggota',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        toolbarHeight: 75,
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 10,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
          child: memberList != null
              ? ListView.builder(
                  itemCount: memberList!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                        side: BorderSide(
                          color: Colors.grey.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white),
                        child: ListTile(
                          minVerticalPadding: 13,
                          title: Text(
                            memberList![index].nama,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${memberList![index].telepon}',
                                style: TextStyle(color: Colors.grey),
                              ),
                              SizedBox(height: 5),
                              Text(
                                mapMemberStatus(memberList![index].statusAktif),
                                style: TextStyle(
                                  color: memberList![index].statusAktif == 1 ? Colors.green : Colors.red,
                                  fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                          subtitleTextStyle: TextStyle(color: Colors.grey[800]),
                          trailing: Wrap(
                            spacing: 10,
                            children: <Widget>[
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            TransactionScreen(
                                                id: memberList![index].id),
                                      ),
                                    );
                                  },
                                  child: Icon(Icons.payment_outlined)),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EditMemberScreen(
                                                id: memberList![index].id),
                                      ),
                                    );
                                  },
                                  child: Icon(Icons.edit)),
                              GestureDetector(
                                  onTap: () {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text('Are you sure?'),
                                        content: const Text('You cannot restore this member'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(context, 'No'),
                                            child: const Text('No'),
                                          ),
                                          TextButton(
                                            onPressed: () => deleteMember(context, memberList![index].id),
                                            child: const Text('Yes'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: Icon(Icons.delete)),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 17.0, 17.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/addMember');
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.lightBlue,
          foregroundColor: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
