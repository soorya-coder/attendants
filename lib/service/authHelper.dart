// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../constants/functions.dart';
import '../object/users.dart';

class AuthHelper {
  static FirebaseAuth firebaseauth = FirebaseAuth.instance;

  static User? get myuser => FirebaseAuth.instance.currentUser;

  static DocumentReference get docuser =>
      FirebaseFirestore.instance.doc('/Users/${myuser!.uid}');

  Stream<User?> authchanges() => firebaseauth.authStateChanges();

  Future<User?> signInGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final userCredential = await firebaseauth.signInWithCredential(
          GoogleAuthProvider.credential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ),
        );
        createUser();
        return userCredential.user;
      } else {
        throw FirebaseAuthException(
          code: 'ERROR_MISSING_GOOGLE_ID_TOKEN',
          message: 'Missing Google ID Token',
        );
      }
    } else {
      throw FirebaseAuthException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }

  Future<User?> signInAnonymously() async {
    UserCredential userCredential = await firebaseauth.signInAnonymously();
    return userCredential.user;
  }

  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await firebaseauth.signOut();
  }

  Stream<Users?> startup() {
    addlogins();
    return docuser
        .snapshots()
        .map((data) => Users.fromMap(data.data() as Map<String, dynamic>));
  }

  Future<void> createUser() async {
    User? user = myuser;
    Users users = Users(
        uid: user!.uid,
        fcid: '',
        name: user.displayName!,
        url: user.photoURL ?? '',
        crtime: timenow,
        logins: [timenow],
        email: user.email!,
        deps: ['CIVIL', 'CSE', 'ECE', 'EEE', 'MECH']);

    docuser.get().then((value) {
      if (value.exists) {
        return;
      } else {
        docuser.set(users.toMap());
      }
    });
    return;
  }

  Future<void> adddep(String dep) async {
    return docuser.update({
      col_deps: FieldValue.arrayUnion([dep])
    });
  }

  Future<void> deldep(String dep) async {
    return docuser.update({
      col_deps: FieldValue.arrayRemove([dep])
    });
  }

  Stream<List<String>> deps() {
    return docuser.snapshots().map((doc)=> Users.fromMap(doc.data() as Map<String, dynamic>?).deps);
  }

  Future<void> addlogins() async {
    if (myuser != null) {
      docuser.update({
        col_logins: FieldValue.arrayUnion([timenow.substring(0, 16)])
      });
    } else {
      msg('Finish your login');
    }
  }

  // 2023-08-14T14:33:54.796907
  // 12345678901234567890
}
