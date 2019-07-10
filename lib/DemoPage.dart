///
/// Demo draggable and dragtarget
///
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'DataController.dart';
import 'utils.dart';
import 'ItemInfo.dart';

class DemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Drag demo'),),
      body: demoContent(context),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Provider.of<DataController>(context).initDragList();
            Provider.of<DataController>(context).changeDropStatus(APP_UTILE.FAIL);
          },
          label: Text('Reset')),
    );
  }

  // Demo content
  demoContent(context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
           // Card stack widget
          CardStack(),
//           // Drag target widget
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: DataDraggableTarget(),
          ),
        ],
      ),
    );
  }
}

///
/// Card stack widget
///
class CardStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: infoList(context),
    );
  }

  // list information
  infoList(BuildContext context) {
    List<Widget> list = [];

    var itemData;

    // the length of the list is large than 1
    if (Provider.of<DataController>(context).items.length >= 1) {
      // Add item in list
      for (int i = 0; i < Provider.of<DataController>(context).items.length; i++) {
        // draggable item widget
        itemData = DraggableItem(id: i);
      }

    } else {
      itemData = Container(
        height: 150.0,
        width: 150.0,
        child: Card(
          color: Colors.grey,
          child: Text("No data", style: TextStyle(fontSize: 12, color: Colors.white),),
        ),
      );
    }

    list.add(itemData);

    return list;
  }


}

///
/// Draggable item widget
///
class DraggableItem extends StatelessWidget {
  final int id;

  DraggableItem({Key key, this.id}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: Provider.of<DataController>(context).items[id],
      child: dataWidget(context),
      feedback: dataWidget(context),
      childWhenDragging: dataWhenDragging(context),
    );
  }

  dataWidget(context) {
    return Container(
      height: 150.0,
      width: 150.0,
      child: Card(
        child: Center(
          child: Text('${Provider.of<DataController>(context).items[id].msg}',
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
        ),
        color: Provider.of<DataController>(context).items[id].color,
      ),
    );
  }

  dataWhenDragging(context) {
    return Container(
      height: 150.0,
      width: 150.0,
      child: Card(
        child: Center(
          child: id >= 1? Text('${Provider.of<DataController>(context).items[id].msg}',
            style: TextStyle(fontSize: 12, color: Colors.white),
          ): Text("No data", style: TextStyle(fontSize: 12, color: Colors.white),),
        ),
        color: id >= 1? Provider.of<DataController>(context).items.elementAt(
            (Provider.of<DataController>(context).items.length-1)-1
        ).color: Colors.grey,
      ),
    );
  }
}

///
/// Draggable target widget
///
class DataDraggableTarget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DragTarget<ItemInfo>(
      onWillAccept: (data) {
        print('onWillAccept');
        return true;
      },
      onAccept: (data) {
        print('onAccept');
        if (Provider.of<DataController>(context).items.length >= 1) {
          Provider.of<DataController>(context).removeItem();
          Provider.of<DataController>(context).changeDropStatus(APP_UTILE.SUCCESS);
          Provider.of<DataController>(context).setAcceptedInfo(data);
        }
      },
      builder: (context, candidate, reject) => buildList(context, candidate, reject),
    );
  }

  buildList(context, candidateData, rejectData) {
    print('buildList');
    print('drop status: ${Provider.of<DataController>(context).isDropStatus}');
    if (Provider.of<DataController>(context).isDropStatus == APP_UTILE.SUCCESS) {
      // return stack widget to show info
      return dragTargetRange(context,
      Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(border: Border.all(style: BorderStyle.solid)),
            height: 200.0,
            width: 200.0,
            child: Card(
              child: Center(
                child: Text('${Provider.of<DataController>(context).getAcceptItemInfo.getContent}',
                  style: TextStyle(fontSize: 12, color: Provider.of<DataController>(context).getAcceptItemInfo.getColor),),
              ),
            ),
          ),
        ],
      ));
    } else {
      // return to show draw data here
      return dragTargetRange(context,
      Container(
        decoration: BoxDecoration(border: Border.all(style: BorderStyle.solid)),
        height: 200.0,
        width: 200.0,
        child: Card(
          child: Center(
            child: Text("Drop data here!!", style: TextStyle(fontSize: 12, color: Colors.black),),
          ),
        ),
      ));
    }
  }

  dragTargetRange(context, Widget component) {
    return Padding(
      padding: const EdgeInsets.all(15.5),
      child: component,
    );
  }

}