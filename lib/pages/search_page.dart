import 'package:flutter/material.dart';
import 'package:pratical_flutter/components/filter_modal.dart' show FilterModal;
import 'package:pratical_flutter/components/search_bar_component.dart';
import 'package:pratical_flutter/components/search_result_component.dart';
import 'package:pratical_flutter/models/filter_model.dart';
import 'package:pratical_flutter/models/search_result_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<SearchResultModel> resultDatas = [];

  @override
  void initState() {
    super.initState();
    _loadDatas();
  }

  void _loadDatas() {
    setState(() {
      resultDatas = SearchResultModel.getSearchResultDatas();
    });
  }

  void _openFilterModal() async {
    final result = await showModalBottomSheet<FilterResultModel>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (context) {
        return FilterModal();
      },
    );

    if (result != null) {
      print(
        'Filter:\n${result.category}\n${result.ingredients}\n${result.location}',
      );
    } else {
      print('No Result');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 5),
            child: Row(
              children: [
                Expanded(child: SearchBarComponent()),
                const SizedBox(width: 13),
                IconButton(
                  onPressed: () => _openFilterModal(),
                  icon: Icon(Icons.filter_alt, size: 38, color: Colors.amber),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.85,
                ),
                itemCount: resultDatas.length,
                itemBuilder: (context, index) {
                  final result = resultDatas[index];
                  return Container(
                    margin: EdgeInsets.only(left: 1.0, right: 1.0),
                    child: SearchResultComponent(resultModel: result),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
