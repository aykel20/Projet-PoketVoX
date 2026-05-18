
import 'package:flutter/material.dart';
import '../models/app_user.dart';
import '../models/translation_record.dart';
import '../services/auth_service.dart';
import '../services/storage_service.dart';
import 'translate_screen.dart';
import 'phrases_screen.dart';
import 'history_screen.dart';
import 'profile_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget { final AppUser user; const HomeScreen({super.key, required this.user}); @override State<HomeScreen> createState()=>_HomeScreenState(); }
class _HomeScreenState extends State<HomeScreen>{
  final storage=StorageService(); int index=0; List<TranslationRecord> records=[]; bool loading=true;
  @override void initState(){super.initState(); load();}
  Future<void> load() async {records=await storage.getRecords(widget.user.id); if(mounted)setState(()=>loading=false);}
  Future<void> add(TranslationRecord r) async {await storage.addRecord(r); await load();}
  Future<void> toggle(String id) async {records=records.map((r)=>r.id==id?r.copyWith(favorite:!r.favorite):r).toList(); await storage.replaceUserRecords(widget.user.id,records); setState((){});}
  Future<void> delete(String id) async {records=records.where((r)=>r.id!=id).toList(); await storage.replaceUserRecords(widget.user.id,records); setState((){});}
  Future<void> logout() async {await AuthService().logout(); if(!mounted)return; Navigator.pushReplacement(context,MaterialPageRoute(builder:(_)=>const LoginScreen()));}
  @override Widget build(BuildContext context){
    final pages=[TranslateScreen(user:widget.user,onRecord:add),PhrasesScreen(user:widget.user,onRecord:add),HistoryScreen(records:records,onToggle:toggle,onDelete:delete),ProfileScreen(user:widget.user,records:records,onLogout:logout)];
    return Scaffold(appBar:AppBar(title:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Text('PoketVoX IA',style:TextStyle(fontWeight:FontWeight.w900,fontSize:24)),Text('Compte : ${widget.user.name}',style:const TextStyle(fontSize:13,color:Colors.black54))])),body:loading?const Center(child:CircularProgressIndicator()):pages[index],bottomNavigationBar:NavigationBar(selectedIndex:index,onDestinationSelected:(i)=>setState(()=>index=i),destinations:const[
      NavigationDestination(icon:Icon(Icons.auto_awesome_outlined),selectedIcon:Icon(Icons.auto_awesome),label:'IA'),
      NavigationDestination(icon:Icon(Icons.forum_outlined),selectedIcon:Icon(Icons.forum),label:'Phrases'),
      NavigationDestination(icon:Icon(Icons.history_outlined),selectedIcon:Icon(Icons.history),label:'Historique'),
      NavigationDestination(icon:Icon(Icons.person_outline),selectedIcon:Icon(Icons.person),label:'Compte'),
    ]));
  }
}
