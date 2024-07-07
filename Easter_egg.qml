import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import FluentUI 1.0
import "../component"

FluScrollablePage {
    FluFrame {
        Layout.fillWidth: true
        Layout.preferredHeight: 1000
        padding: 10

        Column {
            spacing: 50
            width: parent.width
            height: parent.height
            anchors.centerIn: parent

            FluImage {
                id: image
                property real aspectRatio: 1.0
                height: parent.height
                width: height * aspectRatio
                fillMode: Image.PreserveAspectFit
                source: "https://xialiu.cn/api/dan/"

                onStatusChanged: {
                    if (status === Image.Error) {
                        showError(qsTr("The image failed to load, please reload"))
                    }
                }

                clickErrorListener: function() {
                    source = "https://edui123.com/rili/"
                }

                onSourceSizeChanged: {
                    if (sourceSize.width > 0 && sourceSize.height > 0) {
                        aspectRatio = sourceSize.width / sourceSize.height
                    }
                }
            }
        }
    }
}
