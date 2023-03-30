import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/authform.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthScreen extends StatefulWidget {

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;
  

  _submitAuthForm(
    String email,
    String username,
    String password,
    var image,
    bool isLogin,
    BuildContext ctx,
  ) async {
    // FirebaseFirestore.instance.
    UserCredential authResult;
    
    try {
      // print("inside try");
      setState(() {
        _isLoading=true;
      });
    if(isLogin) {
      authResult = await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password,
        );
    }
    else{
       authResult = await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password,
        );
   

    //Uploading image to firebase storage
    final ref = FirebaseStorage.instance
    .ref()
    .child('user_image')
    .child(authResult.user!.uid+ '.jpg');
    

    final TaskSnapshot snapshot = await ref.putFile(image);
    // final storageSnapshot = uploadTask.snapshot;
    final url = await snapshot.ref.getDownloadURL();


    // print("Adding new user to users");
        //Adding the extra user data to firestore
    FirebaseFirestore firestore = FirebaseFirestore.instance;    
    await firestore.collection('users').doc(authResult.user!.uid).set(
      {
        'username': username,
        'email' : email,
        'image_url' : url,
      },
      SetOptions(merge: true),
    ).onError(
      (error, _) => print("Error writing document: $error")
    );
    }


    }
    on PlatformException catch (err) {
      var message = "An error occured, please check your credential!";
      if (mounted) {
      setState(() {
        _isLoading = false;
      });
      }
      if(err.message != null){
        message = err.message!;
      }
      // print
        ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Theme.of(context).errorColor,
            )
          );
    }catch(err) {
      if (mounted) {
      setState(() {
        _isLoading = false;
      });
      }
      // print(err);
      // print("hello");
      ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(
            content: Text(err.toString().substring(err.toString().indexOf(']')+1)),
            backgroundColor: Theme.of(context).errorColor,
            )
          );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm, _isLoading),
    );
  }
}