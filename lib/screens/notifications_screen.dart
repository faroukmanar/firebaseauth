// lib/screens/notifications_screen.dart
import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // Simulated notifications list
  final List<Map<String, dynamic>> _notifications = [
    {
      'id': '1',
      'title': 'Welcome to the App',
      'subtitle': 'Thank you for joining our community!',
      'time': '2 hours ago',
      'read': false,
    },
    {
      'id': '2',
      'title': 'Profile Update',
      'subtitle': 'Your profile was successfully updated',
      'time': '1 day ago',
      'read': true,
    },
    {
      'id': '3',
      'title': 'New Feature',
      'subtitle': 'Check out our latest app update',
      'time': '3 days ago',
      'read': false,
    },
  ];

  void _markAsRead(String id) {
    setState(() {
      final index = _notifications.indexWhere((note) => note['id'] == id);
      if (index != -1) {
        _notifications[index]['read'] = true;
      }
    });
  }

  void _deleteNotification(String id) {
    setState(() {
      _notifications.removeWhere((note) => note['id'] == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        actions: [
          IconButton(
            icon: Icon(Icons.clear_all),
            onPressed: () {
              setState(() {
                _notifications.clear();
              });
            },
            tooltip: 'Clear All Notifications',
          ),
        ],
      ),
      body: _notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_off,
                    size: 100,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'No Notifications',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                final notification = _notifications[index];
                return Dismissible(
                  key: Key(notification['id']),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    _deleteNotification(notification['id']);
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: notification['read']
                          ? Colors.grey.shade300
                          : Colors.blue.shade100,
                      child: Icon(
                        Icons.notifications,
                        color: notification['read']
                            ? Colors.grey
                            : Colors.blue,
                      ),
                    ),
                    title: Text(
                      notification['title'],
                      style: TextStyle(
                        fontWeight: notification['read']
                            ? FontWeight.normal
                            : FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${notification['subtitle']} • ${notification['time']}',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    trailing: !notification['read']
                        ? IconButton(
                            icon: Icon(Icons.done),
                            onPressed: () {
                              _markAsRead(notification['id']);
                            },
                          )
                        : null,
                    onTap: () {
                      if (!notification['read']) {
                        _markAsRead(notification['id']);
                      }
                    },
                  ),
                );
              },
            ),
    );
  }
}