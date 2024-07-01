import 'package:flutter/material.dart';
import 'package:project_1/data/model/member_model.dart';
import 'package:project_1/data/services/member_service.dart';
import 'package:project_1/data/services/transaction_service.dart';
import 'package:project_1/screens/memberProfileScreen.dart';
import 'package:project_1/utils/utils.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final MemberService memberService = MemberService();
  final TransactionService transactionService = TransactionService();
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
          child: memberList == null ? 
              Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              )
              : memberList!.length != 0 ? ListView.builder(
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
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MemberProfileScreen(id: memberList![index].id),
                            ),
                          );
                        },
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
                              ],
                            ),
                            subtitleTextStyle: TextStyle(color: Colors.grey[800]),
                            trailing: Wrap(
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: memberList![index].statusAktif == 1 ? Colors.green : Colors.red,
                                  size: 15,
                                ),
                                Text(
                                  ' ${mapMemberStatus(memberList![index].statusAktif)}',
                                  style: TextStyle(
                                    color: memberList![index].statusAktif == 1 ? Colors.green: Colors.red,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ]
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
                : Container(
                  width: 400,
                  height: 600,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Icon(Icons.search, size: 300, color: Colors.blue[300])
                      ),
                      Text(
                        'Tidak ada anggota',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Silahkan tambah anggota baru.',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
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
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
