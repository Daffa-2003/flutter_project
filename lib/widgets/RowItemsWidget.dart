import 'package:flutter/material.dart';

class RowItemsWidget extends StatelessWidget {
  const RowItemsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 1; i <= 3; i++)
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10, left: 15),
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 180,
              decoration: BoxDecoration(
                color: Color(0XFFF5F9FD),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF475269).withOpacity(0.3),
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 70, top: 20),
                        height: 110,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Color(0xFF475269),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Image.asset(
                        'assets/images/$i.png',
                        height: 150,
                        width: 150,
                        fit: BoxFit.contain,
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hode Maternal",
                          style: TextStyle(
                              color: Color(0XFF475269),
                              fontSize: 23,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Men's Jacket",
                          style: TextStyle(
                            color: Color(0XFF475269).withOpacity(0.8),
                            fontSize: 16,
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Text(
                              "Rp.500.000",
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(width: 70),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Color(0XFF475269),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 25,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
