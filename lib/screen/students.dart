import 'package:attendants/constants/color.dart';
import 'package:attendants/constants/functions.dart';
import 'package:attendants/constants/wigets.dart';
import 'package:attendants/main.dart';
import 'package:attendants/object/classes.dart';
import 'package:attendants/object/stu.dart';
import 'package:attendants/service/classHelper.dart';
import 'package:attendants/service/stuHelper.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gsheets/gsheets.dart';
import 'package:iconly/iconly.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:url_launcher/url_launcher.dart';

const String sheetid = '1w_ZasV4rBWANzWYl0SaJkVF9R52r6RGn6J2tvbVVN5k';

Worksheet? detailsheet;

class _StudentState extends State<Student> {
  late Classes classs;

  Future<List<Stu>> getstulist(String sheettitle) async {
    GSheets gsheets = GSheets(credential);
    Spreadsheet spreedsheet = await gsheets.spreadsheet(sheetid);
    detailsheet = spreedsheet.worksheetByTitle(sheettitle);
    final values = (await detailsheet!.values.allRows()).skip(1).toList();
    List<Stu> list = values.map((map) {
      String stno = '', prno = '', stuna = '', regn = '', sprn = '';
      try {
        sprn = map[1];
        regn = map[2];
        stuna = map[3];
        stno = map[4];
        prno = map[6];
      } catch (e) {}
      return Stu(
        id: 'llk',
        clid: '', //classs.id!,
        name: stuna,
        regno: regn,
        sprno: sprn,
        smob: stno,
        pmob: prno, time: 'ljh',
      );
    }).toList();

    return list;
  }

  Future<List<Worksheet>> getsheets() async {
    GSheets gsheets = GSheets(credential);
    Spreadsheet spreedsheet = await gsheets.spreadsheet(sheetid);
    List<Worksheet> sheets = await spreedsheet.sheets;
    List<String> sheetname = [];
    for (var element in sheets) {
      sheetname.add(element.title);
    }
    return sheets;
  }

  ClassHelper classHelper = ClassHelper();

  late StuHelper stuHelper;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    classs = widget.classs;
    stuHelper = StuHelper(cid: classs.id!);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, '/class');
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          routename(context, '/class');
                        },
                        icon: const Icon(IconlyBold.arrow_left_2),
                      ),
                      Text(
                        '${classs.dep} - ${yearl[classs.year]} (${classs.sec})',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                ClassHelper.setfocus(classs);
                              });
                            },
                            icon: FutureBuilder(
                                future: ClassHelper.getfocus(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Icon(
                                      Icons.center_focus_strong,
                                      color: snapshot.data == classs.id
                                          ? Colors.red
                                          : Colors.black54,
                                    );
                                  }
                                  return const SizedBox();
                                }),
                          ),
                          option(),
                        ],
                      )
                    ],
                  ),
                  ListTile(
                    onTap: () {
                      launchUrl(Uri.parse(
                          'https://docs.google.com/spreadsheets/d/${classs.id}/edit#gid=1676750713'));
                      msg('Opening Sheet for viewing');
                    },
                    title: Text(
                      'SpreadSheet Id',
                      style: TextStyle(fontSize: 10.sp),
                    ),
                    subtitle: SelectableText(
                      classs.id!,
                      style: TextStyle(
                          fontSize: 7.sp, color: Colors.amber.shade700),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        FlutterClipboard.copy(
                            'https://docs.google.com/spreadsheets/d/${classs.id}/');
                        msg('Link Copied');
                      },
                      icon: const Icon(
                        Icons.copy,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    StreamBuilder<List<Stu>>(
                        stream: stuHelper.getClasstu(),
                        builder: (context, AsyncSnapshot<List<Stu>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.active) {
                            List<Stu> stulist = [];
                            snapshot.data!.forEach((element) {
                              if (element.clid == classs.id) {
                                stulist.add(element);
                              }
                            });
                            return ListView(
                              physics: const BouncingScrollPhysics(),
                              children: [
                                stulist.isNotEmpty
                                    ? ListView.builder(
                                        padding: const EdgeInsets.only(
                                            top: 20, bottom: 100),
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: stulist.length,
                                        itemBuilder: (context, index) {
                                          Stu student =
                                              stulist.elementAt(index);
                                          return Card(
                                              elevation: 5,
                                              shadowColor: Colors.grey,
                                              margin: const EdgeInsets.fromLTRB(
                                                  20, 10, 20, 5),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                child: Row(
                                                  children: [
                                                    wspace(10),
                                                    Expanded(
                                                      flex: 7,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            student.name
                                                                .toUpperCase(),
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900),
                                                          ),
                                                          Text.rich(
                                                            TextSpan(
                                                              style: GoogleFonts
                                                                  .rubik(
                                                                      color: Colors
                                                                          .black),
                                                              children: [
                                                                const TextSpan(
                                                                    text:
                                                                        ' | Spr no: '),
                                                                TextSpan(
                                                                    text: student
                                                                        .sprno,
                                                                    style: const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                                const TextSpan(
                                                                    text:
                                                                        '\n | ',
                                                                    style:
                                                                        TextStyle()),
                                                                const TextSpan(
                                                                    text:
                                                                        'Reg no: '),
                                                                TextSpan(
                                                                    text: student
                                                                        .regno,
                                                                    style: const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: IconButton(
                                                              icon: Icon(
                                                                IconlyBold.call,
                                                                color: cr_green
                                                                    .withOpacity(
                                                                        .5),
                                                              ),
                                                              onPressed: () {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder: (context) => call(
                                                                        student
                                                                            .smob,
                                                                        student
                                                                            .pmob));
                                                              },
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: IconButton(
                                                              icon: Icon(
                                                                IconlyBold
                                                                    .delete,
                                                                color: cr_red,
                                                              ),
                                                              onPressed: () {
                                                                setState(() {
                                                                  stuHelper.delete(
                                                                      student);
                                                                  stulist
                                                                      .removeAt(
                                                                          index);
                                                                  msg('${student.name} deleted');
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ));
                                        })
                                    : SizedBox(
                                        height: size.height - 100,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Text.rich(TextSpan(
                                                style: TextStyle(
                                                    color: Colors.grey),
                                                children: [
                                                  const TextSpan(
                                                      text: 'YOU has no'),
                                                  const TextSpan(
                                                      text: ' student',
                                                      style: TextStyle(
                                                          fontSize: 20)),
                                                ])),
                                            hspace(50),
                                            const Center(
                                                child: Icon(
                                              FontAwesomeIcons.boxOpen,
                                              color: Colors.grey,
                                              size: 100,
                                            )),
                                          ],
                                        ),
                                      ),
                              ],
                            );
                          }
                          if (snapshot.hasError) {
                            return Errored(error: snapshot.error.toString());
                          }
                          return const Loading();
                        }),
                    Positioned(
                      bottom: 30,
                      right: 25,
                      left: 25,
                      child: SizedBox(
                        width: size.width - 50,
                        height: 70,
                        child: InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => singlestu());
                          },
                          child: Card(
                            color: Colors.amber.shade400.withOpacity(1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            elevation: 20,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Spacer(),
                                const Icon(
                                  CupertinoIcons.add,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                wspace(10),
                                Text(
                                  'Add student'.toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                                const Spacer(),
                                CircleAvatar(
                                  backgroundColor: CupertinoColors.white,
                                  child: IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => sheetstu());
                                      },
                                      icon: const Icon(
                                        CupertinoIcons.arrow_down_doc,
                                        color: Colors.green,
                                      )),
                                ),
                                wspace(10),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Dialog call(String stuno, String prno) {
    final Size size = MediaQuery.of(context).size;
    return Dialog(
      elevation: 200,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      //insetPadding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        height: 250,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          children: [
            Text(
              'call to'.toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                fontSize: 20,
              ),
            ),
            const Spacer(),
            ListTile(
              onTap: () async {
                launch("tel://$stuno");
              },
              title: const Text(
                'Student number',
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(stuno),
              trailing: const Icon(
                Icons.call,
                color: Colors.lightGreen,
              ),
            ),
            const Spacer(),
            ListTile(
              onTap: () async {
                launch("tel://$prno");
              },
              title: const Text(
                'Parent number',
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(prno),
              trailing: const Icon(
                Icons.call,
                color: Colors.lightGreen,
              ),
            )
          ],
        ),
      ),
    );
  }

  Dialog singlestu() {
    TextEditingController stucon = TextEditingController(),
        regcon = TextEditingController(),
        sprcon = TextEditingController(),
        stunocon = TextEditingController(),
        prcon = TextEditingController();
    return Dialog(
      elevation: 200,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(text: 'Student details'),
                      ],
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: TextField(
                  controller: stucon,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Icon(
                        CupertinoIcons.profile_circled,
                        color: Colors.blue,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                          color: Colors.blue.withOpacity(0.5), width: 1.5),
                      gapPadding: 10,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                          color: Colors.blue.withOpacity(0.5), width: 1.5),
                      gapPadding: 10,
                    ),
                    hintText: 'Name',
                    labelText: 'Student Name'.toUpperCase(),
                  ),
                  style: TextStyle(
                    color: Colors.blue.withOpacity(0.8),
                  ),
                  keyboardType: TextInputType.name,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: TextField(
                  controller: regcon,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Icon(
                        CupertinoIcons.person,
                        color: Colors.blue,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                          color: Colors.blue.withOpacity(0.5), width: 1.5),
                      gapPadding: 10,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                          color: Colors.blue.withOpacity(0.5), width: 1.5),
                      gapPadding: 10,
                    ),
                    hintText: 'Number',
                    labelText: 'reg no'.toUpperCase(),
                  ),
                  style: TextStyle(
                    color: Colors.blue.withOpacity(0.8),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: TextField(
                  controller: sprcon,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Icon(
                        CupertinoIcons.person_alt,
                        color: Colors.blue,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                          color: Colors.blue.withOpacity(0.5), width: 1.5),
                      gapPadding: 10,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                          color: Colors.blue.withOpacity(0.5), width: 1.5),
                      gapPadding: 10,
                    ),
                    hintText: 'Number',
                    labelText: 'spr no'.toUpperCase(),
                  ),
                  style: TextStyle(
                    color: Colors.blue.withOpacity(0.8),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: TextField(
                  onTap: () async {
                    final PhoneContact contact =
                        await FlutterContactPicker.pickPhoneContact();
                    String numb = contact.phoneNumber!.number ?? '0';
                    if (!numb.startsWith('+91')) numb = '+91 $numb';
                    setState(() {
                      stunocon.text = numb;
                    });
                  },
                  controller: stunocon,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Icon(
                        CupertinoIcons.person,
                        color: Colors.blue,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                          color: Colors.blue.withOpacity(0.5), width: 1.5),
                      gapPadding: 10,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                          color: Colors.blue.withOpacity(0.5), width: 1.5),
                      gapPadding: 10,
                    ),
                    hintText: 'phonenumber',
                    labelText: 'student no'.toUpperCase(),
                  ),
                  style: TextStyle(
                    color: Colors.blue.withOpacity(0.8),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: TextField(
                  onTap: () async {
                    final PhoneContact contact =
                        await FlutterContactPicker.pickPhoneContact();
                    String numb = contact.phoneNumber!.number ?? '0';
                    if (!numb.startsWith('+91')) numb = '+91 $numb';
                    setState(() {
                      prcon.text = numb;
                    });
                  },
                  controller: prcon,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Icon(
                        CupertinoIcons.person,
                        color: Colors.blue,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                          color: Colors.blue.withOpacity(0.5), width: 1.5),
                      gapPadding: 10,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                          color: Colors.blue.withOpacity(0.5), width: 1.5),
                      gapPadding: 10,
                    ),
                    hintText: 'phonenumber',
                    labelText: 'parent no'.toUpperCase(),
                  ),
                  style: TextStyle(
                    color: Colors.blue.withOpacity(0.8),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              hspace(20),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Row(
                  children: [
                    const Spacer(),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: InkWell(
                        onTap: () {
                          if (stucon.text != '' &&
                              regcon.text != '' &&
                              sprcon.text != '') {
                            /*Stu newstu = Stu(
                              clid: classs.id!,
                              stuname: stucon.text,
                              regno: regcon.text,
                              sprno: sprcon.text,
                              stuno: stunocon.text,
                              prano: prcon.text,
                            );
                            studata.instance.add(newstu);
                            setState(() {
                              stulist.add(newstu);
                              stucon.text = '';
                              sprcon.text = '';
                              regcon.text = '';
                              stunocon.text = '';
                              prcon.text = '';
                            });*/
                            Navigator.pop(context);
                          } else {
                            msg('Enter details');
                          }
                        },
                        child: Container(
                          width: 100,
                          height: 50,
                          color: const Color(0xff6b9fed),
                          child: const Center(
                              child: Text(
                            'save',
                            style: TextStyle(
                                color: CupertinoColors.white,
                                fontSize: 15,
                                letterSpacing: 2),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Dialog sheetstu() {
    return Dialog(
      elevation: 200,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: FutureBuilder(
        future: getsheets(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasError) {
            if (snapshot.connectionState != ConnectionState.waiting) {
              if (snapshot.hasData) {
                List<Worksheet> sheets = snapshot.data ?? [];
                return ListView.builder(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: sheets.length,
                  itemBuilder: (context, index) {
                    Worksheet sheet = sheets[index];
                    return Container(
                      height: 100,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => gshudia(
                                      getshulist: getstulist(sheet.title),
                                      classs: classs,
                                    ));
                          },
                          child: Row(
                            children: [
                              wspace(10.w),
                              Text(
                                sheet.title,
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16.sp),
                              ),
                              wspace(10.w),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text(' has no data'),
                );
              }
            } else {
              return Center(
                child: JumpingDotsProgressIndicator(
                  color: Colors.blueAccent,
                  fontSize: 100,
                ),
              );
            }
          } else {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: TextStyle(color: Colors.redAccent.withOpacity(0.5)),
              ),
            );
          }
        },
      ),
    );
  }
}

class _gshudiaState extends State<gshudia> {
  late Future<List<Stu>> getshulist;
  late Classes classs;
  late StuHelper stuHelper;

  @override
  Widget build(BuildContext context) {
    getshulist = widget.getshulist;
    classs = widget.classs;
    stuHelper = StuHelper(cid: classs.id!);
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Student(classs: classs)));
        return true;
      },
      child: Dialog(
        elevation: 100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        insetPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
        child: StreamBuilder<List<Stu>>(
            stream: stuHelper.getClasstu(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Stu> stulist = [];
                for (var element in snapshot.data!) {
                  if (element.id == classs.id) {
                    stulist.add(element);
                  }
                }
                return FutureBuilder(
                    future: getshulist,
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return Wrap(children: [
                          Text('==================\n' +
                              snapshot.error.toString() +
                              '\n==============')
                        ]);
                      }
                      if (snapshot.hasData) {
                        List<Stu> data = snapshot.data;
                        List<Stu> sheetstu = [];
                        for (var eld in data) {
                          bool addb = true;
                          for (var els in stulist) {
                            if (els.name == eld.name &&
                                els.regno == eld.regno) {
                              addb = false;
                            }
                          }
                          if (addb) sheetstu.add(eld);
                        }

                        return Column(
                          children: [
                            Container(
                              height: 50,
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: const Text.rich(TextSpan(
                                  style: TextStyle(
                                    letterSpacing: 2,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'List of ',
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    TextSpan(
                                        text: ' students ',
                                        style: TextStyle(
                                          fontSize: 25,
                                        ))
                                  ])),
                            ),
                            const Divider(
                              height: 10,
                              thickness: 0.8,
                              color: Colors.black54,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    wspace(15),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'name'.toUpperCase(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ),
                                    wspace(10),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'reg no'.toUpperCase(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ),
                                    wspace(10),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        'spr no'.toUpperCase(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ),
                                    wspace(10),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        'save'.toUpperCase(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ),
                                    wspace(15),
                                  ],
                                ),
                                const Divider(
                                  height: 5,
                                  thickness: 0.5,
                                  color: Colors.brown,
                                  indent: 10,
                                  endIndent: 10,
                                ),
                              ],
                            ),
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: sheetstu.length,
                                padding: const EdgeInsets.only(bottom: 20),
                                itemBuilder: (context, index) {
                                  Stu mystu = sheetstu.elementAt(index);
                                  mystu.clid = classs.id!;
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          wspace(15),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              mystu.name,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ),
                                          wspace(10),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              mystu.regno,
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ),
                                          wspace(10),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              mystu.sprno,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: IconButton(
                                              hoverColor: Colors.lightGreen,
                                              splashColor: Colors.lightGreen,
                                              highlightColor: Colors.lightGreen,
                                              focusColor: Colors.lightGreen,
                                              icon: const Icon(
                                                Icons.check,
                                                color: Colors.lightGreen,
                                              ),
                                              onPressed: () async{
                                                stuHelper.add(
                                                  mystu.clid,
                                                  mystu.name,
                                                  mystu.regno,
                                                  mystu.sprno,
                                                  mystu.smob,
                                                  mystu.pmob,
                                                );
                                                stulist.add(mystu);
                                                msg('${mystu.name} Added');
                                                sheetstu.removeAt(index);
                                                setState(() {});
                                              },
                                            ),
                                          ),
                                          wspace(15),
                                        ],
                                      ),
                                      const Divider(
                                        height: 10,
                                        thickness: 0.5,
                                        color: Colors.brown,
                                        indent: 10,
                                        endIndent: 10,
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(bottom: 10, right: 10),
                              height: 50,
                              child: Row(
                                children: [
                                  const Spacer(),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Student(classs: classs)));
                                    },
                                    child: Text(
                                      'cancel'.toUpperCase(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w900,
                                          color: Colors.red),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        //onSurface: Colors.amber.withOpacity(0.5),
                                        fixedSize: const Size(200, 50)),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                      return Center(
                        child: JumpingDotsProgressIndicator(
                          color: Colors.amber.withOpacity(0.5),
                          fontSize: 50,
                          numberOfDots: 5,
                        ),
                      );
                    });
              }
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return LoadingAnimationWidget.beat(color: cr_brown, size: 20);
            }),
      ),
    );
  }
}

class gshudia extends StatefulWidget {
  Future<List<Stu>> getshulist;
  Classes classs;

  gshudia({
    Key? key,
    required this.getshulist,
    required this.classs,
  }) : super(key: key);

  @override
  _gshudiaState createState() => _gshudiaState();
}

class Student extends StatefulWidget {
  Classes classs;

  Student({Key? key, required this.classs}) : super(key: key);

  @override
  _StudentState createState() => _StudentState();
}
