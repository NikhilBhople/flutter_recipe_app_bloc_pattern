import 'package:flutter/material.dart';

Widget SearchBar(BuildContext context) {
  final _recipeQuery = TextEditingController();
  return  Container(
    padding: EdgeInsets.only(left: 16, right: 16,bottom: 16),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey[300]
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
                hintText: 'What you want to eat today...',
                labelText: 'Search Recipe',
                icon: Icon(Icons.fastfood)
            ),
            validator: (value){
              if (value.isEmpty) {
                return 'Please enter recipe';
              }
              return null;
            },
            controller: _recipeQuery,
          ),
        ),
        IconButton(
          icon: Icon(Icons.send,size: 25,),onPressed:() {
          FocusScope.of(context).requestFocus(new FocusNode());
          print(_recipeQuery.text.toLowerCase());
        },
        )
      ],
    ),
  );
}