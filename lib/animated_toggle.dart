import 'package:flutter/material.dart';

class AnimatedTogglee extends StatefulWidget {

  final List<String> values;
  final ValueChanged<bool> onToggleCallback;
  final Color backgroundColor;
  final Color buttonColor;
  final Color textColor;

  AnimatedTogglee({
    required this.values,
    required this.onToggleCallback,
    this.backgroundColor = const Color.fromARGB(255, 255, 255, 255),
    this.buttonColor =     const Color.fromARGB(255, 144, 197, 22),
    this.textColor = const Color(0xFF000000),
  });

  @override
  _AnimatedToggleeState createState() => _AnimatedToggleeState();
}

class _AnimatedToggleeState extends State<AnimatedTogglee> {
  bool initialPosition = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        initialPosition = !initialPosition;
        bool isSelected = initialPosition;
        widget.onToggleCallback(isSelected);
        setState(() {});
      },
      child: Container(
        width: 150, // Increased the width of the outer Container
        height: MediaQuery.of(context).size.width * 0.13,
        margin: EdgeInsets.all(36),
        child: Stack(
          children: <Widget>[
            Container(
              width: 150, // Increased the width of the inner Container
              height: MediaQuery.of(context).size.width * 0.13,
              decoration: ShapeDecoration(
                color: widget.backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  widget.values.length,
                  (index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      widget.values[index],
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xAA000000),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              curve: Curves.decelerate,
              alignment: initialPosition ? Alignment.centerLeft : Alignment.centerRight,
              child: Container(
                width: 90, // Increased the width of the animated button
                height: MediaQuery.of(context).size.width * 0.13,
                decoration: ShapeDecoration(
                  color: widget.buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.1),
                  ),
                ),
                child: Center(
                  child: Text(
                    initialPosition ? widget.values[0] : widget.values[1],
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      color: widget.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
