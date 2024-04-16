import 'package:flutter/material.dart';
import 'package:project_1/constants.dart';
import 'dart:math';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key});
  static String id = 'welcome_screen';

  List<Job> generateRandomJob(int length) {
    List<Job> jobs = [];
    Random random = Random();
    for (int i = 0; i < length; i++) {
      String title = titles[random.nextInt(titles.length)];
      String company = companies[random.nextInt(companies.length)];
      String location = locations[random.nextInt(locations.length)];

      jobs.add(Job(
        title: title, 
        company: company, 
        location: location));
    }
    return jobs;
  }

  @override
  Widget build(BuildContext context) {
    List<Job> jobs = generateRandomJob(50);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Job List', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: jobs.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14), 
                        side: BorderSide(
                          color: Colors.grey.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: ListTile(
                            title: Text(
                              jobs[index].title,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Row( children: <Widget>[
                              Icon(Icons.location_city_outlined),
                              Text(' ${jobs[index].company} - ${jobs[index].location}'),
                              ],
                            ),
                            trailing: GestureDetector(
                              onTap: () {},
                              child: Icon(
                                Icons.keyboard_arrow_right_outlined
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
