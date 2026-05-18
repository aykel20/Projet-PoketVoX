
import 'package:flutter/material.dart';
import '../models/translation_record.dart';
import '../widgets/app_card.dart';
import '../widgets/theme_style.dart';

class HistoryScreen extends StatelessWidget { final List<TranslationRecord> records; final Future<void> Function(String) onToggle; final Future<void> Function(String) onDelete; const HistoryScreen({super.key,required this.records,required this.onToggle,required this.onDelete});
  @override Widget build(BuildContext context){ if(records.isEmpty)return const Center(child:Text('Aucune traduction pour ce compte.',style:TextStyle(fontSize:18,fontWeight:FontWeight.w700))); return ListView.builder(padding:const EdgeInsets.all(18),itemCount:records.length,itemBuilder:(context,i){final r=records[i];final s=styleFor(r.theme);return Padding(padding:const EdgeInsets.only(bottom:12),child:AppCard(color:s.soft,child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Row(children:[Chip(backgroundColor:s.primary,label:Text(r.theme,style:const TextStyle(color:Colors.white,fontWeight:FontWeight.w800))),const Spacer(),IconButton(onPressed:()=>onToggle(r.id),icon:Icon(r.favorite?Icons.star:Icons.star_border,color:r.favorite?Colors.amber:null)),IconButton(onPressed:()=>onDelete(r.id),icon:const Icon(Icons.delete_outline))]),Text(r.originalText,style:const TextStyle(fontWeight:FontWeight.w900,fontSize:16)),const SizedBox(height:8),Text(r.translatedText,style:const TextStyle(fontSize:18,height:1.3)),const SizedBox(height:8),Text('${r.sourceLanguage} → ${r.targetLanguage}',style:const TextStyle(color:Colors.black54))])));});}
}
