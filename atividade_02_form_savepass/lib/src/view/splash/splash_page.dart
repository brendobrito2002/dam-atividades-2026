import 'package:flutter/material.dart';
import 'package:save_pass/ui/components/save_logo.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late Animation<double> animationLogo;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    animationLogo = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 1, curve: Curves.easeIn),
      ),
    );
    _animationController.forward();
    Future.delayed(const Duration(seconds: 2), () async {
      _animationController.reverse().then((value) => openLoginPage());
    });

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void openLoginPage() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: animationLogo,
          builder: (context, child) => Opacity(
            opacity: animationLogo.value,
            child: const SavePassLogo(),
          ),
        ),
      ),
    );
  }
}
