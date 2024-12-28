import QtQuick 2.5
import QtQuick.Layouts 1.2
import QtQuick.Controls 1.4 as Qqc
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.2
import QtMultimedia 5.5
import QtGraphicalEffects 1.15
import SddmComponents 2.0

Rectangle { // Box the size of the screen to contain the theme in
    color: "black"
    width: Window.width
    height: Window.height

    AnimatedImage { // Background wallpaper
        id: wallpaper
        width: parent.width
        height: parent.height
        fillMode: Image.PreserveAspectCrop
        source: "wallpaper.gif"
    }

    Rectangle { // Blurred box to make text more visible
        id: formBg
        width: 1200
        height: 1200
        x: 1120
        y: 120
        color: "grey"
        opacity: 0.5
    }
    ShaderEffectSource { // Makes the wallpaper the source for the blur
        id: blurArea
        sourceItem: wallpaper
        width: formBg.width
        height: formBg.height
        anchors.centerIn: formBg
        sourceRect: Qt.rect(x,y,width,height)
        visible: true
    }
    GaussianBlur { // The blur configuration for the blurred box
        id: blur
        width: formBg.width
        height: formBg.height
        source: blurArea
        radius: 80
        samples: 300
        cached: true
        anchors.centerIn: formBg
        visible: true
    }

    // Borders
    Rectangle {
        id: topBorder
        width: 1200
        height: 10
        x: 1120
        y: 120
        color: "#C3A9AB"
    }
    Rectangle {
        id: bottomBorder
        width: 1200
        height: 10
        x: 1120
        y: 1320
        color: "#C3A9AB"
    }
    Rectangle {
        id: leftBorder
        width: 10
        height: 1200
        x: 1120
        y: 120
        color: "#C3A9AB"
    }
    Rectangle {
        id: rightBorder
        width: 10
        height: 1200
        x: 2310
        y: 120
        color: "#C3A9AB"
    }

    ComboBox { // The session drop-down menu in the center
        id: session
        height: 40
        width: 300
        x: 1570
        y: 160
        model: sessionModel
        index: sessionModel.lastIndex
        color: "#26352D"
        borderColor: "#C3A9AB"
        focusColor: "#81695B"
        hoverColor: "#93A5B2"
        textColor: "#C3A9AB"
        arrowIcon: "drop-menu-arrow.png"
    }

    Rectangle { // Opaque box behind clock
        height: 170
        width: 500
        y: 365
        x: 1470
        color: "#26352D"
    }

    ColumnLayout { // The username and password fields are all in the center
        width: parent.width
        height: parent.height
        Clock { // Added a clock to the "first column"
            id: clock
            Layout.alignment: Qt.AlignCenter
            Layout.topMargin: 160
            visible: true
            x: parent.width
            y: parent.height
            color: "#C3A9AB"
        }
        Qqc.Label { // Label above the username input box
            Layout.alignment: Qt.AlignCenter
            text: "U s e r n a m e:"
            color: "#C3A9AB"
            font.pixelSize: 32
        }
        Qqc.TextField { // The Username input box
            id: username
            Layout.alignment: Qt.AlignCenter
            text: userModel.lastUser
            style: TextFieldStyle {
                textColor: "#C3A9AB"
                background: Rectangle {
                    color: "#26352D"
                    implicitWidth: 400
                    border.color: "#C3A9AB"
                }
            }
        }
        Qqc.Label { // Label above the password input box
            Layout.alignment: Qt.AlignCenter
            text: "P a s s w o r d："
            color: "#C3A9AB"
            font.pixelSize: 32
        }
        Qqc.TextField { // The Password input box
            id: password
            echoMode: TextInput.Password
            Layout.alignment: Qt.AlignCenter
            style: TextFieldStyle {
                textColor: "#C3A9AB"
                background: Rectangle {
                    color: "#26352D"
                    implicitWidth: 400
                    border.color: "#C3A9AB"
                }
            }
        }
        ColumnLayout { // The login button is in the center
            Layout.alignment: Qt.AlignCenter
            Layout.bottomMargin: 120
            width: 400
            Rectangle {
                anchors.fill: parent
                color: "#26352D"
            }
            Qqc.Label { // Label inside of the login button
                Layout.alignment: Qt.AlignCenter
                text: "L o g i n"
                color: "#C3A9AB"
                font.pixelSize: 32
            }
            MouseArea { // The area that recognizes a mouse click for the login button, same size as login button
                anchors.fill: parent
                onClicked: sddm.login(username.text, password.text, session.index)
            }
        }
    }
}
