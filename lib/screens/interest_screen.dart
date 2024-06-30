import 'package:flutter/material.dart';
import 'package:project_1/components/addInterestModal.dart';
import 'package:project_1/data/services/interest_service.dart';

class InterestScreen extends StatefulWidget {
  const InterestScreen({ Key? key }) : super(key: key);

  @override
  _InterestScreenState createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {

  final InterestService interestService = InterestService();
  dynamic interestData;
  Map<String,dynamic>? activeBunga;
  List<dynamic>? bungas;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      dynamic interest = await interestService.fetchInterest(context);
      setState(() {
        interestData = interest;
        activeBunga = interest['activebunga'];
        bungas = interest['settingbungas'];
      });
    } catch (error) {
      print('Error: $error'); 
    }
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AddInterestModal(
          onInterestAdded: () {
            fetchData();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Bunga Aktif',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        toolbarHeight: 75,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: interestData == null
            ? Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        )
            : SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${activeBunga!['persen']}',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 40,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            '%',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 32,
                                fontWeight: FontWeight.bold
                            ),
                         ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Histori',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: bungas!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Container(
                          decoration: BoxDecoration(color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: ListTile(
                              leading: Icon(Icons.attach_money),
                              title: Row(
                                children: [
                                  Text(
                                    '${bungas![index]['persen']}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '%',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              trailing: Wrap(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: bungas![index]['isaktif'] == 0 ? Colors.red : Colors.green,
                                    size: 15,
                                  ),
                                  Text(
                                    ' ${bungas![index]['isaktif'] == 0 ? 'Tidak Aktif' : 'Aktif' }',
                                    style: TextStyle(
                                        color: bungas![index]['isaktif'] == 0 ? Colors.red[400] : Colors.green[400],
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600
                                    )
                                  ),
                                ]
                              )   
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              )
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 17.0, 17.0),
        child: FloatingActionButton(
          foregroundColor: Colors.white,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          onPressed: () {
            _showModalBottomSheet(context);
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.blue[400],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}