import 'package:flutter/material.dart';


void showMsg(BuildContext context, bool success, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            height: 90,
            decoration: BoxDecoration(
              color: success ? Colors.green : Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Row(
              children: [
                Icon(
                  success ? Icons.check_circle_outline : Icons.error_outline_outlined,
                  size: 40,
                  color: Colors.white,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      message,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
    ),
  );
}