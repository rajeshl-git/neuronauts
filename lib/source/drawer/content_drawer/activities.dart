import 'package:flutter/material.dart';
import 'package:neuronauts_real/source/widgets/navpop.dart';

class Activities extends StatefulWidget {
  const Activities({super.key});

  @override
  State<Activities> createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Activities"),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(127, 3, 131, 1),
        leading: IconButton(
          onPressed: (){navPop(context);},
          icon: const Icon(Icons.arrow_back_ios_new_rounded)
        ),
      ),
    );
  }
}