import 'package:attendants/constants/color.dart';
import 'package:attendants/constants/wigets.dart';
import 'package:attendants/main.dart';
import 'package:attendants/object/classes.dart';
import 'package:attendants/service/classHelper.dart';
import 'package:attendants/service/stuHelper.dart';
import 'package:attendants/service/todHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:attendants/constants/Drawer.dart';
import 'package:attendants/constants/Bottom%20bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../constants/functions.dart';
import '../object/stu.dart';
import '../object/stuab.dart';
import 'attend.dart';

class _TodayState extends State<Today> {
  List<int> per = [1, 2, 3, 4, 5, 6, 7, 8];
  int selper = 1;

  String cla = '';
  bool stl = true, attl = false, loading = false;

  @override
  void initState() {
    super.initState();

    //currentDate = DateFormat('dd-MM-yyyy').parse(today);
    //todate = DateFormat('dd-MM-yyyy').format(currentDate);

    //for (int i = 1; i < currentDate.day + 1; i++) {
    //  tabs.insert(
    //    0,
    //    '${i.toString().length == 1 ? '0$i' : i}-${date('MM').toString() == '1' ? '0${date('MM')}' : date('MM')}-${date('yyyy')}',
    //  );
    //}
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope.new(
      onWillPop: () async {
        Navigator.pushNamed(context, '/home');
        return true;
      },
      child: Scaffold(
        body: FutureBuilder(
            future: ClassHelper.getfocus(),
            builder: (context, AsyncSnapshot<String> cidsnap) {
              if (cidsnap.hasError) {
                return Center(
                  child: Text('e1${cidsnap.error}'),
                );
              }
              if (cidsnap.hasData) {
                String cid = cidsnap.data!;

                //TodHelper todHelper = TodHelper(cid: cid, period: selper);

                /*return FutureBuilder(
                    future: todHelper.getlist(),
                    builder: (context, AsyncSnapshot snaptod) {
                      if (snaptod.hasError) {
                        return Errored(error: 'e2${snaptod.error}');
                      }
                      if (snaptod.hasData) {
                        List<Stuab> data = snaptod.data ?? [];
                        List<Stuab> mytoday = [];

                        for (Stuab stuab in data) {
                          if(stuab.isPresent == ''){
                            print(stuab.toMap());

                            continue;
                          }
                          mytoday.add(stuab);
                        }*/

                return StreamBuilder<List<Stu>>(
                    stream: StuHelper(cid: cid).getClasstu(),
                    builder: (context, AsyncSnapshot<List<Stu>> snaps) {
                      if (snaps.hasError) {
                        return Errored(error: 'e3${snaps.error}');
                      }
                      if (snaps.hasData) {
                        /*List<Stu> datast = snaps.data;
                                List<Stu> remstu = [];
                                List<Stu> mystulist = [];
                                for (var element in datast) {
                                  if (element.clid == cidsnap.data) {
                                    mystulist.add(element);
                                    bool con = true;
                                    for (var tod in mytoday) {
                                      if (tod.sid == element.id) con = false;
                                    }
                                    if (con) remstu.add(element);
                                  }
                                }
                                int ab = 0, pr = 0;
                                for (var element in mytoday) {
                                  if (!(element.isPresent == 'A')) ab++;
                                  if (element.isPresent == 'P') pr++;
                                }

                                 */

                        return StreamBuilder<Classes>(
                            stream: ClassHelper().getClass(cid),
                            builder: (context, clasnap) {
                              if (clasnap.hasError) {
                                return Errored(error: 'e4${clasnap.error}');
                              }
                              if (clasnap.hasData) {
                                Classes classes = clasnap.data!;
                                return Scaffold(
                                  appBar: AppBar(
                                    title: const Text('Today'),
                                    backgroundColor: cr_red,
                                    actions: [
                                      IconButton(
                                        onPressed: () {
                                          _selectDate(context);
                                        },
                                        icon: const Icon(IconlyBroken.calendar),
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          /*showDialog(context: context, builder: (context){

                                            return SizedBox(
                                              width: 100.r,
                                              height: 100.r,
                                              child: LoadingAnimationWidget.beat(color: cr_purple, size: 20.sp),
                                            );

                                          });

                                           */
                                          TodHelper.uploadab(cid, today);
                                        },
                                        icon:
                                            const Icon(IconlyBold.tick_square),
                                      ),
                                    ],
                                    bottom: PreferredSize(
                                      preferredSize:
                                          const Size(double.maxFinite, 50),
                                      child: Expanded(
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            itemCount: per.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 0, 10, 0),
                                                child: ActionChip(
                                                  label: Text(
                                                      '${per[index]}th period'),
                                                  backgroundColor:
                                                      per[index] == selper
                                                          ? Colors.redAccent
                                                          : null,
                                                  onPressed: () {
                                                    setState(() {
                                                      selper = per[index];
                                                    });
                                                  },
                                                ),
                                              );
                                            }),
                                      ),
                                    ),
                                  ),
                                  drawer: drawer(headcolor: Colors.redAccent),
                                  body: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    padding:
                                        EdgeInsets.symmetric(vertical: 5.h),
                                    child: Column(
                                      children: [
                                        Card(
                                          margin: EdgeInsets.symmetric(
                                            vertical: 10.h,
                                            horizontal: 10.w,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                          ),
                                          elevation: 5.r,
                                          shadowColor: cr_red,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 10.h,
                                              horizontal: 10.w,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                              color: Colors.redAccent
                                                  .withOpacity(0.2),
                                            ),
                                            child: Row(
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5.h,
                                                              horizontal: 10.w),
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.r)),
                                                      ),
                                                      child: Text(
                                                        '${depl[depl.indexOf(classes.dep)]} - ${yearl[classes.year - 1]} (${secl[secl.indexOf(classes.sec)]})',
                                                        style: TextStyle(
                                                          color:
                                                              Colors.blueAccent,
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    hspace(10),
                                                    RichText(
                                                      text: TextSpan(
                                                        style:
                                                            GoogleFonts.rubik(
                                                          color: Colors.grey,
                                                        ),
                                                        children: [
                                                          const TextSpan(
                                                            text:
                                                                'Attendents \n',
                                                            style: TextStyle(
                                                              fontSize: 30,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                'No. of students = ${snaps.data!.length}\n',
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.brown,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        ListView.builder(
                                            itemCount: per.length,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (con, index) {
                                              return ListTile(
                                                onTap: () {
                                                  route(
                                                    context,
                                                    Attend(
                                                      classes: classes,
                                                      date: today,
                                                      period: per[index],
                                                    ),
                                                  );
                                                },
                                                leading: Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: cr_red,
                                                  ),
                                                  padding: EdgeInsets.all(10.r),
                                                  child: Text(
                                                      per[index].toString()),
                                                ),
                                                title: Text(today),
                                                subtitle: Text(
                                                    '${per[index]}th period'),
                                                trailing: SizedBox(
                                                  width: 50.w,
                                                  child: Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return Dialog(
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.r),
                                                                  ),
                                                                  child:
                                                                      Container(
                                                                    height:
                                                                        300.h,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.r),
                                                                    ),
                                                                    child:
                                                                        SingleChildScrollView(
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Text(
                                                                            'List of students',
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 12.sp,
                                                                            ),
                                                                          ),
                                                                          StreamBuilder<List<Stu>>(
                                                                              stream: StuHelper(cid: cid).getClasstu(),
                                                                              builder: (context, snapstu) {
                                                                                return StreamBuilder<List<Stuab>>(
                                                                                    stream: TodHelper(cid: cid, period: per[index]).getlist(),
                                                                                    builder: (context, snapab) {
                                                                                      if (snapab.hasData && snapstu.hasData) {
                                                                                        print(per[index]);
                                                                                        print(snapab.data);
                                                                                        return ListView.builder(
                                                                                          shrinkWrap: true,
                                                                                          itemCount: snapstu.data!.length,
                                                                                          itemBuilder: (context, inx) {
                                                                                            Stu stu = snapstu.data![inx];
                                                                                            Stuab? stuab;
                                                                                            for (Stuab ab in snapab.data!) {
                                                                                              if (ab.sid == stu.id) {
                                                                                                stuab = ab;
                                                                                              }
                                                                                            }
                                                                                            return ListTile(
                                                                                              title: Text(stu.name),
                                                                                              subtitle: Text(stu.regno),
                                                                                              trailing: stuab == null
                                                                                                  ? const SizedBox()
                                                                                                  : stuab.isPresent == 'P'
                                                                                                      ? Icon(
                                                                                                          CupertinoIcons.checkmark_alt_circle_fill,
                                                                                                          color: Colors.redAccent.withOpacity(0.7),
                                                                                                          size: 25.r,
                                                                                                        )
                                                                                                      : Icon(
                                                                                                          CupertinoIcons.clear_thick_circled,
                                                                                                          color: Colors.redAccent.withOpacity(0.7),
                                                                                                          size: 25.r,
                                                                                                        ),
                                                                                            );
                                                                                          },
                                                                                        );
                                                                                      }
                                                                                      return LoadingAnimationWidget.beat(color: cr_amber, size: 10.sp);
                                                                                    });
                                                                              }),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              });
                                                        },
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                              color: cr_red,
                                                              width: 1.sp,
                                                            ),
                                                          ),
                                                          padding:
                                                              EdgeInsets.all(
                                                                  2.r),
                                                          child: Icon(
                                                            IconlyBold.paper,
                                                            color: cr_red,
                                                          ),
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                                color: cr_red,
                                                                width: 1.sp)),
                                                        padding:
                                                            EdgeInsets.all(2.r),
                                                        child: Icon(
                                                          IconlyBold
                                                              .arrow_right_2,
                                                          color: cr_red,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            })
                                      ],
                                    ),
                                  ),
                                );
                              }
                              return const Loading();
                            });
                      }
                      return const Loading();
                    });
                /*}
                      return const Loading();
                    });*/
              }
              return const Loading();
            }),
        bottomNavigationBar: bottom_bar(context, 1, Colors.redAccent),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        currentDate = pickedDate;
        todate = DateFormat('dd-MM-yyyy').format(currentDate);
      });
    }
  }

  int date(String fromat) {
    return int.parse(DateFormat(fromat).format(DateTime.now()));
  }
}

class Today extends StatefulWidget {
  const Today({Key? key}) : super(key: key);

  @override
  _TodayState createState() => _TodayState();
}

/*

                                        Row(
                                          children: [
                                            wspace(20),
                                            Text(
                                              'Students list',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: cr_brown),
                                            ),
                                            const Spacer(),
                                            Text('${remstu.length}'),
                                            wspace(10),
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  stl = !stl;
                                                });
                                              },
                                              icon: Icon(
                                                stl
                                                    ? IconlyBold.arrow_up_2
                                                    : IconlyBold.arrow_down_2,
                                                color: cr_red,
                                              ),
                                            ),
                                            wspace(20),
                                          ],
                                        ),
                                        const Divider(
                                          indent: 20,
                                          endIndent: 20,
                                          height: 0,
                                          thickness: 0.5,
                                          color: Colors.brown,
                                        ),
                                        Visibility(
                                          visible: stl,
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: remstu.length,
                                              itemBuilder: (context, index) {
                                                Stu stu = remstu[index];
                                                return Column(
                                                  children: [
                                                    hspace(2),
                                                    Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                20, 0, 16, 0),
                                                        child: Row(
                                                          children: [
                                                            wspace(10),
                                                            Expanded(
                                                              flex: 1,
                                                              child:
                                                                  CircleAvatar(
                                                                backgroundColor:
                                                                    Colors
                                                                        .yellow
                                                                        .shade700
                                                                        .withOpacity(
                                                                            0.8),
                                                                child: Text(
                                                                  stu.name
                                                                      .substring(
                                                                          0, 1),
                                                                  style: GoogleFonts
                                                                      .catamaran(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w900,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            wspace(16),
                                                            Expanded(
                                                              flex: 5,
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    stu.name,
                                                                  ),
                                                                  RichText(
                                                                    text: TextSpan(
                                                                        style: GoogleFonts.rubik(
                                                                            color:
                                                                                Colors.black,
                                                                        ),
                                                                        children: [
                                                                          const TextSpan(
                                                                              text: 'Spr no: '),
                                                                          TextSpan(
                                                                              text: stu.sprno,
                                                                              style: const TextStyle(fontWeight: FontWeight.bold)),
                                                                          const TextSpan(
                                                                              text: ' | \ns',
                                                                              style: TextStyle()),
                                                                          const TextSpan(
                                                                              text: 'Reg no: '),
                                                                          TextSpan(
                                                                              text: stu.regno,
                                                                              style: const TextStyle(fontWeight: FontWeight.bold)),
                                                                        ]),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 3,
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .black12,
                                                                        borderRadius:
                                                                            BorderRadius.circular(15.r),
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                IconButton(
                                                                              icon: Icon(
                                                                                CupertinoIcons.clear_thick_circled,
                                                                                color: Colors.redAccent.withOpacity(0.7),
                                                                                size: 25.r,
                                                                              ),
                                                                              onPressed: () {
                                                                                setState(() {
                                                                                  todHelper.markAbsent(stu.id!);
                                                                                });
                                                                              },
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                IconButton(
                                                                              icon: Icon(
                                                                                CupertinoIcons.checkmark_alt_circle_fill,
                                                                                color: Colors.lightGreen.withOpacity(0.9),
                                                                                size: 25.r,
                                                                              ),
                                                                              onPressed: () {
                                                                                setState(() {
                                                                                  todHelper.markPresent(stu.id!);
                                                                                });
                                                                              },
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                    hspace(10),
                                                    const Divider(
                                                      indent: 20,
                                                      endIndent: 20,
                                                      height: 0,
                                                      thickness: 0.5,
                                                      color: Colors.brown,
                                                    )
                                                  ],
                                                );
                                              }),
                                        ),
                                        Row(
                                          children: [
                                            wspace(20),
                                            Text(
                                              'Attendant list',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: cr_brown),
                                            ),
                                            const Spacer(),
                                            Text('${mytoday.length}'),
                                            wspace(10),
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  attl = !attl;
                                                });
                                              },
                                              icon: Icon(
                                                attl
                                                    ? IconlyBold.arrow_up_2
                                                    : IconlyBold.arrow_down_2,
                                                color: cr_red,
                                              ),
                                            ),
                                            wspace(20),
                                          ],
                                        ),
                                        mytoday.isNotEmpty
                                            ? const Divider(
                                                indent: 20,
                                                endIndent: 20,
                                                height: 0,
                                                thickness: 0.5,
                                                color: Colors.brown,
                                              )
                                            : const SizedBox(),
                                        Visibility(
                                          visible: attl,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: mytoday.length,
                                            itemBuilder: (context, index) {
                                              Stuab studen =
                                                  mytoday.elementAt(index);
                                              Stu? mystu;
                                              for (var element in mystulist) {
                                                if (studen.sid == element.id) {
                                                  mystu = element;
                                                }
                                              }
                                              return Column(
                                                children: [
                                                  hspace(2.h),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10.w),
                                                    child: Row(
                                                      children: [
                                                        wspace(10),
                                                        Expanded(
                                                          flex: 1,
                                                          child: CircleAvatar(
                                                            backgroundColor: studen
                                                                    .isPresent == 'P'
                                                                ? Colors
                                                                    .lightGreen
                                                                    .withOpacity(
                                                                        0.8)
                                                                : Colors
                                                                    .redAccent
                                                                    .withOpacity(
                                                                        0.8),
                                                            child: Text(
                                                              studen.isPresent,
                                                              //studename.substring(0,1),
                                                              style: GoogleFonts.catamaran(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900),
                                                            ),
                                                          ),
                                                        ),
                                                        wspace(16),
                                                        Expanded(
                                                          flex: 5,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                mystu!.name
                                                                    .toUpperCase(),
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w900,
                                                                    letterSpacing:
                                                                        1),
                                                              ),
                                                              RichText(
                                                                text: TextSpan(
                                                                  style: GoogleFonts.rubik(
                                                                      color: Colors
                                                                          .black26),
                                                                  children: [
                                                                    const TextSpan(
                                                                        text:
                                                                            'Spr no: '),
                                                                    TextSpan(
                                                                        text: mystu
                                                                            .sprno,
                                                                        style: const TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.black54)),
                                                                    const TextSpan(
                                                                        text:
                                                                            ' | \n',
                                                                        style:
                                                                            TextStyle()),
                                                                    const TextSpan(
                                                                        text:
                                                                            'Reg no: '),
                                                                    TextSpan(
                                                                        text: mystu
                                                                            .regno,
                                                                        style: const TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.black54)),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 3,
                                                          child:
                                                              studen.isPresent == 'P'
                                                                  ? Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .lightGreen,
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .fromLTRB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Expanded(
                                                                              child: IconButton(
                                                                                icon: const Icon(
                                                                                  CupertinoIcons.clear_thick_circled,
                                                                                  color: Colors.white,
                                                                                  size: 40,
                                                                                ),
                                                                                onPressed: () {
                                                                                  setState(() {
                                                                                    studen.isPresent = 'A';
                                                                                    //toddata.instance.upab(studen.id, studen.is_present);
                                                                                  });
                                                                                },
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              child: Opacity(
                                                                                opacity: 0.2,
                                                                                child: IconButton(
                                                                                  icon: const Icon(
                                                                                    CupertinoIcons.checkmark_alt_circle_fill,
                                                                                    color: Colors.white,
                                                                                    size: 40,
                                                                                  ),
                                                                                  onPressed: () {},
                                                                                ),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : Container(
                                                                      height:
                                                                          60,
                                                                      width:
                                                                          120,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .red
                                                                            .withOpacity(0.7),
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .fromLTRB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Expanded(
                                                                              child: Opacity(
                                                                                opacity: 0.4,
                                                                                child: IconButton(
                                                                                  icon: const Icon(
                                                                                    CupertinoIcons.clear_thick_circled,
                                                                                    color: Colors.white,
                                                                                    size: 40,
                                                                                  ),
                                                                                  onPressed: () {},
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              child: Center(
                                                                                child: IconButton(
                                                                                  icon: const Icon(
                                                                                    CupertinoIcons.checkmark_alt_circle_fill,
                                                                                    color: Colors.white,
                                                                                    size: 40,
                                                                                  ),
                                                                                  onPressed: () {
                                                                                    setState(() {
                                                                                      studen.isPresent = 'P';
                                                                                      //toddata.instance.upab(studen.id, studen.is_present);
                                                                                    });
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  hspace(5.h),
                                                  const Divider(
                                                    indent: 20,
                                                    endIndent: 20,
                                                    height: 0,
                                                    thickness: 0.5,
                                                    color: Colors.brown,
                                                  )
                                                ],
                                              );
                                            },
                                          ),
                                        )
 */
