import 'dart:io';
import 'package:flutter/material.dart';
import '../widgets/pickers/user_image.dart';

class AuthForm extends StatefulWidget {
  final void Function(
    String email,
    String username,
    String password,
    File image,
    bool isLogin,
    BuildContext context) submitFn; 
  final bool isLoading;

  AuthForm(this.submitFn, this.isLoading);
  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
    final _formKey = GlobalKey<FormState>();
    var _isLogin = true;
    String _userEmail = "";
    String _userPassword = "";
    String _userUsername = "";
    File _userImageFile = File("");

  void _getPickedImage(File image){
    _userImageFile = image;
  }


  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    //For closing keyboard if it is open
    FocusScope.of(context).unfocus();
    // print("This is the path ${_userImageFile}");
    // print();
    if(!_isLogin && !_userImageFile.existsSync()){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please pick an image"),
          backgroundColor: Theme.of(context).errorColor,
          )
      );
      return;
    }
    if(isValid)
       _formKey.currentState!.save();
    // print("Before");   
    widget.submitFn(
      _userEmail.trim(),
      _userUsername.trim(),
      _userPassword,
      _userImageFile,
      _isLogin,
      context
      );      
    // print(_userEmail);   
    // print(_userPassword);   
    // print(_userUsername);   
    //Now we can send these values to firebase
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if(!_isLogin)
                    UserImagePicker(_getPickedImage),
                    TextFormField(
                      key: ValueKey("Email"),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                      ),
                      validator: (value) {
                        if (value!.isEmpty|| !value.contains("@")) {
                          return "Please enter a valid email address";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userEmail = value!;
                      },
                    ),
                    if(!_isLogin)
                    TextFormField(
                      key: ValueKey("Username"),
                      decoration: InputDecoration(
                        labelText: 'Username',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter username";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _userUsername = newValue!;
                      },
                    ),
                    TextFormField(
                      key: ValueKey("Password"),
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 7) {
                          return "Password should contain atleast 7 characters";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _userPassword = newValue!;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if(!widget.isLoading)
                    ElevatedButton(
                      onPressed: _trySubmit,
                      child: Text(_isLogin?"Login":"Sign up"),
                      ),
                    if(widget.isLoading)
                    CircularProgressIndicator(),  
                    if(!widget.isLoading)
                    TextButton(
                      onPressed: () {
                        setState(() {
                        _isLogin = !_isLogin;
                        });
                      }, 
                      child: _isLogin ? Text("Create new account")
                      : Text("I already have an account"),
                    )  

                  ],

                ),
              ),
          ),
        )
      )
    );
  }
}