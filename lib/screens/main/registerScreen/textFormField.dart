import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  String title, _value = "", type, currentText;
  Function onSave, validator;
  IconData icon;
  final FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;

  TextFormFieldWidget(
      {Key key,
      this.onSave,
      this.title,
      this.icon,
      this.type,
      this.validator,
      this.currentText})
      : super(key: key) {
//    _focusNode.addListener(() {
//      if (!_hasFocus && _focusNode.hasFocus) {
//        _hasFocus = true;
//        _focusNode.dispose();
//      } else if (_hasFocus && !_focusNode.hasFocus) {
//        print("efefefsfse");
//        _hasFocus = false;
//        onSave(_value);
//      }
//    });
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
//        border: Border(bottom: ),

//        color: Colors.amber.withOpacity(0.7),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 50.0,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
//          Text(_validator(_name, type)),
              Flexible(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(

//                    focusNode: _focusNode,
                    onChanged: (input) => onSave(input),
                    initialValue: currentText,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 5.0, right: 5.0),
                      labelText: title,
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(0.0),
                child: Icon(
                  icon,
                  color: Colors.black,
                ),
              ),
            ],
          ),
//          Text(validator(_value, type),style: TextStyle(color: Colors.red),),
        ],
      ),
    );
  }
}
