import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AlertScreen extends StatelessWidget {
   
  const AlertScreen({Key? key}) : super(key: key);

  // Since this class comes from StatelessWidget --> Required to pass by argument. If it would be StatefulWidget --> Unnecessary to pass by argument
  void displayDialogIOS( BuildContext context ) {

    // Use cupertino dialog, which follows IOS's style
    showCupertinoDialog(
      barrierDismissible: false,
      context: context, 
      builder: ( context ) {
        return CupertinoAlertDialog(
          title: const Text('Titulo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text('Este es el contenido de la alerta'),
              SizedBox( height: 10 ),
              FlutterLogo( size: 100 )
            ],
          ),
          actions: [

            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar', style: TextStyle( color: Colors.red ))
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Ok')
            ),

          ],
        );
      }
    );

  }

  void displayDialogAndroid(BuildContext context) {
    
    showDialog(
      barrierDismissible: false,  // barrierDismissible   Allows closing the dialog, clicking in the shadow
      context: context, 
      builder: ( context ) {    // builder    Function with context by argument, which returns a Widget

        return AlertDialog(
          elevation: 5,
          title: const Text('Titulo'),
          shape: RoundedRectangleBorder( borderRadius: BorderRadiusDirectional.circular(10) ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text('Este es el contenido de la alerta'),
              SizedBox( height: 10 ),
              FlutterLogo( size: 100 )
            ],
          ),
          actions: [

            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar')
            ),

            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Ok')
            ),

          ],
        );
        
      }
    );
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
         child: ElevatedButton(
          //  style: ElevatedButton.styleFrom(
          //    primary: Colors.red,
          //    shape: const StadiumBorder(),
          //    elevation: 0
          //  ),
           child: const Padding(
             padding: EdgeInsets.symmetric( horizontal: 20, vertical: 15 ),
             child: Text('Mostrar alerta', style: TextStyle( fontSize: 16 )),
           ),
          //  onPressed: () => displayDialogAndroid( context )
           onPressed: () => Platform.isAndroid      // Platform   Class to determine the OS
                // Set different logic based on platform, because the alerts' style is different
                ? displayDialogAndroid( context )
                : displayDialogIOS( context )
         ) 
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon( Icons.close ),
        onPressed: () => Navigator.pop(context) 
      ),
    );
  }
}