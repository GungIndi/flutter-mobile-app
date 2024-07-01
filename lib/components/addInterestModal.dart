import 'package:flutter/material.dart';
import 'package:project_1/components/components.dart';
import 'package:project_1/data/services/interest_service.dart';

class AddInterestModal extends StatefulWidget {
  final Function onInterestAdded;

  AddInterestModal({required this.onInterestAdded});

  @override
  _AddInterestModalState createState() => _AddInterestModalState();

  static void addInterest(BuildContext context) {}
}

class _AddInterestModalState extends State<AddInterestModal> {
  final InterestService interestService = InterestService();
  final TextEditingController persenController = TextEditingController();

  Future<void> addInterest() async {
    try {
      await interestService.addInterest(context, persenController.text);
      widget.onInterestAdded();
    } catch (error) {
      print('Error fetching transaction: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: CustomModalBottomSheet(
          height: 300,
          content: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Tambah Bunga',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Persen Bunga',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            CustomInputField(
              hintText: 'Masukan Persenan Bunga',
              controller: persenController,
            ),
            SizedBox(height: 25),
            CustomButton(
              text: 'Tambah',
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              onPressed: () {
                addInterest();
              }
            )
          ],
        ),
      ),
    );
  }
}