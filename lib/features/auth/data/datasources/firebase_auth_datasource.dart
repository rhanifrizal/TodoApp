import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todoapp/core/error/exceptions.dart';

abstract interface class FirebaseAuthDataSource {
  Future<User> initializedUser();

  Future<String> registerWithEmailPassword({
    required String email,
    required String password
  });

  Future<User> loginWithEmailPassword({
    required String email,
    required String password
  });

  Future<String> sendVerificationEmail();

  Future<User> loginWithGoogle();

  Future<String> forgotPassword({
    required String email,
  });

  Future<void> logout();
}

class FirebaseAuthDataSourceImpl implements FirebaseAuthDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  Future<User> initializedUser() async {
    try {
      User? user = _firebaseAuth.currentUser;
      if(user == null) {
        throw const ServerException("Something went wrong");
      }
      if(!user.emailVerified) {
        throw const ServerException("Please verify your account before login");
      }
      return user;
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    }
  }

  @override
  Future<String> registerWithEmailPassword({
    required String email,
    required String password
  }) async {
    try {
      UserCredential credential = await _firebaseAuth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim());
      await credential.user!.sendEmailVerification();
      return "User registered! Please verify your account before login";
    } on FirebaseAuthException catch(e) {
      throw ServerException(e.message!);
    }
  }

  @override
  Future<User> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential credential = await _firebaseAuth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
      if(!credential.user!.emailVerified) {
        throw const ServerException("Please verify email before continue!");
      }
      return credential.user!;
    } on FirebaseAuthException catch(e) {
      throw ServerException(e.message!);
    }
  }

  @override
  Future<String> sendVerificationEmail() async {
    try {
      await _firebaseAuth.currentUser!.sendEmailVerification();
      return "Email verification resend";
    } on FirebaseAuthException catch(e) {
      throw ServerException(e.message!);
    }
  }

  @override
  Future<User> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if(googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
        return userCredential.user!;
      } else {
        throw const ServerException("Something went wrong");
      }
    } catch(e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> forgotPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return "Password Reset Email Sent";
    } on FirebaseAuthException catch(e) {
      throw ServerException(e.message!);
    }
  }

  @override
  Future<void> logout() async{
    try {
      await googleSignIn.signOut();
      FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch(e) {
      throw ServerException(e.message!);
    }
  }
}