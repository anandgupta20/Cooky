import 'package:flutter/material.dart';

class TermAndcondi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 3.0,
          backgroundColor: Colors.white,
          title: Text(
            "Term of Use",
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(25),
              child: Column(
                children: <Widget>[
                  Text(
                      "The contents and ideas are the intellectual properties of the "
                       "respective contributors and the overall platform and services "
                       "are the intellectual properties of Cooky. Any attempt to "
                       "reproduce any item available on this platform for commercial  "
                       "purposes without permission of the concerned author and the "
                       "Cooky founders will be assumed to me infringement of "
                       "intellectual property rights and the concerned person will be "
                       "liable to being sued by Cooky.", style: TextStyle(fontSize: 17)
                      ),
                      SizedBox(height: 10,),
                  Text("The authors and other contributors to this app database have "
                       "been authorized to do so by the founders and have been "
                       "properly verified. The concerned parties have agreed to share "
                       "their data with us for commercial purposes and have no"
                       " objection with us using it in the current way.", style: TextStyle(fontSize: 17))
                ],
              )),
        ));
  }
}
