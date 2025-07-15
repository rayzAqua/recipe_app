import 'package:flutter/material.dart';
import 'package:pratical_flutter/models/search_result_model.dart';

class SearchResultComponent extends StatelessWidget {
  final SearchResultModel resultModel;

  const SearchResultComponent({super.key, required this.resultModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black38.withAlpha(20),
            blurRadius: 10,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 135,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(resultModel.imagePath),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: EdgeInsets.only(right: 5, top: 5),
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(150),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(Icons.favorite, color: Colors.red, size: 20),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(left: 7, right: 7, top: 10),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    resultModel.title,
                    style: TextStyle(
                      color: Color(0xFF292626),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'By ${resultModel.authorName}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Color(0xFFB8B1B1),
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.timer_sharp,
                          color: Color(0xFFCEA700),
                          size: 16,
                        ),
                        Text(
                          resultModel.length,
                          style: TextStyle(
                            color: Color(0xFF6E6767),
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
