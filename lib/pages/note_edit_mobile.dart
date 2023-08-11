import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
 // import 'dart:developer' as dev show log;
import 'note_preview_mobile.dart';

class NoteEditMobile extends StatefulWidget {
  const NoteEditMobile({super.key});

  @override
  State<NoteEditMobile> createState() => _NoteEditMobileState();
}

class _NoteEditMobileState extends State<NoteEditMobile> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                  controller: _controller,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter some markdown note..."),
                  onChanged: (String content) {
                    //setState(() {
                    data = content;
                    // });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "editBtn",
        onPressed: () {
          Navigator.of(context).push(
            _createRoute(data),
          );
        },
        backgroundColor: Colors.grey[500],
        child: const Icon(
          Ionicons.eye_outline,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
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
