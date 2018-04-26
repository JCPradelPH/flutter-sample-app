import 'package:flutter/material.dart';

// generic widget to create buttons with icons
class ButtonIcon extends StatelessWidget{

  final String _buttonLabel;
  final Color backColor, iconColor;
  final onClick;
  final IconData _icon;
  final double iconSize, width;
  final TextStyle textStyle;
  final int _iconPosition, _posLeft = 0;

  ButtonIcon(
    this._buttonLabel,
    this._icon,
    this._iconPosition,
    {
      Key key,
      this.iconSize = 12.0,
      this.width = 250.0,
      this.backColor = Colors.transparent,
      this.iconColor = Colors.black,
      this.textStyle,
      this.onClick
    }
  ) : super(key:key);
  @override
  Widget build(BuildContext context){
    return new Material(
      color: Colors.transparent,
      child: new Container(
          child: _mainLabel(),
          margin: new EdgeInsets.all(5.0),
          width: width,
          color: backColor
        )
    );
  }
  
  _mainLabel() => _materialWrapper(
    _flatButtonWrapper(
      new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _iconPosition==_posLeft?[
          new Icon(_icon, color: iconColor, size:iconSize),
          _positionedButtonText()
        ] : 
        [
          _positionedButtonText(),
          new Icon(_icon, color: iconColor, size:iconSize)
        ]
      )
    )
  );
  _positionedButtonText() => new Container(
    child: _buttonText(),
    margin: new EdgeInsets.only(
      top:_textTopMargin(),
      left:_textLeftMargin()
    )
  );
  _buttonText() => new Text(
    _buttonLabel,
    textAlign: TextAlign.left,
    style: textStyle
  );
  _flatButtonWrapper(c) => new FlatButton(
    onPressed: onClick,
    padding: new EdgeInsets.all(10.0),
    splashColor: Colors.white,
    child: c
  );

  _materialWrapper(c) => new Material(
    color: Colors.transparent,
    child: c
  );

  double _textTopMargin() => iconSize/4;

  double _textLeftMargin() => new Text(
    _buttonLabel,
    textAlign: TextAlign.left,
    style: textStyle
  ).style.fontSize;
}