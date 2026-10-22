import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: root
    width: 1920
    height: 1080
    color: "#0b070f"

    // Tech-Noir Spider Lily Ambient Background
    Image {
        id: bgImage
        anchors.fill: parent
        source: "/usr/share/wallpapers/Higanvein/higanvein-default.jpg"
        fillMode: Image.PreserveAspectCrop
        opacity: 0.4
    }

    // Top Bar Status
    RowLayout {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 24

        Text {
            text: "HIGANVEIN<font color='#e11d48'>OS</font>"
            color: "#ffffff"
            font.pixelSize: 16
            font.bold: true
            font.letterSpacing: 2
        }

        Item { Layout.fillWidth: true }

        Text {
            id: clockText
            text: Qt.formatDateTime(new Date(), "hh:mm  ·  ddd, dd MMM yyyy")
            color: "#a1a1aa"
            font.pixelSize: 13
            font.family: "Monospace"
        }

        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: clockText.text = Qt.formatDateTime(new Date(), "hh:mm  ·  ddd, dd MMM yyyy")
        }
    }

    // Centered Login Card
    Rectangle {
        id: loginBox
        width: 380
        height: 380
        radius: 12
        color: "#120b17"
        border.color: "#e11d48"
        border.width: 1
        anchors.centerIn: parent

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 32
            spacing: 16

            // Distro Logo Emblem
            Image {
                source: "/usr/share/icons/hicolor/512x512/apps/higanveinos.png"
                Layout.preferredWidth: 64
                Layout.preferredHeight: 64
                Layout.alignment: Qt.AlignHCenter
                fillMode: Image.PreserveAspectFit
            }

            Text {
                text: "AUTHENTICATE"
                color: "#f4f4f5"
                font.pixelSize: 14
                font.bold: true
                font.letterSpacing: 2
                Layout.alignment: Qt.AlignHCenter
            }

            // Username Field
            TextField {
                id: nameField
                text: userModel.lastUser
                Layout.fillWidth: true
                placeholderText: "Username"
                color: "#ffffff"
                font.pixelSize: 13
                background: Rectangle {
                    color: "#18101f"
                    border.color: nameField.activeFocus ? "#e11d48" : "#27272a"
                    border.width: 1
                    radius: 6
                }
            }

            // Password Field
            TextField {
                id: passwordField
                Layout.fillWidth: true
                placeholderText: "Password"
                echoMode: TextInput.Password
                focus: true
                color: "#ffffff"
                font.pixelSize: 13
                background: Rectangle {
                    color: "#18101f"
                    border.color: passwordField.activeFocus ? "#e11d48" : "#27272a"
                    border.width: 1
                    radius: 6
                }
                onAccepted: sddm.login(nameField.text, passwordField.text, sessionBox.currentIndex)
            }

            // Session selector
            ComboBox {
                id: sessionBox
                Layout.fillWidth: true
                model: sessionModel
                textRole: "name"
                currentIndex: sessionModel.lastIndex
                font.pixelSize: 12
            }

            // Login Button
            Button {
                text: "LOGIN SESSION ➔"
                Layout.fillWidth: true
                Layout.preferredHeight: 40
                contentItem: Text {
                    text: parent.text
                    color: "#ffffff"
                    font.bold: true
                    font.pixelSize: 12
                    font.letterSpacing: 1
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                background: Rectangle {
                    color: parent.down ? "#9f1239" : (parent.hovered ? "#f43f5e" : "#e11d48")
                    radius: 6
                }
                onClicked: sddm.login(nameField.text, passwordField.text, sessionBox.currentIndex)
            }
        }
    }

    // Bottom Action Row (Reboot / Shutdown)
    RowLayout {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 24
        spacing: 16

        Button {
            text: "REBOOT"
            font.pixelSize: 11
            font.family: "Monospace"
            contentItem: Text { text: parent.text; color: "#a1a1aa"; font.bold: true }
            background: Rectangle { color: "transparent" }
            onClicked: sddm.reboot()
        }

        Button {
            text: "SHUTDOWN"
            font.pixelSize: 11
            font.family: "Monospace"
            contentItem: Text { text: parent.text; color: "#e11d48"; font.bold: true }
            background: Rectangle { color: "transparent" }
            onClicked: sddm.powerOff()
        }
    }
}
