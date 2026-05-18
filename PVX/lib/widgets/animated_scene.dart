
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'theme_style.dart';

class AnimatedScene extends StatefulWidget {
  final String theme;
  const AnimatedScene({super.key, required this.theme});
  @override State<AnimatedScene> createState() => _AnimatedSceneState();
}

class _AnimatedSceneState extends State<AnimatedScene> with SingleTickerProviderStateMixin {
  late final AnimationController c;
  @override void initState(){super.initState(); c=AnimationController(vsync:this,duration:const Duration(seconds:8))..repeat();}
  @override void dispose(){c.dispose(); super.dispose();}
  @override Widget build(BuildContext context){
    final s=styleFor(widget.theme);
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        height: 180,
        decoration: BoxDecoration(gradient: LinearGradient(colors:[s.primary,s.secondary],begin:Alignment.topLeft,end:Alignment.bottomRight)),
        child: LayoutBuilder(builder:(context,box){
          return Stack(children:[
            Positioned(left:20,top:22,child:Text('${s.emoji} ${widget.theme}',style:const TextStyle(color:Colors.white,fontSize:30,fontWeight:FontWeight.w900))),
            const Positioned(left:22,bottom:20,right:20,child:Text('Choisis une phrase ou écris ton texte. L’IA adapte la traduction au contexte.',style:TextStyle(color:Colors.white,fontSize:16,fontWeight:FontWeight.w700))),
            ...List.generate(s.sprites.length,(i)=>AnimatedBuilder(animation:c,builder:(_,__){
              final reverse=i.isOdd; final v=(c.value+i*.19)%1; final x= reverse ? box.maxWidth+60-v*(box.maxWidth+140) : -60+v*(box.maxWidth+140); final y=55+(i*22)%90+math.sin((c.value*math.pi*2)+i)*10;
              return Positioned(left:x,top:y,child:Transform.rotate(angle:math.sin(c.value*math.pi*2+i)*.2,child:Text(s.sprites[i],style:TextStyle(fontSize:32+(i%3)*8,shadows:const[Shadow(color:Colors.black26,blurRadius:8,offset:Offset(0,3))]))));
            }))
          ]);
        }),
      ),
    );
  }
}
