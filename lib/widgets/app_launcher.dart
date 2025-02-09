/*
Copyright 2019 The dahliaOS Authors

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../window/model.dart';

class AppLauncherPanelButton extends StatefulWidget {
  final Widget app;
  final String icon;
  final bool appExists;
  final bool customBar;
  final double childHeight;
  final double childWidth;
  final Color color;
  final ValueChanged<bool> _callback;

  AppLauncherPanelButton(
      {this.app,
      this.icon,
      this.appExists = true,
      this.customBar = false,
      this.childHeight = 30.0,
      this.childWidth = 30.0,
      this.color,
      callback})
      : _callback = callback;

  @override
  _AppLauncherPanelButtonState createState() => _AppLauncherPanelButtonState();
}

class _AppLauncherPanelButtonState extends State<AppLauncherPanelButton> {
  bool _toggled = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            child: Opacity(
          opacity: widget.appExists ? 1.0 : 0.4,
          child: GestureDetector(
            onTap: () {
              setState(() {
                toggled = !_toggled;
                widget._callback?.call(_toggled);
              });
              widget.appExists
                  ? Provider.of<WindowsData>(context, listen: false)
                      .add(child: widget.app, color: widget.color)
                  : showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        // return object of type Dialog
                        return AlertDialog(
                            title: new Text("Feature not implemented"),
                            content: new Text(
                                "This feature is currently not available on your build of Pangolin. Please see https://reddit.com/r/dahliaos to check for updates."),
                            actions: <Widget>[
                              // usually buttons at the bottom of the dialog
                              new FlatButton(
                                  child: new Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  })
                            ]);
                      });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 14.0),
              child: Image.asset(
                widget.icon,
                filterQuality: FilterQuality.high,
                width: 25,
                height: 25,
              ),
            ),
          ),
        ))
      ],
    );
  }

  set toggled(bool value) {
    if (value == _toggled) {
      return;
    }
  }
}

class AppLauncherDrawerButton extends StatefulWidget {
  final Widget app;
  final String icon;
  final bool appExists;
  final bool customBar;
  final double childHeight;
  final double childWidth;
  final String label;
  final Color color;
  final ValueChanged<bool> _callback;

  AppLauncherDrawerButton(
      {this.app,
      @required this.icon,
      this.label,
      this.appExists = true,
      this.customBar = true,
      this.childHeight = 45.0,
      this.childWidth = 45.0,
      this.color,
      callback})
      : _callback =
            callback; //This alien syntax must be syntactical glucose for a setter. Neato.

  @override
  AppLauncherDrawerButtonState createState() => AppLauncherDrawerButtonState();
}

class AppLauncherDrawerButtonState extends State<AppLauncherDrawerButton> {
  bool _toggled = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(3),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Opacity(
              opacity: widget.appExists ? 1.0 : 0.4,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    toggled = !_toggled;
                    widget._callback?.call(_toggled);
                  });

                  widget.appExists
                      ? Provider.of<WindowsData>(context, listen: false)
                          .add(child: widget.app, color: widget.color)
                      : showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            // return object of type Dialog
                            return AlertDialog(
                                title: new Text("Feature not implemented"),
                                content: new Text(
                                    "This feature is currently not available on your build of Pangolin. Please see https://reddit.com/r/dahliaos to check for updates."),
                                actions: <Widget>[
                                  // usually buttons at the bottom of the dialog
                                  new FlatButton(
                                      child: new Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      })
                                ]);
                          });
                },
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  height: 32,
                  width: 32,
                  color: Color(0xff0178D6),
                  padding: EdgeInsets.all(3),
                  child: Image.asset(
                    widget.icon,
                    width: 25,
                    height: 25,
                  ),
                ),
              ),
            ),
            Text(
              widget.label,
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w300,
                fontFamily: "Segoe UI",
                color: widget.appExists ? Colors.black : Colors.black,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ));
  }

  set toggled(bool value) {
    if (value == _toggled) {
      return;
    }
  }
}
