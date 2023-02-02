import 'package:flutter/material.dart';

class app_button extends StatelessWidget {
  const app_button({Key? key, required this.label, required this.onTap}) : super(key: key);
  final String label ;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 16),
        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,offset: Offset(3,6),blurRadius: 6
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Text(label,style: TextStyle(fontSize: 20,color: Colors.blueGrey),),
      ),
    );
  }
}
