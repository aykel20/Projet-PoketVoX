
import 'package:flutter/material.dart';
import '../models/app_user.dart';
import '../models/translation_record.dart';
import '../services/phrasebook_service.dart';
import '../widgets/app_card.dart';
import '../widgets/theme_style.dart';

class PhrasesScreen extends StatefulWidget { final AppUser user; final Future<void> Function(TranslationRecord) onRecord; const PhrasesScreen({super.key,required this.user,required this.onRecord}); @override State<PhrasesScreen> createState()=>_PhrasesScreenState(); }
class _PhrasesScreenState extends State<PhrasesScreen>{
  final service=PhrasebookService(); String theme='Restaurant'; String lang='Anglais';
  @override Widget build(BuildContext context){final s=styleFor(theme); final phrases=service.byTheme(theme); return Container(decoration:BoxDecoration(gradient:LinearGradient(colors:[s.soft,Colors.white],begin:Alignment.topCenter,end:Alignment.bottomCenter)),child:ListView(padding:const EdgeInsets.all(18),children:[
    const Text('Phrases préfaites',style:TextStyle(fontSize:24,fontWeight:FontWeight.w900)), const Text('Choisis une situation puis appuie sur une phrase utile.',style:TextStyle(color:Colors.black54)), const SizedBox(height:14),
    Wrap(spacing:8,runSpacing:8,children:PhrasebookService.themes.map((t)=>ChoiceChip(selected:theme==t,label:Text('${styleFor(t).emoji} $t'),selectedColor:styleFor(t).primary,labelStyle:TextStyle(color:theme==t?Colors.white:Colors.black87,fontWeight:FontWeight.w800),onSelected:(_)=>setState(()=>theme=t))).toList()), const SizedBox(height:12),
    DropdownButtonFormField<String>(value:lang,decoration:const InputDecoration(labelText:'Langue'),items:PhrasebookService.languages.map((l)=>DropdownMenuItem(value:l,child:Text(l))).toList(),onChanged:(v)=>setState(()=>lang=v??lang)), const SizedBox(height:12),
    ...phrases.map((p)=>Padding(padding:const EdgeInsets.only(bottom:12),child:AppCard(color:s.soft,child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(p.fr,style:const TextStyle(fontSize:17,fontWeight:FontWeight.w900)),const SizedBox(height:8),Text(p.inLanguage(lang),style:const TextStyle(fontSize:18,height:1.3)),const SizedBox(height:10),Align(alignment:Alignment.centerRight,child:FilledButton.icon(style:FilledButton.styleFrom(backgroundColor:s.primary),onPressed:() async {await widget.onRecord(TranslationRecord(id:DateTime.now().microsecondsSinceEpoch.toString(),userId:widget.user.id,theme:theme,sourceLanguage:'Français',targetLanguage:lang,originalText:p.fr,translatedText:p.inLanguage(lang),createdAt:DateTime.now())); if(mounted){ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Phrase ajoutée à ton historique')));}},icon:const Icon(Icons.add),label:const Text('Ajouter')))]))))
  ]));}
}
