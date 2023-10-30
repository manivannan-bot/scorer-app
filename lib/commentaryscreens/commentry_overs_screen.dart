import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scorer/provider/match_provider.dart';
import 'package:sizer/sizer.dart';

import '../models/commentary/commentary_overs_model.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';

class CommentryOvers extends StatefulWidget {
  const CommentryOvers({super.key});

  @override
  State<CommentryOvers> createState() => _CommentryOversState();
}

class _CommentryOversState extends State<CommentryOvers> {

  CommentaryOversModel? oversModel;
  @override
  void initState() {
    super.initState();
    fetchData();
  }
  fetchData(){
    MatchProvider().getCommentaryOvers('1', '2').then((value){
      setState(() {
        oversModel=value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if(oversModel==null){
      return const SizedBox(
          height: 100,
          width: 100,
          child: Center(child: CircularProgressIndicator(
            backgroundColor: Colors.white,
          )));
    }
    return ListView.builder(
      itemCount: oversModel!.data!.length,
      itemBuilder: (BuildContext context, int index) {
        return  SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Text('Hello'),
              //Row1
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for(var bal in [1,2,3,4,5,6,7,8])
                    Container(
                      width: 40,
                      height: 40,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '$bal',
                          style:  fontRegular.copyWith(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '2',
                          style:  fontRegular.copyWith(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '2',
                          style:  fontRegular.copyWith(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '2',
                          style:  fontRegular.copyWith(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('=',
                    style: fontRegular.copyWith(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                  Text('15' ?? 'N/A',
                    style: fontRegular.copyWith(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),

            ],
          ),
        );
      },

    );
  }
}
