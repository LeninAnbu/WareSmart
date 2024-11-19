import 'package:flutter/material.dart';
import 'package:WareSmart/constant/Screen.dart';

class customcontainer extends StatelessWidget {
  const customcontainer({
    super.key,
    required this.theme,
    required this.callback,
    required this.imageurl,
    required this.name
  });

  final ThemeData theme;
  final VoidCallback callback;
  final String imageurl;
  final String name;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      // (){
      //   Get.toNamed(ConstantRoutes.inwardpage);
      // },
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        child: Container(
          width: Screens.width(context)*0.28,
          
          height: Screens.padingHeight(context)*0.12,
          
          decoration: BoxDecoration(
            // color: Colors.amber,
            // borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child:Image.asset(imageurl,
                height: Screens.padingHeight(context)*0.06,)
                //  Icon(Icons.qr_code,size: 40,color: theme.primaryColor,),
              ),
               SizedBox(
                      height: Screens.padingHeight(context) * 0.01,
                    ),
              Container(
                // color: Colors.amber,
                child: Text(name,textAlign: TextAlign.center,style: theme.textTheme.bodyText1!.copyWith(color: Colors.black,fontWeight: FontWeight.bold),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}