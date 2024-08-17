import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface, // Use the theme's surface color
      body: Container(

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              const SizedBox(height: 50),
              // Logo
              // Image.asset(
              //   'assets/icons/logo_temp.png', // Ensure the image exists in this path
              //   height: 150,
              // ),
              SvgPicture.asset(
                'assets/icons/auth_logo.svg', // Ensure the image exists in this path
                height: 150,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.inverseSurface,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(height: 20),
              // App Name
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Friend',
                      style: TextStyle(
                        fontFamily: 'TurretRoad',
                        color: Theme.of(context).colorScheme.inverseSurface,
                        
                        fontSize: 55,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'zone',
                      style: TextStyle(
                        fontFamily: 'TurretRoad',
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 55,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40), // Increased space between text and buttons
              SizedBox(
                width: 288,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    print('Sign In Button Pressed'); // Debug print
                    Navigator.pushNamed(context, '/signin'); // Navigate to sign-in page
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // Border radius
                    ),
                  ),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 23,
                      fontFamily: 'BigShouldersDisplay',
                      fontWeight: FontWeight.w800,
                      ),
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
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // Border radius
                    ),
                  ),
                  child: const Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 23,
                      fontFamily: 'BigShouldersDisplay',
                      fontWeight: FontWeight.w800,
                      ),
                  ),
                ),
              ),
              const SizedBox(height: 20), // Add this SizedBox here


              //Google Maps Testing Button
              // SizedBox(
              //   width : 100,
              //   height : 100,
              //   child: ElevatedButton(
              //     onPressed:(){
              //       Navigator.pushNamed(context, '/testmap');
              //     },
              //     child : const Text(
              //       'test',
              //       style: TextStyle(
              //       ),
              //     )
              //   ),
              // ),


              const SizedBox(height: 55),
            ],
          ),
        ),
      ),
    );
  }
}
