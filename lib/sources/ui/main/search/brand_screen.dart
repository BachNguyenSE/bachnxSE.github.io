import 'package:car_world_system/sources/bloc/accessory_bloc.dart';
import 'package:car_world_system/sources/model/brand.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BrandScreen extends StatefulWidget {
  final String id;
  const BrandScreen({Key? key, required this.id}) : super(key: key);

  @override
  _BrandScreenState createState() => _BrandScreenState(id);
}

class _BrandScreenState extends State<BrandScreen> {
  final String id;

  _BrandScreenState(this.id);
  @override
  void initState() {
    super.initState();
    accessoryBloc.getBrandDetail(id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: accessoryBloc.brandDetail,
          builder: (context, AsyncSnapshot<Brand> snapshot) {
            if (snapshot.hasData) {
              return _builBrandDetail(snapshot.data!);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  Widget _builBrandDetail(Brand data) {
    return Container(
        child: Padding(
      padding: EdgeInsets.only(left: 8, right: 8, top: 8),
      child: Column(
        children: [
          ExpandableNotifier(
              child: Padding(
            padding: const EdgeInsets.all(3),
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: <Widget>[
                  ScrollOnExpand(
                    scrollOnExpand: true,
                    scrollOnCollapse: false,
                    child: ExpandablePanel(
                      theme: const ExpandableThemeData(
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                        tapBodyToCollapse: true,
                      ),
                      header: Padding(
                        padding: EdgeInsets.all(3),
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image(
                                  image: NetworkImage(data.image),
                                  height: 8.h,
                                  width: 8.h,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                data.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                      collapsed: Text(
                        data.description,
                        style: TextStyle(
                            fontStyle: FontStyle.italic, color: Colors.blue),
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      expanded: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text(
                                data.description,
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.blue),
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              )),
                        ],
                      ),
                      builder: (_, collapsed, expanded) {
                        return Padding(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          child: Expandable(
                            collapsed: collapsed,
                            expanded: expanded,
                            theme: const ExpandableThemeData(crossFadePoint: 0),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    ));
  }
}
