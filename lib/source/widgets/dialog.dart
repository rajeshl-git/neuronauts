import 'package:flutter/material.dart';
import 'package:neuronauts_real/source/widgets/mazeconnect.dart';

Future startDial(context, int r, ){
  return showDialog(
          
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.black,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Let's Start...",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(127, 3, 131, 1),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                          onPressed: () => Navigator.pop(context,false),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(127, 3, 131, 1),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                          onPressed: () => itemSelected(context, 0),
                          child: const Text('Start'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
}