import 'package:flutter/material.dart';  

class LogoFitControl extends StatelessWidget {  
  final double height;  

  const LogoFitControl({super.key, this.height = 40});  

  @override  
  Widget build(BuildContext context) {  
    return Image.asset(  
      'assets/images/logo_FitControl.pjeg',  
      height: height,  
    );  
  }  
}  