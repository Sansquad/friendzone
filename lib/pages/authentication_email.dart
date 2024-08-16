// import 'package:flutter/material.dart';
// import 'package:flutter/gestures.dart';


// class CheckYourEmailPage extends StatefulWidget {
//   @override
//   _CheckYourEmailPageState createState() => _CheckYourEmailPageState();
// }

// class _CheckYourEmailPageState extends State<CheckYourEmailPage> {
//   final TextEditingController _codeController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context); // Navigate back to the previous screen
//           },
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         iconTheme: IconThemeData(color: Colors.black),
//       ),
//       body: Container(
//         color: Colors.white,
//         child: Center(
//           child: SingleChildScrollView(
//             padding: EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(39, 117, 0, 0),
//                   child: Text(
//                     'Check your email',
//                     style: TextStyle(
//                       fontFamily: 'BigShouldersText',
//                       fontSize: 30,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(39, 38, 0, 0),
//                   child: Text(
//                     'Please enter the 4 digit code sent to email.address@gmail.com',
//                     style: TextStyle(
//                       fontFamily: 'BigShouldersDisplay',
//                       fontSize: 17,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(39, 20, 0, 0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: List.generate(4, (index) {
//                       return Container(
//                         margin: EdgeInsets.only(right: 13),
//                         width: 66,
//                         height: 66,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           border: Border.all(
//                             color: Color(0xFF69B7FF),
//                             width: 2,
//                           ),
//                           borderRadius: BorderRadius.circular(11),
//                         ),
//                         child: Center(
//                           child: TextField(
//                             controller: _codeController,
//                             keyboardType: TextInputType.number,
//                             maxLength: 1,
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 24,
//                               color: Colors.black,
//                             ),
//                             decoration: InputDecoration(
//                               counterText: '',
//                               border: InputBorder.none,
//                             ),
//                           ),
//                         ),
//                       );
//                     }),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Center(
//                   child: SizedBox(
//                     width: 313,
//                     height: 48,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // Add your confirm action here
//                         Navigator.pushNamed(context, '/createyourprofile');

//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Color(0xFF69B7FF),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                       ),
//                       child: Text(
//                         'Confirm',
//                         style: TextStyle(
//                           fontFamily: 'BigShouldersDisplay',
//                           fontSize: 20,
//                           fontWeight: FontWeight.w600, // Semibold
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Center(
//                   child: RichText(
//                     text: TextSpan(
//                       children: [
//                         TextSpan(
//                           text: "Didn't receive the code? ",
//                           style: TextStyle(
//                             fontFamily: 'BigShouldersDisplay',
//                             fontSize: 17,
//                             fontWeight: FontWeight.w500,
//                             color: Color(0xFF818080),
//                           ),
//                         ),
//                         TextSpan(
//                           text: 'Click',
//                           style: TextStyle(
//                             fontFamily: 'BigShouldersDisplay',
//                             fontSize: 17,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                             decoration: TextDecoration.underline,
//                             },

//                               // Add your resend action h ere
                            
//                           ),
//                         ),
//                         TextSpan(
//                           text: ' to resend',
//                           style: TextStyle(
//                             fontFamily: 'BigShouldersDisplay',
//                             fontSize: 17,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 260),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


///////
///
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class CheckYourEmailPage extends StatefulWidget {
  @override
  _CheckYourEmailPageState createState() => _CheckYourEmailPageState();
}

class _CheckYourEmailPageState extends State<CheckYourEmailPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        color: Colors.white,
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
                      color: Colors.black,
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
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: 313,
                    height: 48,
                    child: ElevatedButton(
                     onPressed: () {
                        if (_auth.currentUser != null) {
                          _auth.currentUser!.reload();
                          var user = _auth.currentUser;
                          if (user != null && user.emailVerified) {
                            Navigator.pushNamed(context, '/createyourprofile');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Email not verified!'),
                              ),
                            );
                          }
                        } else {
                          print("yaho");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          fontFamily: 'BigShouldersDisplay',
                          fontSize: 20,
                          fontWeight: FontWeight.w600, // Semibold
                          color: Colors.black,
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
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = _resendVerificationEmail, //r Resend email on click
                        ),
                        TextSpan(
                          text: ' to resend',
                          style: TextStyle(
                            fontFamily: 'BigShouldersDisplay',
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
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
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Verification email resent!')),
      );
    }
  }
}
