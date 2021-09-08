import 'package:flutter/material.dart';

class RingSize extends StatefulWidget {
  final List size;
  final Function(String) onSelected;

  RingSize({required this.size, required this.onSelected});

  @override
  _RingSizeState createState() => _RingSizeState();
}

class _RingSizeState extends State<RingSize> {
  int _selecteSize = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        children: [
          for (var i = 0; i < widget.size.length; i++)
            GestureDetector(
              onTap: () {
                setState(() {
                  //it passses the selected size of the ring
                  widget.onSelected("${widget.size[i]}");
                  _selecteSize = i;
                });
              },
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                    color: _selecteSize == i
                        ? Colors.pink[900]
                        : Colors.grey.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(8.0)),
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(
                  "${widget.size[i]}",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 16),
                ),
              ),
            )
        ],
      ),
    );
  }
}
