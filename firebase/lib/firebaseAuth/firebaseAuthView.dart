import 'package:firebase/firebaseAuth/firebase_Auth_Settings.dart';
import 'package:flutter/material.dart';

class firebaseAuth extends StatefulWidget {
  firebaseAuth({Key? key}) : super(key: key);

  @override
  State<firebaseAuth> createState() => _firebaseAuthState();
}

class _firebaseAuthState extends State<firebaseAuth> {

  late AuthSettings authSettings;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    authSettings = AuthSettings();
    authSettings.authStateChange();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
      child: SingleChildScrollView(
        child: Column(
        children: [
          ElevatedButton(onPressed: (){
            authSettings.authStateChange();
          }, child: Text("AuthStateChanges")),
          ElevatedButton(onPressed: (){
            authSettings.currentUserDisplayName;
            authSettings.currentUserEmail;
            authSettings.currentUserGetIdToken;
            authSettings.currentUserGetIdTokenResult;
            authSettings.currentUserMetaData;
            authSettings.currentUserMultiFactor;
            authSettings.currentUserProviderData;
            authSettings.currentUserRefreshToken;
            authSettings.currentUserTenantID;
            authSettings.currentUserUID;

          }, child: Text("info")),
          ElevatedButton(onPressed: (){
            authSettings.createUserWithEmailAndPassword("hasanlol2002@gmail.com","123456");
          }, child: Text("createAccountWihtEmailAndPassword")),
          ElevatedButton(onPressed: (){
            authSettings.signInWithEmailAndPassword("hasanlol2002@gmail.com","123456");
          }, child: Text("signAccountWihtEmailAndPassword")),
          ElevatedButton(onPressed: (){
            authSettings.changePassword();
          }, child: Text("changePassword")),
          ElevatedButton(onPressed: (){
            authSettings.sendEmailVerification();
          }, child: Text("send email verification")),
          ElevatedButton(onPressed: (){
            authSettings.isEmailAdressVerified();
          }, child: Text("is Email verified?")),
          ElevatedButton(onPressed: (){
            authSettings.updateEmail();
          }, child: Text("update email")),
          ElevatedButton(onPressed: (){
            authSettings.verifyBeforeUpdateEmail("hasanlolol2002@gmail.com");
          }, child: Text("verifyBeforeUpdateEmail")),
          ElevatedButton(onPressed: (){
            authSettings.reload();
          }, child: Text("reload")),
          ElevatedButton(onPressed: (){
            authSettings.deleteCurrentUser();
          }, child: Text("delete current User")),
          ElevatedButton(onPressed: (){
            authSettings.signInWithGoogle();
          }, child: Text("signWithGoogle")),
          ElevatedButton(onPressed: (){
            authSettings.signInAnonymously();
          }, child: Text("signAnonymously")),
          ElevatedButton(onPressed: (){
            authSettings.verifyPhoneNumber();
          }, child: Text("verifyPhoneNumber")),
          ElevatedButton(onPressed: (){
            authSettings.linkAccounts("hasanlol2002@gmail.com", "123456");
          }, child: Text("linkedAccount")),
          ElevatedButton(onPressed: (){
            authSettings.unLinkAccounts("12345");
          }, child: Text("unLinkAccount")),
          ElevatedButton(onPressed: (){
            authSettings.signOutUser;
          }, child: Text("signOut")),
          
        ],
      ),
      ),
    ),
    );
  }
}