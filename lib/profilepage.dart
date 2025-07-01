import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _usernameController = TextEditingController();
  File? _profileImage;
  String? _username;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Load saved data (if any)
  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username');
      _usernameController.text = _username ?? '';
      _profileImage = File(prefs.getString('profile_picture') ?? '');
    });
  }

  // Update the username and profile picture
  Future<void> _saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', _usernameController.text);
    if (_profileImage != null) {
      prefs.setString('profile_picture', _profileImage!.path);
    }
  }

  // Pick image from gallery
  Future<void> _pickImage() async {
  // Show a dialog for the user to choose either camera or gallery
  final ImageSource? source = await showDialog<ImageSource>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Choose an option'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera),
              title: Text('Take a Photo'),
              onTap: () {
                Navigator.pop(context, ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context, ImageSource.gallery);
              },
            ),
          ],
        ),
      );
    },
  );

  if (source != null) {
    // Pick image using the selected source (camera or gallery)
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _profileImage != null
                    ? FileImage(_profileImage!)
                    : AssetImage('assets/img/image4.jpg') as ImageProvider,
                child: _profileImage == null
                    ? Icon(Icons.camera_alt, size: 30, color: Colors.white)
                    : null,
              ),
            ),
            SizedBox(height: 20),
            
            // Username input field
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            
            // Save button
            ElevatedButton(
              onPressed: () {
                _saveUserData();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Profile updated!'),
                ));
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),

      // Move BottomNavigationBar here to ensure it is at the bottom
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // Index 2 because it's the Profile page
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              // Navigate to the Home page
              Navigator.pushNamed(context, '/home');
              break;
            case 1:
              // Navigate to the Chat page
              Navigator.pushNamed(context, '/chat');
              break;
            case 2:
              // Stay on the profile page
              break;
          }
        },
      ),
    );
  }
}
