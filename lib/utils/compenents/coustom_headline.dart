import 'package:flutter/material.dart';
import 'package:shop_fusion/utils/app_constant.dart';
class CoustomHeadline extends StatelessWidget {
   final String headingTitle;
   final String headingSubTitle;
   final String buttonText;
   final VoidCallback callback;


    CoustomHeadline({
      super.key,
      required this.headingTitle,
      required this.headingSubTitle,
      required this.buttonText,
      required this.callback,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
           margin: EdgeInsets.symmetric(horizontal: 8,vertical: 14),
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(headingTitle,style: TextStyle(
                 fontSize: 19,   fontWeight: FontWeight.bold,color: Colors.grey.shade800),),
                Text(headingSubTitle,style: TextStyle(
                    fontSize: 15,color: Colors.grey.shade700))
              ],
            ),
            InkWell(
              onTap: callback,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    width: 2,
                    color: AppConstant.appSecondryColor
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(buttonText,style: const TextStyle(
                      color: AppConstant.appSecondryColor,fontSize: 18 ),),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
