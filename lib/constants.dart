import 'package:flutter/cupertino.dart';

Color whiteColor = Color(0xffffffff);
Color textColor = Color(0xD2D2D2);
Color secondaryTextColor = Color(0x808080);
Color primaryButtonColor = Color(0x218bf5);
Color primaryButtonTextColor = Color(0xffe6e1ff);
Color secondaryButtonColor = Color(0x218bf5);
Color secondaryButtonTextColor = Color(0xffe6e1ff);
Color inputField = Color(0xfff1f1f5);

class Job {
  final String title;
  final String company;
  final String location;


  Job({
    required this.title,
    required this.company,
    required this.location,
  });
}

List<String> titles = [
  'Software Engineer',
  'Data Analyst',
  'Network Administrator',
  'IT Support Specialist',
  'UI/UX Designer',
  'Database Administrator',
  'Cybersecurity Analyst',
  'Cloud Engineer',
  'Mobile App Developer',
  'Web Developer',
];
List<String> companies = [
  'Gojek',
  'Tokopedia',
  'Traveloka',
  'Bukalapak',
  'Shopee',
  'Grab',
  'Lazada',
  'OVO',
  'Pegipegi',
  'Zalora',
];
List<String> locations = [
  'Jakarta',
  'Bandung',
  'Surabaya',
  'Semarang',
  'Medan',
  'Yogyakarta',
  'Palembang',
  'Makassar',
  'Malang',
  'Denpasar',
];