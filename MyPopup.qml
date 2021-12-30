import QtQuick 2.0
import QtQuick.Controls 2.15

Popup {
    id: popup
    anchors.centerIn: parent
    width: root.width / 3.2
    height: width / 2.5
    closePolicy: Popup.NoAutoClose
    background :Rectangle{
        gradient: Gradient {
            GradientStop { position: 0.0; color: Qt.lighter("lightgrey")}
            GradientStop { position: 1.0; color: Qt.darker("lightgrey")}
        }
        border.color: "black"
        radius: 5
    }

    Text{
        id: popup_text
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Puzzle has been resolved"
        font.bold: true
        font.pixelSize: parent.width / 12
        //font.italic: true
    }

    Button{
        id: restart_button
        width: parent.height
        height: width / 2.6
        anchors.topMargin: height / 1.5
        anchors.top: popup_text.bottom
        anchors.left: parent.left
        text: "Restart"
        background :Rectangle{
            gradient: Gradient {
                GradientStop { position: 0.0; color: restart_button.pressed ? Qt.lighter("steelblue") : Qt.lighter("cyan")}
                GradientStop { position: 1.0; color: restart_button.pressed ? Qt.darker("steelblue") : Qt.darker("darkcyan") }
            }
            border.color: "black"
            radius: 5
        }
        onClicked: {
            myGrid.listModel.clicked_shuffled()
            popup.close()
            quit.focus = true
        }
    }

    Button{
        id: quit_button
        width: parent.height
        height: width / 2.6
        anchors.topMargin: height / 1.5
        anchors.top: popup_text.bottom
        anchors.right: parent.right
        text: "Quit"
        background :Rectangle{
            gradient: Gradient {
                GradientStop { position: 0.0; color: quit_button.pressed ? Qt.lighter("steelblue") : Qt.lighter("cyan")}
                GradientStop { position: 1.0; color: quit_button.pressed ? Qt.darker("steelblue") : Qt.darker("darkcyan") }
            }
            border.color: "black"
            radius: 5
        }
        onClicked: {
            Qt.quit()
        }
    }
}
