import 'package:flutter/material.dart';
import 'package:project_1/components/components.dart';
import 'package:project_1/data/model/member_model.dart';
import 'package:project_1/data/services/member_service.dart';
import 'package:project_1/data/services/transaction_service.dart';
import 'package:project_1/screens/editMember.dart';
import 'package:project_1/screens/transaction.dart';
import 'package:project_1/utils/utils.dart';


class MemberProfileScreen extends StatefulWidget {
  final int id; 
  const MemberProfileScreen({ Key? key, required this.id }) : super(key: key);

  @override
  _MemberProfileScreenState createState() => _MemberProfileScreenState(id: id);
}

class _MemberProfileScreenState extends State<MemberProfileScreen> {
  final int id;
  _MemberProfileScreenState({required this.id});

  final MemberService memberService = MemberService();
  final TransactionService transactionService = TransactionService();
  Member? member;
  int? saldoData;

  Future<void> fetchData(id) async{
    try{
      Member? member = await memberService.fetchMember(context, id);
      setState(() {
        this.member =  member;
      });
    } catch (error){
      print(error);
    }
  }

  void deleteMember(BuildContext context, int id) async {
    try {
      await memberService.deleteMember(context, id);
    } catch (error) {
      print('Error deleting member: $error');
    }
  }
  
  Future<void> fetchDataSaldo(id) async {
    try {
      int? saldoData = await transactionService.fetchDataSaldo(context, id);
      setState(() {
        this.saldoData = saldoData;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState(){
    super.initState();
    fetchData(id);
    fetchDataSaldo(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text(
        'Profil Anggota',
        style: TextStyle(
          fontSize: 25, 
          fontWeight: FontWeight.w600
        ),
      ),
      centerTitle: true,
      toolbarHeight: 75,
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
           Navigator.pushReplacementNamed(context, '/landingPage');
          },
        ),
      ),
      body: SafeArea(
        child: member == null || saldoData == null
        ? Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)
          ))
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 35),
                    DisplayImage(
                      imagePath: "assets/images/default_profile.jpg", 
                      radius: 65,
                      onPressed: () {}
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Text(
                        member!.nama,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 27,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              FormatCurrency.convertToIdr(saldoData!, 2),
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(width: 20),
                            Icon(
                              member!.statusAktif == 2 ? Icons.warning_amber_rounded : Icons.check_circle,
                              color: member!.statusAktif == 2 ? Colors.red : Colors.green,
                            ),
                            SizedBox(width: 5),
                            Text(
                              mapMemberStatus(member!.statusAktif), 
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: member!.statusAktif == 2 ? Colors.red : Colors.green,
                              ),
                            ),              
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TransactionScreen(id: id),
                              ),
                            );
                          }, 
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            side: BorderSide(color: Colors.transparent), 
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            minimumSize: Size(88, 40),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.wallet, size: 20.0, color: Colors.white),
                            ],
                          ),
                        ),
                        SizedBox(width: 15),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditMemberScreen(id: id),
                              ),
                            );
                          }, 
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            side: BorderSide(color: Colors.transparent), 
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            minimumSize: Size(88, 40),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.edit, size: 20.0, color: Colors.white),
                            ],
                          ),
                        ),
                        SizedBox(width: 15),
                        ElevatedButton(
                          onPressed: () {
                             showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => 
                              AlertDialog(
                                alignment: Alignment.center,
                                title: Center(
                                  child: const Text(
                                    'Are you sure?',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                content: const Text(
                                  'You cannot restore this member',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                                backgroundColor: Colors.white,
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, 'No'),
                                    child: const Text(
                                      'No',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => deleteMember(context, id),
                                    child: const Text(
                                      'Yes',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }, 
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            side: BorderSide(color: Colors.transparent), 
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            minimumSize: Size(88, 40),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.delete, size: 20.0, color: Colors.white),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    UserProfileData(
                      title: 'Nomor Induk', 
                      value: member!.nomorInduk.toString()
                    ),
                    UserProfileData(
                      title: 'Alamat', 
                      value: member!.alamat
                    ),
                    UserProfileData(
                      title: 'Tanggal Lahir', 
                      value: member!.tglLahir.toString()
                    ),
                    UserProfileData(
                      title: 'Telepon', 
                      value: member!.telepon.toString()
                    ),
                  ],
                ),
              ),
            ),
        ),
      ),
    );
  }
}