import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import org.example 1.0


Window {
    id: root
    maximumWidth: 800
    maximumHeight: 800
    minimumHeight: 450
    minimumWidth: 450
    width: 640
    height: 640
    visible: true
    title: qsTr("Puzzle 15")

    Item{
        id: quit
        anchors.fill: parent
        focus: true
        Keys.onPressed:
            function (event){
                //console.log(event.key)
                if(event.key === 81){
                    Qt.quit()
                }
            }
    }

    Rectangle{
        anchors.fill: parent
        color: "lightgrey"
        border.color: "black"
        radius: 5
        MyPopup{
            id: myPopup
        }

        Column{
            anchors.centerIn: parent
            spacing: 10

            MyGrid{
                id: myGrid
            }

            Button{
                id: loadButton
                width: myGrid.grid.width / 5
                height: width / 2.5
                anchors.horizontalCenter: parent.horizontalCenter
                Text{
                    id: popup_text
                    anchors.centerIn: parent
                    text: "Shuffle"
                    font.bold: true
                    font.pixelSize: parent.width / 5
                    //font.italic: true
                }

                background :Rectangle{
                    id: buttonRect
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: loadButton.pressed ? Qt.lighter("steelblue") : Qt.lighter("cyan")}
                        GradientStop { position: 1.0; color: loadButton.pressed ? Qt.darker("steelblue") : Qt.darker("darkcyan") }
                    }
                    border.color: "black"
                    radius: 5
                }
                onClicked: {
                    myGrid.listModel.clicked_shuffled()
                    quit.focus = true
                }
            }
        }
    }
}
