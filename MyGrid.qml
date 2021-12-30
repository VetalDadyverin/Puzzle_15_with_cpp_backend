import QtQuick 2.0
import org.example 1.0

Rectangle{
    property alias grid: _grid
    property alias listModel: _listModel
    border.color: "black"
    color: "grey"
    width: root.width / 1.4
    height: width
    radius: 10
    GridView{
        id: _grid
        width: parent.width
        height: parent.height
        anchors.fill: parent
        cellWidth: parent.width / 4
        cellHeight: cellWidth
        interactive: false
        model: _listModel
        delegate: MyComponent{}
        move: trans
        displaced: trans
        //Component.onCompleted: _listModel.clicked_shuffled()
        Transition {
            id: trans
            NumberAnimation{
                properties: "x, y"
                duration: 400
            }

        }
    }

    MyListModel {
        id: _listModel
    }

}
