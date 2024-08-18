import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class drawer extends StatelessWidget {
  Color headcolor;
  drawer({
    Key? key,
    required this.headcolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext Context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              '',
              style: GoogleFonts.roboto(fontSize: 20),
            ),
            accountEmail: const Text(
              '',
              style: TextStyle(fontSize: 20),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: CupertinoColors.white,
              child: Text(
                ''.substring(0, 1),
                style: GoogleFonts.dancingScript(
                    fontSize: 40,
                    color: headcolor.withOpacity(0.5),
                    fontWeight: FontWeight.w900),
              ),
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  headcolor.withOpacity(0.5),
                  headcolor.withOpacity(0.2),
                ])),
          )
        ],
      ),
    );
  }
}
