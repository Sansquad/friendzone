import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_blue.png'), // Ensure this path is correct
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              const SizedBox(height: 50),
              // Logo
              Image.asset(
                'assets/icons/logo_temp.png', // Ensure the image exists in this path
                height: 150,
              ),
              const SizedBox(height: 0),
              // App Name
              RichText(
                text: const TextSpan(
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
              const SizedBox(height: 60), // Increased space between text and buttons
              SizedBox(
                width: 288,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    print('Sign In Button Pressed'); // Debug print
                    Navigator.pushNamed(context, '/signin'); // Navigate to sign-in page
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // Border radius
                    ),
                  ),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 288,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/getstarted'); // Navigate to get started page
                    Navigator.pushNamed(context, '/getstarted'); // Navigate to get started page
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // Border radius
                    ),
                  ),
                  child: const Text(
                    'Create Account',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 20), // Add this SizedBox here

              const SizedBox(height: 55),
            ],
          ),
        ),
      ),
    );
  }
}
