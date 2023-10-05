import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class ScoringTab extends StatefulWidget {
  const ScoringTab({super.key});

  @override
  State<ScoringTab> createState() => _ScoringTabState();
}

class _ScoringTabState extends State<ScoringTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 250,
            width: 800,

            child:Column(
              children: [
                Row(
                  children:[
                    Row(children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child:Padding(padding: EdgeInsets.all(12),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(children:[
                                    Text('Batsman',style: TextStyle(color: Colors.orange,fontSize: 24),),
                                    Container(width: 20,),
                                    ElevatedButton(
                                      onPressed: () {
                                        // Handle button press here
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25),
                                        ),
                                      ),
                                      child: Text(
                                        'swap',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ]),
                                Text('Arun    0(0)',style: TextStyle(color: Colors.black,fontSize: 16)),
                                Text('Dinesh    0(0)',style: TextStyle(color: Colors.black,fontSize: 16)),
                              ],),
                          ),
                          ),
                      const DottedLine(
                        dashGapColor: Colors.grey,
                        direction: Axis.vertical, // Draw a vertical line
                        lineLength: 100, // Specify the length of the line
                        lineThickness: 1, // Specify the thickness of the line
                        dashColor: Colors.black, // Specify the color of the dots
                        dashLength: 5, // Specify the length of each dot
                        dashGapLength: 2, // Specify the gap between dots
                      ),

                      ClipRRect( borderRadius: BorderRadius.circular(5),
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Row(children:[
                                  Text('Bowler',style: TextStyle(color: Colors.orange,fontSize: 24)),
                                  Container(width: 20,),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Handle button press here
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                    child: Text(
                                      'change',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),]),
                                Text('Arun   0(0)',style: TextStyle(color: Colors.black,fontSize: 16)),
                                Text('Dinesh    0(0)',style: TextStyle(color: Colors.black,fontSize: 16)),
                              ],),
                          ),
                          )

                  ],)
                  ],

                ),
                Container(height: 15,),
                Column(
                  children: [
                    Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                height: 100,
                                width: 400,
                                color: Colors.yellow,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      margin: EdgeInsets.symmetric(horizontal: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '1', // Display index as text
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 40,
                                      height: 40,
                                      margin: EdgeInsets.symmetric(horizontal: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '2', // Display index as text
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 40,
                                      height: 40,
                                      margin: EdgeInsets.symmetric(horizontal: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '3', // Display index as text
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 40,
                                      height: 40,
                                      margin: EdgeInsets.symmetric(horizontal: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '4', // Display index as text
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 40,
                                      height: 40,
                                      margin: EdgeInsets.symmetric(horizontal: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '5', // Display index as text
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 40,
                                      height: 40,
                                      margin: EdgeInsets.symmetric(horizontal: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '6', // Display index as text
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text('=', style: TextStyle(color: Colors.black, fontSize: 24)),
                                    Text('14', style: TextStyle(color: Colors.black, fontSize: 24)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: Container(
                            color: Colors.yellow,
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: Text(
                              'over 1',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )

              ],
            )
          ),
        ),

        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.8,
              crossAxisCount: 5, // 5 columns
            ),
            itemBuilder: (context, index) {
              return Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    style: BorderStyle.solid,
                  ),
                  color: Colors.black,
                ),
                // Set the desired width
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Container(
                    width: 4, // Adjust the width and height of the circle as needed
                    height: 4,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, // Use a circular shape
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        '$index',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black, // Text color as per your requirement
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                ),

              );
            },
            itemCount: 15, // 3 rows * 5 columns = 15 cells
          ),
        ),
      ],
    );
  }
}
