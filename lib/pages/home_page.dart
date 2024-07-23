// //required
// import 'package:flutter/material.dart';

// class HomePage extends StatelessWidget{
//   const HomePage({super.key});


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }

// }

//GPT 
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF69B7FF), // our main backgroundcolor
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Logo
            Image.asset(
              'assets/icons/logo_temp.png', // Make sure you have your logo in this path
              height: 150,
            ),
            SizedBox(height: 0),
            // App Name
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Friend',
                    style: TextStyle(
                      fontFamily: 'TurretRoad',
                      color: Colors.black,
                      fontSize: 55,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'zone',
                    style: TextStyle(
                      fontFamily: 'TurretRoad',
                      color: Colors.white,
                      fontSize: 55,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20), // Increased space between text and buttons
            // Sign In Button
            SizedBox(height: 20), // Increased space between text and buttons
            // Sign In Button
            SizedBox(
              width: 288,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signin'); // Navigate to sign-in page
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Correct property
                  foregroundColor: Colors.black, // Correct property
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // Border radius
                  ),
                ),
                child: Text('Sign In',
                style: TextStyle(
                  fontSize: 18,
                )),
              ),
            ),
            SizedBox(height: 20),
            // Create Account Button
            SizedBox(
              width: 288,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  // Add your create account action here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Correct property
                  foregroundColor: Colors.black, // Correct property
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // Border radius
                  ),
                ),
                child: Text('Create Account',
                style: TextStyle(
                  fontSize: 18,
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
