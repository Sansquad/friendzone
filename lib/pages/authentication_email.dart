import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class CheckYourEmailPage extends StatefulWidget {
  @override
  _CheckYourEmailPageState createState() => _CheckYourEmailPageState();
}

class _CheckYourEmailPageState extends State<CheckYourEmailPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  ///
  User? user;
  ///
  @override
  void initState() {
    super.initState();
    _reloadUser();
  }
  
  void _reloadUser() async {
    User? currentUser = _auth.currentUser;

    if (currentUser != null) {
      await currentUser.reload();
      setState(() {
        user = _auth.currentUser;
      });
      }
    }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigator.pop(context); // Navigate back to the previous screen
            Navigator.pushNamed(context, '/authentication_home');
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),        
      ),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(39, 117, 0, 0),
                  child: Text(
                    'Check your email',
                    style: TextStyle(
                      fontFamily: 'BigShouldersText',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.inverseSurface,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(39, 38, 0, 0),
                  child: Text(
                    'Please click the verification link sent to your email to continue.',
                    style: TextStyle(
                      fontFamily: 'BigShouldersDisplay',
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.inverseSurface,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: 313,
                    height: 48,
                    child: ElevatedButton(
                     onPressed: () async {
                      ///
                      _reloadUser(); // make sure user is reloaded
                      ///
                      if (user != null && user!.emailVerified) {
                        Navigator.pushNamed(context, '/createyourprofile');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Email not verified!'),
                            backgroundColor: Theme.of(context).colorScheme.primary,
                          ),
                        );
                      } 

                        // if (_auth.currentUser != null) {
                        //   _auth.currentUser!.reload();
                        //   var user = _auth.currentUser;
                        //   if (user != null && user.emailVerified) {
                        //     Navigator.pushNamed(context, '/createyourprofile');
                        //   } else {
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       SnackBar(
                        //         content: Text('Email not verified!'),
                        //       ),
                        //     );
                        //   }
                        // } else {
                        //   print("yaho");
                        // }

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          fontFamily: 'BigShouldersDisplay',
                          fontSize: 23,
                          fontWeight: FontWeight.w500, // Semibold
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Didn't receive the email? ",
                          style: TextStyle(
                            fontFamily: 'BigShouldersDisplay',
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF818080),
                          ),
                        ),
                        TextSpan(
                          text: 'Click',
                          style: TextStyle(
                            fontFamily: 'BigShouldersDisplay',
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.inverseSurface,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              _resendVerificationEmail(); // Resend email on click
                              print("Resend email"); //
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Verification email resent!'),
                                  backgroundColor: Theme.of(context).colorScheme.primary,
                                  ),

                                 );
                            }

                        ),
                        TextSpan(
                          text: ' to resend',
                          style: TextStyle(
                            fontFamily: 'BigShouldersDisplay',
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.inverseSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 260),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _resendVerificationEmail() async {
    User? user = _auth.currentUser;

    print('Resend function called'); // checking to see if this is actually called
    // now if "Verification emai resent!" isn't printed, something is going wrong with the if statement

    if (user != null) {
      await user.reload();
      user = _auth.currentUser;
    }

    if (user != null) {
      print('User is not null');
      print('User email: ${user.email}');
      print('Email verified: ${user.emailVerified}');
    } else {
      print('User is null');
    }

    if (user != null && !user.emailVerified) {
      try {
      await user.sendEmailVerification();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Verification email resent!'),
        backgroundColor: Theme.of(context).colorScheme.primary,

        ),
        
      );
      print('Verification email resent!');
      } catch (e) {
        print('Error sending verification email: $e');
      }
    } else {
      print('User is null or email is already verified');
    }
  }
}
