
import 'package:flutter/material.dart';
import '../models/app_user.dart';
import '../models/translation_record.dart';
import '../services/ai_translation_service.dart';
import '../services/phrasebook_service.dart';
import '../widgets/animated_scene.dart';
import '../widgets/app_card.dart';
import '../widgets/theme_style.dart';

class TranslateScreen extends StatefulWidget { final AppUser user; final Future<void> Function(TranslationRecord) onRecord; const TranslateScreen({super.key,required this.user,required this.onRecord}); @override State<TranslateScreen> createState()=>_TranslateScreenState(); }
class _TranslateScreenState extends State<TranslateScreen>{
  final text=TextEditingController(); final ai=AiTranslationService(); String theme='Restaurant'; String lang='Anglais'; String result=''; bool busy=false;
  Future<void> translate() async {setState(()=>busy=true); final out=await ai.translate(text:text.text,theme:theme,targetLanguage:lang); setState((){result=out;busy=false;}); if(text.text.trim().isNotEmpty){await widget.onRecord(TranslationRecord(id:DateTime.now().microsecondsSinceEpoch.toString(),userId:widget.user.id,theme:theme,sourceLanguage:'Français',targetLanguage:lang,originalText:text.text.trim(),translatedText:out,createdAt:DateTime.now()));}}
  @override Widget build(BuildContext context){final s=styleFor(theme); return AnimatedContainer(duration:const Duration(milliseconds:350),decoration:BoxDecoration(gradient:LinearGradient(colors:[s.soft,Colors.white],begin:Alignment.topCenter,end:Alignment.bottomCenter)),child:ListView(padding:const EdgeInsets.all(18),children:[
    AnimatedScene(theme:theme), const SizedBox(height:16), const Text('Traduction IA',style:TextStyle(fontSize:24,fontWeight:FontWeight.w900)), const Text('L’IA utilise le contexte choisi pour proposer une meilleure traduction.',style:TextStyle(color:Colors.black54)), const SizedBox(height:14),
    Wrap(spacing:8,runSpacing:8,children:PhrasebookService.themes.map((t)=>ChoiceChip(selected:theme==t,label:Text('${styleFor(t).emoji} $t'),selectedColor:styleFor(t).primary,labelStyle:TextStyle(color:theme==t?Colors.white:Colors.black87,fontWeight:FontWeight.w800),onSelected:(_)=>setState(()=>theme=t))).toList()), const SizedBox(height:14),
    AppCard(child:Column(children:[DropdownButtonFormField<String>(value:lang,decoration:const InputDecoration(labelText:'Langue cible'),items:PhrasebookService.languages.map((l)=>DropdownMenuItem(value:l,child:Text(l))).toList(),onChanged:(v)=>setState(()=>lang=v??lang)),const SizedBox(height:12),TextField(controller:text,minLines:4,maxLines:6,decoration:InputDecoration(labelText:'Phrase en français',hintText:'Exemple : Bonjour, je voudrais commander un café.',prefixIcon:Icon(Icons.edit_note,color:s.primary))),const SizedBox(height:14),SizedBox(width:double.infinity,height:54,child:FilledButton.icon(style:FilledButton.styleFrom(backgroundColor:s.primary),onPressed:busy?null:translate,icon:busy?const SizedBox(width:18,height:18,child:CircularProgressIndicator(strokeWidth:2,color:Colors.white)):const Icon(Icons.auto_awesome),label:Text(busy?'Traduction...':'Traduire avec IA')))])),
    if(result.isNotEmpty)...[const SizedBox(height:14),AppCard(color:s.soft,child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Row(children:[Icon(Icons.check_circle,color:s.primary),const SizedBox(width:8),const Text('Résultat IA',style:TextStyle(fontSize:20,fontWeight:FontWeight.w900))]),const SizedBox(height:12),SelectableText(result,style:const TextStyle(fontSize:20,fontWeight:FontWeight.w700,height:1.35)),const SizedBox(height:8),Text('$theme • Français → $lang',style:const TextStyle(color:Colors.black54))]))]
  ]));}
}
