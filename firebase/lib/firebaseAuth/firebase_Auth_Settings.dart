import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthSettings {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  void authStateChange() {
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        debugPrint('User is currently signed out!');
      } else {
        
        debugPrint('User is signed in! ${user.uid}}');
      }
    });
  }

  Future<void> get signOutUser async =>
      _auth.currentUser != null ? await _auth.signOut() : null;

  Future<void> get currentUserDisplayName async => debugPrint("display name = ${_auth.currentUser?.displayName} "); 
  Future<void> get currentUserEmail async => debugPrint("email = ${_auth.currentUser?.email} "); 
  Future<void> get currentUserMetaData async => debugPrint("metadata = ${_auth.currentUser?.metadata} "); 
  Future<void> get currentUserMultiFactor async => debugPrint("MultiFactor = ${_auth.currentUser?.multiFactor} "); 
  Future<void> get currentUserProviderData async => debugPrint("ProviderData = ${_auth.currentUser?.providerData} "); 
  Future<void> get currentUserRefreshToken async => debugPrint("refresh Token = ${_auth.currentUser?.refreshToken} "); 
  Future<void> get currentUserTenantID async => debugPrint("tenant ID = ${_auth.currentUser?.tenantId} "); 
  Future<void> get currentUserUID async => debugPrint("uid = ${_auth.currentUser?.uid} ");
  Future<void> get currentUserGetIdToken async => debugPrint("get Id Token = ${await _auth.currentUser?.getIdToken()} "); 
  Future<void> get currentUserGetIdTokenResult async => debugPrint("get Id Token result = ${await _auth.currentUser?.getIdTokenResult()} ");  

  void idTokenChanges() {
    _auth.idTokenChanges().listen((User? user) {
      if (user == null) {
        debugPrint('User is currently signed out!');
      } else {
        debugPrint('User is signed in!');
      }
    });
  }

  void userChanges() {
    _auth.userChanges().listen((User? user) {
      if (user == null) {
        debugPrint('User is currently signed out!');
      } else {
        debugPrint('User is signed in!');
      }
    });
  }

  

  Future<void> createUserWithEmailAndPassword(
      String emailAddress, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> signInWithEmailAndPassword(
      String emailAddress, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
    } catch (e) {
      debugPrint(e.toString());
    }
  }

   Future<void> applyActionCode(
      ) async {
    try {
      final credential = await _auth.applyActionCode("yeniActionCode");
    } on FirebaseAuthException catch (e) {
      debugPrint("applyActionCode "+e.toString());
    } catch (e) {
      debugPrint("applyActionCode"+e.toString());
    }
  }

  Future<void> checkActionCode(
      ) async {
    try {
      final credential = await _auth.checkActionCode("CheckActionCode");
      debugPrint("checkActionCode data = ${credential.data}");
      debugPrint("checkActionCode operation = ${credential.operation}");
    } on FirebaseAuthException catch (e) {
      debugPrint("applyActionCode "+e.toString());
    } catch (e) {
      debugPrint("applyActionCode"+e.toString());
    }
  }

  Future<void> changePassword() async {
    try {
      final cre = await _auth.currentUser?.updatePassword("654321");
    } on FirebaseAuthException catch (e) {
    } catch (e) {
      debugPrint("changePassword = " + e.toString());
    }
  }

  Future<void> updateEmail() async {
    try {
      final cre = await _auth.currentUser?.updateEmail("colorroloc@gmail.com");
    } on FirebaseAuthException catch (e) {
      debugPrint("update Email = " + e.toString());
    } catch (e) {
      debugPrint("update Email = " + e.toString());
    }
  }
  

  Future<void> sendEmailVerification() async {
    try {
      final cre = await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      debugPrint("verification email = " + e.toString());
    } catch (e) {
      debugPrint("verification email = " + e.toString());
    }
  }

  Future<void> isEmailAdressVerified() async {
    try {
      final cre = _auth.currentUser?.emailVerified;
      debugPrint("email adress verified = $cre");
    } on FirebaseAuthException catch (e) {
      debugPrint("verification email = " + e.toString());
    } catch (e) {
      debugPrint("verification email = " + e.toString());
    }
  }

  Future<void> reload() async {
    try {
      final cre = _auth.currentUser?.reload();
      debugPrint("reload = $cre");
    } on FirebaseAuthException catch (e) {
      debugPrint("reload = " + e.toString());
    } catch (e) {
      debugPrint("reload = " + e.toString());
    }
  }

  

  Future<void> deleteCurrentUser() async {
    try {
      await _auth.currentUser?.delete();
      debugPrint("Current user deleted");
    } on FirebaseAuthException catch (e) {
      debugPrint("verification email = " + e.toString());
    } catch (e) {
      debugPrint("verification email = " + e.toString());
    }
  }

  

  Future<void> verifyBeforeUpdateEmail(String newEmail) async {
    try {
      assert(_auth.currentUser!=null,true);
      final cre = await _auth.currentUser!.verifyBeforeUpdateEmail(newEmail);
      debugPrint("verifyBeforeUpdateEmail");
    } on FirebaseAuthException catch (e) {
      debugPrint("verifyBeforeUpdateEmail= " + e.toString());
    } catch (e) {
      debugPrint("verifyBeforeUpdateEmail= " + e.toString());
    }
  }

  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    debugPrint("accessToken ${credential.accessToken}");
    debugPrint("idToken  ${credential.idToken}");
    debugPrint("token ${credential.token}");

    await _auth.signInWithCredential(credential);
  }

  Future<void> verifyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      timeout: const Duration(seconds: 60),
      phoneNumber: '+44 7123 123 456',
      autoRetrievedSmsCodeForTesting: "123456",
      verificationCompleted: (PhoneAuthCredential credential) async {
        debugPrint("verificationCompleted PhoneAuthCredential = ${credential}");
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        debugPrint("verificationCompleted FirebaseAuthException = ${e}");
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        debugPrint(
            "verificationCompleted verificationId = ${verificationId} | resendToken ${resendToken}");
        String smsCode = 'xxxx';

        // Create a PhoneAuthCredential with the code
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode);

        // Sign the user in (or link) with the credential
        await _auth.signInWithCredential(credential);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        debugPrint("verificationCompleted verificationId = ${verificationId} ");
      },
    );
  }

  Future<void> signInAnonymously() async {
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      print("Signed in with temporary account.");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
    }
  }

  Future<void> linkAccounts(String emailAddress, String password) async {
    // Google Sign-in
    final credentialGoogle = GoogleAuthProvider.credential(idToken: "xxx");

// Email and password sign-in
    final credentialEmail =
        EmailAuthProvider.credential(email: emailAddress, password: password);
    try {
      final userCredential = await FirebaseAuth.instance.currentUser
          ?.linkWithCredential(credentialGoogle);
      debugPrint("info = ${userCredential?.additionalUserInfo?.providerId}");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "provider-already-linked":
          print("The provider has already been linked to the user.");
          break;
        case "invalid-credential":
          print("The provider's credential is not valid.");
          break;
        case "credential-already-in-use":
          print("The account corresponding to the credential already exists, "
              "or is already linked to a Firebase User.");
          break;
        // See the API reference for the full list of error codes.
        default:
          print("Unknown error.");
      }
// Etc.
    }
  }

  Future<void> unLinkAccounts(String providerId) async {
    try {
      await FirebaseAuth.instance.currentUser?.unlink("xxx");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "no-such-provider":
          print("The user isn't linked to the provider or the provider "
              "doesn't exist.");
          break;
        default:
          print("Unkown error.");
      }
    }
  }
}

const idToken =
    "eyJhbGciOiJSUzI1NiIsImtpZCI6IjE3MjdiNmI0OTQwMmI5Y2Y5NWJlNGU4ZmQzOGFhN2U3YzExNjQ0YjEiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI5NjgxNDEzODkyOTYtZnM0YzdrNmFjN3IyaTYxZmkwN3NwamJrbTEyazJrbGEuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiI5NjgxNDEzODkyOTYtODFjcWJ1cnMxdmplcGdzZTRoa29wZGEwZWM0ZW00ZHQuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMDk0MTAxNjY5NjE5MDA3MzIxMTkiLCJlbWFpbCI6Imhhc2FubG9sb2wyMDAyQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJuYW1lIjoiUHJvIEdhbWVyIiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hL0FJdGJ2bWxwYVVsVi15UjhBVGxYZnRndWNGZEJvM2pCRkR5dGxXcVhDM3dpPXM5Ni1jIiwiZ2l2ZW5fbmFtZSI6IlBybyIsImZhbWlseV9uYW1lIjoiR2FtZXIiLCJsb2NhbGUiOiJ0ciIsImlhdCI6MTY2MDc3NTczMywiZXhwIjoxNjYwNzc5MzMzfQ.Nqtsq7GYW-WLwugW6xW_WQBEdwk12x0PcDDQ8UTv_TtVPqNbEGIvOt30y_kOitBY6v0Uc0uRZQ8l8J_mn-9mbiz11dK2_HFK4VfACl73TO0R2X5u-PuzLzoVpehXz4W38ajMuW5tNcDXDAdJrjLxCcPIFrpzR9ERJIi9mHYGiJ2IdxhgmLSRcM5lp3gjScQHE8_ukKQzmrUUqKUct0XHjLWoWMNLbbzvtpHg296QbWjVO0r7w7LnJ7JHwoH6";
