import 'package:flutter/material.dart';

class ImageWidget extends StatefulWidget {
  final List imagelist;
  ImageWidget({required this.imagelist});

  @override
  _ImageWidgetState createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        child: Stack(
          children: [
            PageView(
              onPageChanged: (num) {
                setState(() {
                  _selectedPage = num;
                  
                });
              },
              children: [
                for (var i = 0; i < widget.imagelist.length; i++)
                  Container(
                    child: Image.network(
                      "${widget.imagelist[i]}",
                      fit: BoxFit.cover,
                    ),
                  )
              ],
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < widget.imagelist.length; i++)
                    AnimatedContainer(
                      duration: Duration(
                        milliseconds: 200
                      ),
                      curve: Curves.easeInOutCubic,
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      width: _selectedPage ==i ? 12.0 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                      color: _selectedPage ==i ? Colors.pink[900]: Colors.blueGrey[700],
                      borderRadius: BorderRadius.circular(8) ,
                      ) 
                    )
                ],
              ),
            )
          ],
        ));
  }
}
