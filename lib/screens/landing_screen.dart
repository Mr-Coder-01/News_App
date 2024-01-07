import 'package:flutter/material.dart';
import 'package:new_app/screens/home.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Column(
          children: [
            Material(
              elevation: 3.0,
              borderRadius: BorderRadius.circular(30),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                  child: Image.asset('images/building.jpg', width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.width/1.7,)),
            ),
            const SizedBox(height: 20.0,),
            const Text('News from around the\n       world for you', style: TextStyle(color: Colors.black, fontSize: 26.0, fontWeight: FontWeight.bold),),
            const SizedBox(height: 20.0,),
            const Text('Be focused and take all the time you need to know the world better', style: TextStyle(color: Colors.black45, fontSize: 18.0, fontWeight: FontWeight.w500),),
            const SizedBox(height: 40.0,),
            Container(
              width: MediaQuery.of(context).size.width/1.2,
              child: Material(
                borderRadius: BorderRadius.circular(30),
                elevation: 5.0,
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Home()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width/1.2,
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(30),),
                    child: const Center(
                        child: Text('Get Started',style: TextStyle(color: Colors.white, fontSize: 17.0, fontWeight: FontWeight.w500),)),
                  ),
                ),
              ),
            )
          ],
        ),),
    );
  }
}
