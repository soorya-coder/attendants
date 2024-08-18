import 'package:attendants/constants/color.dart';
import 'package:attendants/constants/functions.dart';
import 'package:attendants/constants/wigets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:attendants/constants/Drawer.dart';
import 'package:attendants/constants/Bottom%20bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _ProfileState extends State<Profile> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        routename(context,'/home');
        return true;
      },
      child: Scaffold(
        drawer: drawer(headcolor: cr_brown),
        drawerEnableOpenDragGesture: false,
        bottomNavigationBar: bottom_bar(context,3,cr_brown),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: InkWell(
                          onTap: (){
                            Scaffold.of(context).openDrawer();
                          },
                          child: Card(
                            shape:  RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: Colors.brown.shade100,
                            elevation: 5,
                            child: Icon(CupertinoIcons.bars)
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          'Profile',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: Card(
                          shape:  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Colors.brown.shade400,
                          elevation: 5,
                          child: option(),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                hspace(20),
                Row(
                  children: [
                    wspace(20),
                    Expanded(
                      flex: 3,
                      child: CircleAvatar(
                        backgroundColor: Colors.brown.shade400.withOpacity(0.5),
                        foregroundColor: Colors.white,
                        radius: 50,
                        child: const FittedBox(
                          fit: BoxFit.fill,
                            child: Icon(IconlyBold.profile,size: 80,)
                        ),
                      ),
                    ),
                    wspace(10),
                    Expanded(
                      flex: 7,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 20),
                            width: double.maxFinite,
                            child: Text(
                                pname,
                                style: GoogleFonts.rubik(
                                  color: cr_brown,
                                  fontSize: 25,
                                )
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 10),
                            width: double.maxFinite,
                            child: Text(
                              pemail,
                              style: GoogleFonts.rubik(
                                color: cr_brown,
                                fontSize: 20
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 10),
                            width: double.maxFinite,
                            child: Text(
                                pinstut,
                                style: GoogleFonts.rubik(color: cr_brown,fontSize: 28)
                            ),
                          ),
                        ],
                      )
                    )
                  ],
                ),
                hspace(40),
                Container(
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: Colors.amber.withOpacity(0.4)
                  ),
                  child: Column(
                    children: [
                      hspace(5),
                      Text.rich(
                        TextSpan(
                          children: const [
                            TextSpan(text: 'Add your '),
                            TextSpan(text: 'Departments',style: TextStyle(fontSize: 20)),
                          ],
                          style: GoogleFonts.rubik(color: Colors.black)
                        ),
                      ),
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          reverse: true,
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(top: 20,left:20,bottom: 20),
                          scrollDirection: Axis.horizontal,
                            itemCount: depl.length+1,
                            itemBuilder: (context,int index){
                              if (index==depl.length) {
                                return addme();
                              } else {
                                return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: SizedBox(
                                  width: 150,
                                  height: 100,
                                  child: Stack(
                                    children: [
                                      Card(
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        color: depcl.elementAt(index).withOpacity(0.5),
                                        child: Center(
                                          child: Text(depl.elementAt(index)),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: IconButton(
                                          icon: const Icon(
                                            IconlyBroken.delete,
                                            color: CupertinoColors.white,
                                            size: 20,
                                          ),
                                          onPressed: (){

                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                              }
                            }
                        ),
                      ),
                    ],
                  ),

                ),
              ],
            ),
          )
        ),
      ),
    );
  }

  String addep = '';

  Widget addme(){
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: SizedBox(
        width: 150,
        height: 100,
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.grey.withOpacity(0.5),
          child: Center(
            child: IconButton(
              padding: const EdgeInsets.only(bottom: 10),
              icon: const Icon(CupertinoIcons.add,size: 40,color: Colors.white,),
              onPressed: (){
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: 100,
                      child: Center(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                child: TextField(
                                  decoration: const InputDecoration(
                                  ),
                                  onChanged: (String note){
                                    addep = note;
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                child: IconButton(
                                  icon: const Icon(CupertinoIcons.checkmark_alt),
                                  onPressed: () async {
                                    SharedPreferences pref = await SharedPreferences.getInstance();
                                    pref.setString('dep 3', addep);
                                  },
                                ),
                              ),
                            )
                          ],
                        )
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void adddepsh(String dep) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('dep \$', dep);
  }

}


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

