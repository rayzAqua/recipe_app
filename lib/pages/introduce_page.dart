import 'package:flutter/material.dart';
import 'package:pratical_flutter/pages/navigator_page.dart';

class IntroducePage extends StatelessWidget {
  const IntroducePage({super.key});

  void onPressed(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NavigatorPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/start_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 500),

            Text(
              'Bắt đầu với những món ăn',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 34,
                color: Colors.white,
                decoration: TextDecoration.none,
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () => onPressed(context),
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(126, 40),
                backgroundColor: Color(0xFFCEA700),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Bắt đầu', style: TextStyle(fontSize: 17)),
                  Icon(Icons.arrow_forward, size: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
