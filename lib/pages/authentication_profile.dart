import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class CreateYourProfilePage extends StatefulWidget {
  @override
  _CreateYourProfilePageState createState() => _CreateYourProfilePageState();
}

class _CreateYourProfilePageState extends State<CreateYourProfilePage> {
  XFile? _imageFile;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      _imageFile = pickedFile;
    });
  }


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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 55, 0, 20), // Adjust padding for positioning
                    child: Text(
                      'Create your profile',
                      style: TextStyle(
                        fontFamily: 'BigShouldersText',
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                ),
                Stack(
                  children: <Widget>[
                    Container(
                      width: 173,
                      height: 173,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                        image: _imageFile != null
                          ? DecorationImage(
                              image: FileImage(File(_imageFile!.path)),
                              fit: BoxFit.cover,
                            )
                            : null,
                      ),
                      child: ClipOval(
                      child: _imageFile == null
                        ? Container(
                          child: Padding(
                             padding: EdgeInsets.only(top: 30.0),
                            child: SvgPicture.asset(
                              'assets/icons/avatar_placeholder.svg', // Ensure the path is correct
                              width: 5,
                              height: 5,
                              fit: BoxFit.contain,
                            ),
                          ),
                            )
                            : null,
                      ),
                        ),
                      Positioned(
                      left: 130,
                      top: 130,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(0xFFF0EDED),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/camera.svg', // Ensure the path is correct
                            width: 20.43,
                            height: 15.71,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    'Tell others a little about yourself',
                    style: TextStyle(
                      fontFamily: 'BigShouldersDisplay',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.inverseSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                // removing Nickname
                // SizedBox(height: 20),
                // CustomTextField(
                //   hintText: 'Nickname',
                // ),
                SizedBox(height: 20),
                CustomTextField(
                  hintText: 'Bio',
                  height: 120,
                  maxLength: 140,
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 147,
                  height: 47,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add your next action here
                      //changed from welcometofriendzone to googlemappage for testing
                      // Navigator.pushNamed(context, '/googlemappage');
                      Navigator.pushNamed(context, '/contentlayout');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      'Next',
                      style: TextStyle(
                        fontFamily: 'BigShouldersDisplay',
                        fontSize: 20,
                        fontWeight: FontWeight.w600, // Semibold
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                  ),         
                ),
                // SizedBox(height: 300),
                Padding(
                padding: EdgeInsets.only(bottom: 200),
                 ), // Additional padding at the bottom
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  final String hintText;
  final String? suffixText;
  final Color? suffixTextColor;
  final double height;
  final int maxLength;

  const CustomTextField({
    required this.hintText,
    this.suffixText,
    this.suffixTextColor,
    this.height = 47,
    this.maxLength = 80, //change max number of characters
  });


  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller =  TextEditingController();
    _controller.addListener(_checkCharLimit);
  }

  void _checkCharLimit() {
    final text = _controller.text;
    if (text.length > widget.maxLength) {
      _controller.value = _controller.value.copyWith(
        text: text.substring(0, widget.maxLength),
        selection: TextSelection.collapsed(offset: widget.maxLength),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 315,
      height: widget.height,
      child: TextField(
        controller: _controller,
        maxLines: widget.height ~/ 20, 
        minLines: widget.height ~/ 20,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontFamily: 'BigShouldersDisplay',
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
          filled: true,
          fillColor: Colors.transparent,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.inverseSurface,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
          suffixIcon: widget.suffixText != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                  child: Text(
                    widget.suffixText!,
                    style: TextStyle(
                      color: widget.suffixTextColor ?? Colors.black,
                      fontFamily: 'BigShouldersDisplay',
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
