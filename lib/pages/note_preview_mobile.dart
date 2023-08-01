import 'package:flutter/material.dart';
import 'package:flutter_highlight/themes/atom-one-light.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:note_app/pages/note_edit_mobile.dart';

class PreviewPageMobile extends StatelessWidget {
  const PreviewPageMobile({super.key, required this.data});

  final String data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PreviewPage(
        data: data,
      ),
    );
  }
}

class PreviewPage extends StatelessWidget {
  const PreviewPage({super.key, required this.data});

  final String data;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Preview'),
          backgroundColor: Colors.red[200],
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: MarkdownWidget(
                  data: data,
                  config: MarkdownConfig(configs: [
                    LinkConfig(
                        style: GoogleFonts.rubik(
                      color: Colors.red,
                      decoration: TextDecoration.underline,
                    )),
                    CodeConfig(
                      style: GoogleFonts.sourceCodePro(
                        fontSize: 16.0,
                      ),
                    ),
                    const PreConfig(
                      language: 'dart',
                      theme: atomOneLightTheme,
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pop(
              MaterialPageRoute(
                builder: (context) => const MaterialApp(
                  home: NoteView(),
                ),
              ),
            );
          },
          backgroundColor: Colors.grey[500],
          child: const Icon(
            Ionicons.eye_off_outline,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}


            // SizedBox(
            //   child: Padding(
            //     padding: const EdgeInsets.all(20.0),
            //     child: Align(
            //       alignment: Alignment.bottomRight,
            //       child: SizedBox.fromSize(
            //         size: const Size(56, 56),
            //         child: ClipOval(
            //           child: Material(
            //             color: Colors.black26,
            //             child: InkWell(
            //               //splashColor: Colors.,
            //               onTap: () {
            //                 Navigator.of(context).pop(
            //                   MaterialPageRoute(
            //                     builder: (context) => const MaterialApp(
            //                       home: EditPageMobile(),
            //                     ),
            //                   ),
            //                 );
            //               },
            //               child: const Column(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: <Widget>[
            //                   Icon(
            //                     Ionicons.eye_off_outline,
            //                     color: Colors.white,
            //                     size: 30,
            //                   ), // <-- Icon // <-- Text
            //                 ],
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),