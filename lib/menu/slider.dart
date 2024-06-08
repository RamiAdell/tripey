import 'package:flutter/material.dart';
import 'package:my_app/url/builder.dart';

class SliderExample extends StatefulWidget {
  const SliderExample({Key? key});

  @override
  State<SliderExample> createState() => _SliderExampleState();
}

class _SliderExampleState extends State<SliderExample> {
  double _currentSliderValue = 1.5; // Initial value set to 2

  @override
  Widget build(BuildContext context) {
    String label;
    if (_currentSliderValue == 0) {
      label = '\$'; // Display $ for value 0
    } else if (_currentSliderValue == 1.5) {
      label = '\$\$'; // Display $$ for value 1.5
    } else if (_currentSliderValue == 3) {
      label = '\$\$\$'; // Display $$$ for value 3
    } else {
      label = _currentSliderValue.round().toString();
    }

    return Slider(
      activeColor: Color(0xff1CB78D),
      thumbColor: Color(0xff052C47),
      value: _currentSliderValue,
      min: 0,
      max: 3,
      divisions: 2,
      label: label,
      onChanged: (double value) {
        setState(() {
          _currentSliderValue = value;

          BuilderClass().setPrice(value);
        });
      },
    );
  }
}
