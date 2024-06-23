import 'package:flutter/material.dart';
import 'package:project_1/components/components.dart';
import 'package:project_1/data/model/member_model.dart';
import 'package:project_1/data/services/member_service.dart';
import 'package:project_1/utils/utils.dart';

class EditMemberScreen extends StatefulWidget {
  final int id;
  EditMemberScreen({Key? key, required this.id}) : super(key: key);

  @override
  _EditMemberScreenState createState() => _EditMemberScreenState(id: id);
}

class _EditMemberScreenState extends State{
  final int id;
  _EditMemberScreenState({required this.id});
  Member? member;

  final TextEditingController nomorIndukController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController tglLahirController = TextEditingController();
  final TextEditingController teleponController = TextEditingController();
  final MemberService memberService = MemberService();

  String dropDownValue = '1';
  var items = {
    '1' : 'Aktif',
    '2' : 'Tidak Aktif',
  };

  Future<void> fetchData(id) async {
    try {
      Member? member = await memberService.fetchMember(context, id);
      setState(() {
        this.member = member;
      });
    } catch (error) {
      print('Error fetching members: $error');
    }
  }

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
    fetchData(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Member',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        toolbarHeight: 75,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: member == null
          ? Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          )
          : SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 15),
                    FieldHeader(text: 'Nomor Induk'),
                    CustomInputField(
                      hintText: member!.nomorInduk.toString(), 
                      controller: nomorIndukController,
                    ),
                    SizedBox(height: 15),
                    FieldHeader(text: 'Nama'),
                    CustomInputField(
                      hintText: member!.nama.toString(), 
                      controller: namaController,
                    ),
                    SizedBox(height: 15),
                    FieldHeader(text: 'Alamat'),
                    CustomInputField(
                      hintText: member!.alamat.toString(), 
                      controller: alamatController,
                    ),
                    SizedBox(height: 15),
                    FieldHeader(text: 'Tanggal Lahir'),
                    CustomInputField(
                      hintText: member!.tglLahir.toString(),
                      controller: tglLahirController,
                      readOnly: true,
                      prefixIcon: Icon(Icons.calendar_today),
                      onTap: ()=>_selectDate(context),
                    ),
                    SizedBox(height: 15),
                    FieldHeader(text: 'Telepon'),
                    CustomInputField(
                      hintText: member!.telepon.toString(), 
                      controller: teleponController,
                    ),
                    SizedBox(height: 15),
                    FieldHeader(text: 'Status'),
                    CustomDropdown(
                      value: member!.statusAktif.toString(), 
                      items: items, 
                      onChanged: (String? newValue) {
                        setState(() {
                          dropDownValue = newValue!;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    CustomButton(
                      text: 'Edit Member', 
                      backgroundColor: Colors.blue, 
                      textColor: Colors.white, 
                      onPressed: (){
                        memberService.editMember(
                          context, 
                          id, 
                          {
                            "nomor_induk": nomorIndukController.text.isNotEmpty ? nomorIndukController.text : member!.nomorInduk,
                            "nama": namaController.text.isNotEmpty ? namaController.text : member!.nama,
                            "alamat": alamatController.text.isNotEmpty ? alamatController.text : member!.alamat,
                            "tgl_lahir": tglLahirController.text.isNotEmpty ? tglLahirController.text : member!.tglLahir,
                            "telepon": teleponController.text.isNotEmpty ? teleponController.text : member!.telepon,
                            "status_aktif": dropDownValue,
                          },
                        );
                      }
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
  }
}
