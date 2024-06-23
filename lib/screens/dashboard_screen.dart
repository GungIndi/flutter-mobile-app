import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_1/components/components.dart';
import 'package:project_1/data/model/member_model.dart';
import 'package:project_1/screens/editMember.dart';
import 'package:project_1/screens/transaction.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final apiUrl = 'https://mobileapis.manpits.xyz/api';
  final dio = Dio();
  final storage = GetStorage();
  List<Member>? memberList;

  String mapMemberStatus(int trxId) {
    switch (trxId) {
      case 1:
        return 'Aktif';
      case 2:
        return 'Tidak Aktif';
      default:
        return 'Unknown';
    }
  }

  Future<void> fetchData() async {
    try {
      Response response = await dio.get(
        "$apiUrl/anggota",
        options: Options(
          headers: {'Authorization': 'Bearer ${storage.read('token')}'},
        ),
      );
      print('Response: $response');
      if (response.data['success'] == true) {
        MemberData memberList = MemberData.fromJson(response.data);
        print('object : ${memberList.data[1]}');
        setState(() {
          this.memberList = memberList.data;
        });
      }
    } on DioException catch (error) {
      print('Error occurred: ${error.response}');
      String errorMessage = error.response!.data['message'];
      if (error.response!.data['message'] != null &&
          error.response!.data['message'].contains('Token is Expired')) {
        errorMessage = 'Your Session is Over';
      }
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('${errorMessage}'),
          content: Text('Please Login'),
          actions: <Widget>[
            TextButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/login'),
                child: Text('Ok'))
          ],
        ),
      );
    }
  }

  void deleteAnggota(context, int id) async {
    final dio = Dio();
    final apiUrl = 'https://mobileapis.manpits.xyz/api';
    final storage = GetStorage();

    try {
      final response = await dio.delete(
        "$apiUrl/anggota/$id",
        options: Options(
          headers: {'Authorization': 'Bearer ${storage.read('token')}'},
        ),
      );
      print(response.data);
      if (response.data['success'] == true) {
        setState(() {
          memberList = memberList?.where((member) => member.id != id).toList();
        });
        Navigator.pop(context);
        showCustomSnackBar(
          context,
          'Member successfully deleted',
          backgroundColor: Colors.green,
        );
      }
    } on DioException catch (error) {
      print('Error occurred: ${error.response}');
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to delete member'),
          actions: <Widget>[
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Ok')),
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
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
                                mapMemberStatus(
                                    memberList![index].statusAktif),
                                style: TextStyle(
                                    color: memberList![index].statusAktif == 1
                                        ? Colors.green
                                        : Colors.red,
                                    fontWeight: FontWeight.bold
                                  ),
                              )
                            ],
                          ),
                          subtitleTextStyle:
                              TextStyle(color: Colors.grey[800]),
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
                                        content: const Text(
                                            'You cannot restore this member'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'No'),
                                            child: const Text('No'),
                                          ),
                                          TextButton(
                                            onPressed: () => deleteAnggota(
                                                context, memberList![index].id),
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

void logout(context) async {
  final dio = Dio();
  final apiUrl = 'https://mobileapis.manpits.xyz/api';
  final storage = GetStorage();
  try {
    final response = await dio.get("$apiUrl/logout",
        options: Options(
            headers: {'Authorization': 'Bearer ${storage.read('token')}'}));
    print(response.data);
    storage.remove('token');

    if (response.data['success'] == true) {
      Navigator.pushNamed(context, '/login');
    }
  } on DioException catch (e) {
    print(e.response);
  }
}
