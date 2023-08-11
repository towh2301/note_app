import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_app/pages/note_edit_mobile.dart';
import 'dart:developer' as dev show log;
import 'package:note_app/routes/routes.dart';
import 'note_preview_mobile.dart';

enum MenuItem {
  logout,
}

class NoteView extends StatefulWidget {
  const NoteView({super.key});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  int _selectedIndex = 0;
  String data = "";

  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  static const List<Widget> _widgetOptions = <Widget>[
    NoteEditMobile(),
    Text('Index 1: Tag View'),
    Text('Index 2: Profile'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note View'),
        backgroundColor: Colors.red[200],
        actions: [
          PopupMenuButton(onSelected: (value) async {
            switch (value) {
              case MenuItem.logout:
                {
                  final doLogout = await showLogoutDialog(context);
                  dev.log(doLogout.toString());
                  if (doLogout) {
                    await FirebaseAuth.instance.signOut();

                    // Navigate to login page and remove all routes
                    if (context.mounted) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        loginRoute,
                        (_) => false,
                      );
                    }
                  }
                }
            }
          }, itemBuilder: (context) {
            return const [
              PopupMenuItem(
                value: MenuItem.logout,
                child: Text('Logout'),
              ),
            ];
          })
        ],
      ),
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      drawer: SizedBox(
        width: 250,
        child: Drawer(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(0), bottomRight: Radius.circular(0)),
          ),
          child: ListView(
            children: [
              const SizedBox(
                height: 64,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 147, 187, 255),
                  ),
                  child: Text('Drawer Header'),
                ),
              ),
              ListTile(
                title: const Text('Item 0'),
                selected: _selectedIndex == 0,
                onTap: () {
                  _onItemTapped(0);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Item 1'),
                selected: _selectedIndex == 1,
                onTap: () {
                  _onItemTapped(1);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Item 2'),
                selected: _selectedIndex == 2,
                onTap: () {
                  _onItemTapped(2);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Show dialog for logout confirmation
Future<bool> showLogoutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel')),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Logout')),
        ],
      );
    },
  ).then((value) => value ?? false);
}

// Edit note widget
Widget noteEditWidget(TextEditingController controller, String data) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: TextField(
              focusNode: FirstTapDisabledFocusNode(),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: controller,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter some markdown note..."),
              onChanged: (String content) {
                data = content;
              },
            ),
          ),
        ),
      ),
    ],
  );
}

// Disable first tap on text field
class FirstTapDisabledFocusNode extends FocusNode {
  @override
  bool consumeKeyboardToken() {
    return false;
  }
}

// Route for preview page
Route _createRoute(String data) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => PreviewPageMobile(
      data: data,
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}
