import 'package:flutter/material.dart';
import 'package:glambooker_admin/utils/colors.dart';

class SidemenuItem extends StatelessWidget {
  String title;
  IconData icon;
  String? trailText;
  Function()?onclick;
  SidemenuItem({required this.title, required this.icon, this.trailText, required this.onclick});


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onclick,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          border: BorderDirectional(bottom: BorderSide(color: Colors.white24))
        ),
        child: Row(
          children: [
            Icon(icon, color: Karas.primary,),
            SizedBox(width: 20,),
            Expanded(
                child: Container(
                  child: Text('$title', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
                ),
            ),
            trailText!=null?trailText!='0'?CircleAvatar(radius: 10, child: Text('$trailText', style: TextStyle(fontSize: 12),)):Container():Container()
          ],
        ),
      ),
    );
  }
}
