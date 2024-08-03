import 'package:flutter/material.dart';
import '../pages/home_page.dart';

class SplashScreen extends StatefulWidget {
  final Widget? child;
  const SplashScreen({super.key, this.child});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
  }

class _SplashScreenState extends State<SplashScreen> {

  @override
    void initState() {
      Future.delayed(
        Duration(seconds: 3),(){
          Navigator.pushAndRemoveUntil(context, 
          // MaterialPageRoute(builder:(context)=>widget.child!), (route) => false);
          MaterialPageRoute(builder:(context)=>HomePage()), (route) => false);
        }
      );
      super.initState();
  }


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
      child : Center(
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
                      text: 'Welcome to Friend',
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
            ],
          ),
        ),
       ),
    );
  }
}
