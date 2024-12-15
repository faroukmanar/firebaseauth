
// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../pages/sign_in_page.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Settings state variables
  bool _darkModeEnabled = false;
  bool _notificationsEnabled = true;
  bool _biometricLoginEnabled = false;

  // Theme mode toggle
  void _toggleThemeMode() {
    setState(() {
      _darkModeEnabled = !_darkModeEnabled;
      // TODO: Implement theme switching logic
    });
  }

  // Notifications toggle
  void _toggleNotifications() {
    setState(() {
      _notificationsEnabled = !_notificationsEnabled;
      // TODO: Implement notification settings
    });
  }

  // Biometric login toggle
  void _toggleBiometricLogin() {
    setState(() {
      _biometricLoginEnabled = !_biometricLoginEnabled;
      // TODO: Implement biometric authentication setup
    });
  }

  // Sign out method
  void _signOut() async {
    try {
      await _auth.signOut();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => SignInScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing out: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    User? currentUser = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          // User Info Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: currentUser?.photoURL != null
                      ? NetworkImage(currentUser!.photoURL!)
                      : AssetImage('assets/profile.jpg') as ImageProvider,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentUser?.displayName ?? 'User',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        currentUser?.email ?? 'No email',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(),

          // Appearance Settings
          _buildSettingsSection(
            title: 'Appearance',
            children: [
              _buildSwitchListTile(
                title: 'Dark Mode',
                subtitle: 'Switch between light and dark themes',
                value: _darkModeEnabled,
                onChanged: (bool value) => _toggleThemeMode(),
              ),
            ],
          ),

          // Notification Settings
          _buildSettingsSection(
            title: 'Notifications',
            children: [
              _buildSwitchListTile(
                title: 'Enable Notifications',
                subtitle: 'Receive app notifications',
                value: _notificationsEnabled,
                onChanged: (bool value) => _toggleNotifications(),
              ),
            ],
          ),

          // Security Settings
          _buildSettingsSection(
            title: 'Security',
            children: [
              _buildSwitchListTile(
                title: 'Biometric Login',
                subtitle: 'Use fingerprint or face recognition',
                value: _biometricLoginEnabled,
                onChanged: (bool value) => _toggleBiometricLogin(),
              ),
            ],
          ),

          // Account Management
          _buildSettingsSection(
            title: 'Account',
            children: [
              ListTile(
                title: Text('Change Password'),
                leading: Icon(Icons.lock),
                onTap: () {
                  // TODO: Implement password change functionality
                },
              ),
              ListTile(
                title: Text('Sign Out'),
                leading: Icon(Icons.exit_to_app, color: Colors.red),
                onTap: _signOut,
              ),
            ],
          ),

          // App Info
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'App Version 1.0.0',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build settings sections
  Widget _buildSettingsSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
        ...children,
      ],
    );
  }

  // Helper method to build switch list tiles
  Widget _buildSwitchListTile({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
    );
  }
}