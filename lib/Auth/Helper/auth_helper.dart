import 'package:firebase_auth/firebase_auth.dart';
import 'package:gsk_firebase/Chating/Models/RegisterRequest.dart';
import 'package:gsk_firebase/Services/customDialog.dart';

class Auth_helper {
  Auth_helper._();

  static Auth_helper auth_helper = Auth_helper._();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> signup(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      print(userCredential.user.uid);
      return userCredential;

//same the id but large digits and has a expire time and it is more secure
      print(userCredential.user.getIdToken());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CustomDialog.customDialog
            .showCustom('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        CustomDialog.customDialog
            .showCustom('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  signin(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      vereifyEmail();

      // print(userCredential.user.uid);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'user-not-found') {
        CustomDialog.customDialog.showCustom('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        CustomDialog.customDialog
            .showCustom('Wrong password provided for that user.');
      }
    }
  }

  resetPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
    CustomDialog.customDialog.showCustom(
        'We have sent email for reset password, please check your email');
  }

  vereifyEmail() async {
    if (firebaseAuth.currentUser != null &&
        !firebaseAuth.currentUser.emailVerified) {
      await firebaseAuth.currentUser.sendEmailVerification();
    }
    CustomDialog.customDialog.showCustom('verification success.');
  }

  signOut() async {
    await firebaseAuth.signOut();
  }

  bool checkEmailVerification() {
    return firebaseAuth.currentUser?.emailVerified ?? false;
  }

  Future<User> getCurrentUser() async {
    try {
      var currentuser = firebaseAuth.currentUser;
      if (currentuser != null) return firebaseAuth.currentUser;
    } on Exception catch (e) {
      // TODO
    }
  }

  deleteUser() async {
    try {
      await firebaseAuth.currentUser.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        CustomDialog.customDialog.showCustom(
            'The user must reauthenticate before this operation can be executed.');
      }
    }
  }
}
