import 'package:flutter/material.dart';
import 'package:fl_components/theme/app_theme.dart';

// Stateful is required to repaint the changed value
class SliderScreen extends StatefulWidget {
   
  const SliderScreen({Key? key}) : super(key: key);

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {

  double _sliderValue = 100;
  bool _sliderEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sliders & Checks'),
      ),
      body: Column(
        children: [

          // adaptive     They adapt it's style to the OS
          Slider.adaptive(
            // min and max seize of the slider
            min: 50,
            max: 400,
            activeColor: AppTheme.primary,
            // divisions: 10,           // Establish determined integer range of values
            value: _sliderValue,
            onChanged: _sliderEnabled   // Ternary operator
            ? ( value ) {
                _sliderValue = value;
                setState(() {});        // Redraw with the value changed
              }
            : null
          ),

          // Checkbox(
          //   value: _sliderEnabled, 
          //   onChanged: ( value ) {
          //     _sliderEnabled = value ?? true;
          //     setState(() {});
          //   }
          // ),
          // Switch(
          //   value: _sliderEnabled, 
          //   onChanged: ( value ) => setState(() { _sliderEnabled = value; })
          // ),

          // === Checkbox, but with better style
          CheckboxListTile(
            activeColor: AppTheme.primary,
            title: const Text('Habilitar Slider'),
            value: _sliderEnabled,        // Link the CheckboxListTile's attribute with '_sliderEnabled' property
            // Ways to indicate change of state
            // 1) 1! step, passing the change as function of setState()
            onChanged: ( value ) => setState(() { _sliderEnabled = value ?? true; })
            // 2) Several steps
            // onChanged: ( value ) => {
            // _sliderEnabled = value ?? true,
            //   setState(() {  })
            // }
          ),

          // === CheckboxListTile, but with better style
          // adaptive     They adapt it's style to the OS
          SwitchListTile.adaptive(
            activeColor: AppTheme.primary,
            title: const Text('Habilitar Slider'),
            value: _sliderEnabled, 
            onChanged: ( value ) => setState(() { _sliderEnabled = value; })
          ),

          // Give information about the licenses
          const AboutListTile(),

          // Column's height is infinite. Expanded is a Widget which takes all the desired height
          Expanded(
            // SingleChildScrollView      Restrict the size and in case it overcomes the screen's size --> You will see, doing scroll
            child: SingleChildScrollView(
              child: Image(
                image: const NetworkImage('https://cdn.pixabay.com/photo/2020/07/06/17/51/batman-5377804_1280.png'),
                fit: BoxFit.contain,
                width: _sliderValue,
              ),
            ),
          ),

        ],
      )
    );
  }
}