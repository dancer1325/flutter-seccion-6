import 'package:fl_components/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomCardType2 extends StatelessWidget {

  final String imageUrl;
  final String? name;
  
  const CustomCardType2({
    Key? key, 
    required this.imageUrl, 
    this.name
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,     // Fit (cut, shorten, ...) the content
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18)
      ),
      elevation: 30,
      shadowColor: AppTheme.primary.withOpacity(0.5),
      child: Column(
        children: [

          FadeInImage(
            image: NetworkImage( imageUrl ), 
            placeholder: const AssetImage('assets/jar-loading.gif'),
            width: double.infinity,   // Take all the available width. If you use it in a Widget with flexible width --> Infinite loop
            height: 230,
            fit: BoxFit.cover,
            fadeInDuration: const Duration(milliseconds: 300),
          ),

          // Add the container, and using a default name if it's not sent by arguments
          // Container(
          //     alignment: AlignmentDirectional.centerEnd,
          //     padding: const EdgeInsets.only( right: 20, top: 10, bottom: 10 ),
          //     child: Text( name ?? 'No Title' )
          // )

          if ( name != null )
            Container(
              alignment: AlignmentDirectional.centerEnd,
              padding: const EdgeInsets.only( right: 20, top: 10, bottom: 10 ),
              child: Text( name! )   // We manage that name is null, because we have set up the previous if conditional
            )

        ],
      )
    );
  }
}