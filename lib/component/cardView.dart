import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardView extends StatelessWidget {
  final String title;
  final String content;
  final Function() ontap;

  const CardView({Key? key, required this.title, required this.content, required this.ontap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
        child: Card(
          margin: EdgeInsets.all(6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 1.3,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/intor.png'),
                    fit: BoxFit.cover
                  ),
                ),
              ),),
              SizedBox(width: 5,),
              Expanded(
                  flex:2,child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(title,style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: Colors.black
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,),
                  SizedBox(height: 5,),
                  Text(content,style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.grey
                  ),
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,),
                ],
              ))
            ],
          ),

        ),
      ),
    );
  }
}
