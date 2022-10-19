import QtQuick 2.0

Rectangle
{
    property string dayOfWeek: ""
    property string tempMin: "--,- C"
    property string tempMax: "--,- C"
    property bool lineVisible: true
    property real scaleFactor: 1.0

    color: "transparent"

    function setIcon(value)
    {
        imgWeather.source = "qrc:/icones/" + value + ".png"
    }
    Text
    {
        id: txtDay0fweek
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: imgWeather.top
        anchors.bottomMargin: 10
        color: "#FA9727"
        font.bold: true
        font.pointSize: 15
        font.family: fontOpenSans.name
        text: dayOfWeek
    }

    Image
    {
        id: imgWeather
        anchors.centerIn: parent
        source: "qrc:/icones/1.png"
        scale: scaleFactor
    }
    Rectangle
    {
        id: rectTempratures
        width: parent.width
        height: 25
        anchors.horizontalCenter: parent.horizontalCentre
        anchors.top: imgWeather.bottom
        anchors.topMargin: 10 * scaleFactor
        color: "transparent"

        Text
        {
            id: txtTempMin
            anchors.right:  parent.horizontalCenter
            anchors.rightMargin: 15
            anchors.verticalCenter: parent.verticalCenter
            color: "#3ecdfd"
            font.bold: true
            font.pointSize: 13
            font.family: fontOpenSans.name
            text: tempMin

        }
        Text
        {
            id: txtTempMax
            anchors.left:  parent.horizontalCenter
            anchors.leftMargin: 15
            anchors.verticalCenter: parent.verticalCenter
            color: "#fb5255"
            font.bold: true
            font.pointSize: 13
            font.family: fontOpenSans.name
            text: tempMax

        }
    }
    Rectangle
    {
        id: verticalLine
        width: 1
        height: parent.height - 30
        anchors.verticalCenter: parent.verticalCentre
        anchors.right: parent.right
        border.width: 1
        border.color: "white"
        visible: lineVisible
    }
}
