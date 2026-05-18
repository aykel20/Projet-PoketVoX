
import 'package:flutter/material.dart';
import '../models/app_user.dart';
import '../models/translation_record.dart';
import '../widgets/app_card.dart';

class ProfileScreen extends StatelessWidget { final AppUser user; final List<TranslationRecord> records; final VoidCallback onLogout; const ProfileScreen({super.key,required this.user,required this.records,required this.onLogout});
  @override Widget build(BuildContext context){ final fav=records.where((r)=>r.favorite).length; final themes=records.map((r)=>r.theme).toSet().length; final progress=(records.length/30).clamp(0.0,1.0).toDouble(); return ListView(padding:const EdgeInsets.all(18),children:[
    AppCard(color:const Color(0xFFEDEAFF),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Icon(Icons.person,size:44,color:Color(0xFF6C5CE7)),const SizedBox(height:10),Text(user.name,style:const TextStyle(fontSize:28,fontWeight:FontWeight.w900)),const Text('Suivi personnel PoketVoX',style:TextStyle(color:Colors.black54))])), const SizedBox(height:12),
    AppCard(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Row(children:[const Expanded(child:Text('Objectif compte : 30 phrases',style:TextStyle(fontWeight:FontWeight.w900,fontSize:18))),Text('${records.length}/30')]),const SizedBox(height:12),LinearProgressIndicator(value:progress,minHeight:14,borderRadius:BorderRadius.circular(20))])), const SizedBox(height:12),
    Row(children:[Expanded(child:_stat('Traductions','${records.length}',Icons.translate,Colors.purple)),const SizedBox(width:10),Expanded(child:_stat('Favoris','$fav',Icons.star,Colors.orange))]), const SizedBox(height:10),
    Row(children:[Expanded(child:_stat('Situations','$themes',Icons.category,Colors.teal)),const SizedBox(width:10),Expanded(child:_stat('Langues','${records.map((r)=>r.targetLanguage).toSet().length}',Icons.language,Colors.blue))]), const SizedBox(height:18),
    FilledButton.icon(onPressed:onLogout,icon:const Icon(Icons.logout),label:const Text('Déconnexion'))
  ]);}
  Widget _stat(String title,String value,IconData icon,Color color)=>AppCard(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Icon(icon,color:color),const SizedBox(height:8),Text(value,style:const TextStyle(fontSize:26,fontWeight:FontWeight.w900)),Text(title,style:const TextStyle(color:Colors.black54))]));
}
