import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Layouts 1.2
import QtMultimedia 5.5
import QtGraphicalEffects 1.15
import QtQuick.Controls 1.4 as Qqc
import QtQuick.Controls.Styles 1.4
import SddmComponents 2.0

// Dimensions of Background
Rectangle {
    color: "black"
    width: Window.width
    height: Window.height

    // Wallpaper for Background of Theme.
    AnimatedImage {
        id: wallpaper
        width: parent.width
        height: parent.height
        fillMode: Image.PreserveAspectCrop
        source: "wallpaper.gif"
    }

    // Labels the Drop-down Menu for Session selection.
    Qqc.Label {
        x: 100
        y: 100
        text: "Desktop Environment: "
        color: "#E7D3E0"
        font.pixelSize: 20
    }
    // The drop-down menu for Session selection.
    // Intended for my friend's KDE session, but tested on Hyprland, for now.
    ComboBox {
        id: session
        height: 28 // Guesstimate to get the height the same as username/password box.
        width: 300
        x: 100
        y: 150
        model: sessionModel
        index: sessionModel.lastIndex
        color: "#9E4FC8"
        borderColor: "#E7D3E0"
        focusColor: "#6483C9"
        hoverColor: "#A1A3E8"
        textColor: "#E7D3E0"
        arrowIcon: "eyemori.png" // Image for drop-down menu arrow.
    }

    // Labels the username box.
    Qqc.Label {
        x: 500
        y: 100
        text: "Username: "
        color: "#E7D3E0"
        font.pixelSize: 20
    }
    // The username input box.
    Qqc.TextField {
        id: username
        x: 500
        y: 150
        text: userModel.lastUser
        style: TextFieldStyle {
            textColor: "#E7D3E0"
            background: Rectangle {
                color: "#9E4FC8"
                implicitWidth: 300
                border.color: "#E7D3E0"
            }
        }
    }

    // Labels the password box.
    Qqc.Label {
        x: 900
        y: 100
        text: "Password: "
        color: "#E7D3E0"
        font.pixelSize: 20
    }
    // The password input box.
    Qqc.TextField {
        id: password
        echoMode: TextInput.Password
        x: 900
        y: 150
        style: TextFieldStyle {
            textColor: "#E7D3E0"
            background: Rectangle {
                color: "#9E4FC8"
                implicitWidth: 300
                border.color: "#E7D3E0"
            }
        }
        KeyNavigation.backtab: username; KeyNavigation.tab: session
        Keys.onPressed: {
            if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                sddm.login(username.text, password.text, session.index)
                event.accepted = true
            }
        }
    }
}

