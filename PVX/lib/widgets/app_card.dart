
import 'package:flutter/material.dart';
class AppCard extends StatelessWidget {
  final Widget child; final Color? color; final EdgeInsetsGeometry padding;
  const AppCard({super.key, required this.child, this.color, this.padding=const EdgeInsets.all(18)});
  @override Widget build(BuildContext context)=>Card(color:color,child:Padding(padding:padding,child:child));
}
