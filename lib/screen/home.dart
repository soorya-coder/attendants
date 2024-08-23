import 'dart:io';
import 'package:attendants/constants/color.dart';
import 'package:attendants/constants/wigets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:attendants/constants/Drawer.dart';
import 'package:attendants/constants/Bottom%20bar.dart';
import 'package:iconly/iconly.dart';
import 'package:url_launcher/url_launcher.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
  
}
class _HomeState extends State<Home> {

  bool abl = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        SystemNavigator.pop();
        exit(0);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          backgroundColor: cr_purple,
          actions: [
            IconButton(
              onPressed: () {  },
              icon: const Icon(IconlyBold.notification),
            ),
            option(),
          ],
        ),
        drawer: drawer(headcolor: Colors.purpleAccent.shade400.withOpacity(0.2)),
        body: /* FutureBuilder(
          future: classdata.instance.getlist(),
          builder: (context,AsyncSnapshot snapshot) {
            if(snapshot.hasData){
              return FutureBuilder(
                future: toddata.instance.getlist(),
                builder: (context,AsyncSnapshot snaptod) {
                  if(!snaptod.hasError){
                    return FutureBuilder(
                      future: studata.instance.getlist(),
                      builder: (context,AsyncSnapshot snaps) {
                        if(snaps.hasData){
                          List<Classes> myclases = snapshot.data ?? [];
                          List<Stuab> mytoday = snaptod.data ?? [];
                          List<Stu> myalstu = snaps.data ?? [];
                          List<Stu> myremstu = [];
                          List<Stuab> myab = [];
                          List<Stuab> mypr = [];
                          mytoday.forEach((element) {
                            DateTime dateab = DateFormat('dd-MM-yyyy').parse(element.date);
                            if(dateab == currentDate){
                              if(element.ab == -1) myab.add(element);
                              if(element.ab == 1) mypr.add(element);
                            }
                          });
                          return RefreshIndicator(
                            onRefresh: () async{
                              await Future.delayed(const Duration(seconds: 2));
                              setState(() {});
                            },
                            color: Colors.purpleAccent.shade400,
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.only(top: 10,bottom: 20),
                              child: RefreshIndicator(
                                onRefresh: () async{await Future.delayed(const Duration(seconds: 2));setState(() {});},
                                color: Colors.redAccent,
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                                      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                                      height: size.height*0.35,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: Colors.purple.shade100.withOpacity(0.3),
                                      ),
                                      child:Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: const [
                                              Text('Class report',style: TextStyle(fontSize: 20,color: cr_grey),),
                                              Spacer(),
                                              Icon(IconlyBroken.arrow_right_2)
                                            ],
                                          ),
                                          Expanded(
                                            flex: 10,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              reverse: true,
                                              physics: const BouncingScrollPhysics(),
                                              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                                              itemCount: myclases.length,
                                              itemBuilder: (context,index){
                                                Classes myclass = myclases[index];
                                                List<Stu> mystu = [];
                                                myalstu.forEach((element) {
                                                  if(element.clid == myclass.id){
                                                    mystu.add(element);
                                                  }
                                                });
                                                int lenab = 0,lenpr = 0;
                                                mystu.forEach((els) {
                                                  bool con = true;
                                                  myab.forEach((elt) {
                                                    if(elt.stuid == els.id) con = false;
                                                  });
                                                  mypr.forEach((elt) {
                                                    if(elt.stuid == els.id) con = false;
                                                  });
                                                  if(con) myremstu.add(els);
                                                });
                                                myab.forEach((element) {if(myclass.id == element.classid) lenab++;});
                                                mypr.forEach((element) {if(myclass.id == element.classid) lenpr++;});
                                                return Expanded(
                                                  child: Card(
                                                    elevation: 7,
                                                    margin: const EdgeInsets.symmetric(horizontal: 10),
                                                    shadowColor: CupertinoColors.white,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(20),
                                                    ),
                                                    color: CupertinoColors.white,
                                                    child: Container(
                                                      width: size.width-100,
                                                      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: PieChart(
                                                              dataMap: {
                                                                "Absent": lenab.toDouble(),
                                                                "Present": lenpr.toDouble(),
                                                                "remaining": (mystu.length-(lenab+lenpr)).toDouble(),
                                                              },
                                                              colorList: [
                                                                cr_red.withOpacity(0.6),
                                                                cr_green.withOpacity(0.6),
                                                                Colors.grey.withOpacity(0.6)
                                                              ],
                                                              centerText: '${dep[myclass.dep]}-${year[myclass.year]}',
                                                              centerTextStyle: GoogleFonts.oswald(
                                                                color: depcl[myclass.dep].withOpacity(0.5),
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.bold
                                                              ),
                                                              animationDuration: const Duration(milliseconds: 800),
                                                              chartLegendSpacing: 32,
                                                              chartRadius: MediaQuery.of(context).size.width * 0.3,
                                                              initialAngleInDegree: 0,
                                                              chartType: ChartType.ring,
                                                              ringStrokeWidth: 20,
                                                              legendOptions: const LegendOptions(
                                                                showLegendsInRow: false,
                                                                legendPosition: LegendPosition.right,
                                                                showLegends: true,
                                                                legendShape: BoxShape.circle,
                                                                legendTextStyle: TextStyle(
                                                                  fontWeight: FontWeight.bold,
                                                                ),
                                                              ),
                                                              chartValuesOptions: const ChartValuesOptions(
                                                                showChartValueBackground: false,
                                                                showChartValues: false,
                                                                showChartValuesInPercentage: false,
                                                                showChartValuesOutside: false,
                                                                decimalPlaces: 0,
                                                              ),
                                                              // gradientList: ---To add gradient colors---
                                                              // emptyColorGradient: ---Empty Color gradient---
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }
                                            )
                                          )
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      thickness: 1,
                                      indent: 10,
                                      endIndent: 10,
                                      color: Colors.black12,
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        wspace(20),
                                        Text(
                                            'Absentees list',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: cr_brown
                                          ),
                                        ),
                                        const Spacer(),
                                        Text('${myab.length}'),
                                        wspace(10),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              abl = !abl;
                                            });
                                          },
                                          icon: Icon(
                                            abl ? IconlyBold.arrow_up_2 : IconlyBold.arrow_down_2,
                                            color: cr_red,
                                          ),
                                        ),
                                        wspace(20),
                                      ],
                                    ),
                                    const Divider(
                                      thickness: 1,
                                      indent: 10,
                                      endIndent: 10,
                                      color: Colors.black12,
                                      height: 5,
                                    ),
                                    hspace(20),
                                    Visibility(
                                      replacement: wspace(0),
                                      visible: abl,
                                      child: ListView.separated(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: myab.length,
                                        itemBuilder: (context,index){
                                          Stuab stuat = myab[index];
                                          Stu? studen;
                                          String? clasname;
                                          myalstu.forEach((element) {
                                            if(stuat.stuid == element.id){
                                              studen = element;
                                            }
                                          });
                                          Classes? myclass;
                                          myclases.forEach((element) {
                                            if(element.id == stuat.classid) {
                                              myclass = element;
                                              clasname = '${dep[element.dep]}-${year[element.year]}';
                                            }
                                          });
                                          return Row(
                                            children: [
                                              wspace(20),
                                              Expanded(
                                                flex: 2,
                                                child: InkWell(
                                                  onTap: (){
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) => call(studen!.smob,studen!.pmob)
                                                    );
                                                  },
                                                  child: Stack(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor:
                                                        stuat.ab==1 ?
                                                        Colors.lightGreen.withOpacity(0.8) :
                                                        Colors.redAccent.withOpacity(0.8),
                                                        child: Text(
                                                          year[myclass!.year],
                                                          style: GoogleFonts.catamaran(
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.w900
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        bottom: 5,
                                                        right: 5,
                                                        child: SizedBox(
                                                          width: 20,
                                                          height: 20,
                                                          child: Material(
                                                            elevation: 10,
                                                            shadowColor: Colors.amber.shade700,
                                                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                                                            child: const Icon(
                                                              Icons.call,
                                                              size: 10,
                                                              color: Colors.lightGreen,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              wspace(10),
                                              Expanded(
                                                flex: 7,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      studen!.name,
                                                      style: const TextStyle(
                                                        fontWeight: FontWeight.w900,
                                                        fontSize: 20
                                                      ),
                                                    ),
                                                    Text(
                                                      clasname!,
                                                      style:TextStyle(
                                                        color: depcl[myclass!.dep],
                                                        letterSpacing: 2,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 15
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.red.withOpacity(0.7),
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                                  child: Row(
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
                                                            onPressed: (){},
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: IconButton(
                                                          icon: const Icon(
                                                            CupertinoIcons.checkmark_alt_circle_fill,
                                                            color: Colors.white,
                                                            size: 40,
                                                          ),
                                                          onPressed: (){
                                                            setState(() {
                                                              toddata.instance.upab(stuat.id!,1);
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              wspace(10),
                                            ],
                                          );
                                        },
                                        separatorBuilder: (BuildContext context, int index) =>
                                            Divider(
                                              color: Colors.redAccent.withOpacity(0.8),
                                              indent: 25,
                                              endIndent: 20,
                                            ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else if(snapshot.hasError){
                          return Center(child: Text(snapshot.error.toString()));
                        }else{
                          return const Center(child: const CircularProgressIndicator(color: Colors.purpleAccent,),);
                        }
                      }
                    );
                  }else{
                    return Center(
                      child: Text(snaptod.error.toString()),
                    );
                  }
                }
              );
            } else if(snapshot.hasError){
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }else{
              return const Center(
                child: const Text('No data'),
              );
            }

          }
        ) */ const SizedBox(),
        bottomNavigationBar: bottom_bar(context,0,Colors.purpleAccent),

      ),
    );
  }

  Dialog call(String stuno,String prno) {
    final Size size = MediaQuery.of(context).size;
    return Dialog(
      elevation: 200,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      //insetPadding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        height: size.height*0.25,
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
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
              onTap: () async{
                launch("tel://$stuno");
              },
              title: const Text('Student number',style: TextStyle(color: Colors.black),),
              subtitle: Text(stuno),
              trailing: const Icon(Icons.call,color: Colors.lightGreen,),
            ),
            const Spacer(),
            ListTile(
              onTap: () async{
                launch("tel://$prno");
              },
              title: const Text('Parent number',style: TextStyle(color: Colors.black),),
              subtitle: Text(prno),
              trailing: const Icon(Icons.call,color: Colors.lightGreen,),
            )
          ],
        ),
      ),
    );
  }

}
