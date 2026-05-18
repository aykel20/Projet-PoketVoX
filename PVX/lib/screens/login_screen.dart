import 'package:flutter/material.dart';

import '../models/app_user.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService auth = AuthService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController pinController = TextEditingController();

  bool registerMode = false;
  bool loading = true;
  String error = '';

  @override
  void initState() {
    super.initState();
    checkCurrentUser();
  }

  @override
  void dispose() {
    nameController.dispose();
    pinController.dispose();
    super.dispose();
  }

  Future<void> checkCurrentUser() async {
    final AppUser? user = await auth.getCurrentUser();

    if (!mounted) return;

    if (user != null) {
      goToHome(user);
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  void goToHome(AppUser user) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomeScreen(user: user),
      ),
    );
  }

  Future<void> submit() async {
    try {
      setState(() {
        error = '';
      });

      final AppUser user;

      if (registerMode) {
        user = await auth.register(
          nameController.text,
          pinController.text,
        );
      } else {
        user = await auth.login(
          nameController.text,
          pinController.text,
        );
      }

      if (!mounted) return;

      goToHome(user);
    } catch (e) {
      setState(() {
        error = e.toString().replaceAll('Exception: ', '');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF6C5CE7),
              Color(0xFFFF6B9A),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(22),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 430,
              ),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'PoketVoX IA',
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Connecte-toi pour avoir ton suivi personnel.',
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: 'Nom du compte',
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: pinController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Code PIN',
                          prefixIcon: Icon(Icons.lock),
                        ),
                      ),
                      if (error.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        Text(
                          error,
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                      const SizedBox(height: 18),
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: FilledButton.icon(
                          onPressed: submit,
                          icon: Icon(
                            registerMode ? Icons.person_add : Icons.login,
                          ),
                          label: Text(
                            registerMode ? 'Créer mon compte' : 'Connexion',
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            registerMode = !registerMode;
                            error = '';
                          });
                        },
                        child: Text(
                          registerMode
                              ? 'J’ai déjà un compte'
                              : 'Créer un nouveau compte',
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Projet local : les comptes sont stockés sur cet appareil pour la démonstration.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
