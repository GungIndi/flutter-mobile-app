import 'package:flutter/material.dart';
import 'package:project_1/components/components.dart';
import 'package:project_1/data/services/member_service.dart';
import 'package:project_1/utils/utils.dart';

class AddMemberScreen extends StatefulWidget {
  AddMemberScreen({Key? key}) : super(key: key);

  @override
  _AddMemberScreenState createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State{
  final TextEditingController nomorIndukController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController tglLahirController = TextEditingController();
  final TextEditingController teleponController = TextEditingController();
  final MemberService memberService = MemberService();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = await selectDate(context);
    if (selectedDate != null) {
      setState(() {
        tglLahirController.text = selectedDate.toString().split(" ")[0];
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Member',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        toolbarHeight: 75,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                CustomInputField(
                  labelText: 'Masukan Nomor Induk', 
                  controller: nomorIndukController,
                ),
                SizedBox(height: 20),
                CustomInputField(
                  labelText: 'Masukan Nama', 
                  controller: namaController,
                ),
                SizedBox(height: 20),
                CustomInputField(
                  labelText: 'Masukan Alamat', 
                  controller: alamatController,
                ),
                SizedBox(height: 20),
                CustomInputField(
                  labelText: 'Masukan Tanggal Lahir', 
                  controller: tglLahirController,
                  readOnly: true,
                  prefixIcon: Icon(Icons.calendar_today),
                  onTap: ()=>_selectDate(context),
                ),
                SizedBox(height: 20),
                CustomInputField(
                  labelText: 'Masukan Nomor Telepon', 
                  controller: teleponController,
                ),
                SizedBox(height: 20),
                CustomButton(
                  text: 'Add Member', 
                  backgroundColor: Colors.blue, 
                  textColor: Colors.white, 
                  onPressed: (){
                    memberService.addMember(context, nomorIndukController, namaController, alamatController, tglLahirController,teleponController);
                  }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
