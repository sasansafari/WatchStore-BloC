import 'package:flutter/material.dart';
import 'package:watch_store/screens/product_single_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,

       child: Center(
         child: SizedBox(
          height: 200,
          width: 300,
           child: ElevatedButton(
            onPressed: ()=>
         
           Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const ProductSingleScreen()))
           , child: Text("مشاهده همه")),
         ),
       ),
    );
  }
}