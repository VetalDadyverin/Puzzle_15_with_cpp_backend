import QtQuick 2.0

Item {
    id: itemDelegate
    width: grid.cellWidth
    height: grid.cellHeight
    Rectangle{
        id: componentRect
        width: grid.cellWidth * 0.93
        height: width
        border.color: "black"
        gradient: Gradient {
            GradientStop { position: 0.0; color: index === model.display - 1 ? Qt.lighter("steelblue") : Qt.lighter("cyan")}
            GradientStop { position: 1.0; color: index === model.display - 1 ? Qt.darker("steelblue") : Qt.darker("darkcyan")}
        }
        radius: 10
        anchors.centerIn: parent
        visible: model.display
        Text {
            anchors.centerIn: parent
            text: model.display
            font.bold: true
            font.pixelSize: 20
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                myGrid.listModel.clicked_cell(index)
                if(myGrid.listModel.check_solved()){
                    myPopup.open()
                }
                else{
                console.log("Not a winning combination")
                }
                quit.focus = true
            }
        }
    }
}
