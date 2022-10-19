import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: 800
    height: 480
    title: qsTr("Hello World")

    //ADD FONTS
    FontLoader
    {
    id: fontHeveticaSemibold
    source: "qrc:fonts/fonts/HELVETIC.ttf"
    }
    FontLoader
    {
    id: fontOpenSans
    source: "qrc:fonts/fonts/OpenSans-Light.ttf"
    }

    Timer
    {
    interval: 1000// 1 second
    running: true
    repeat: true
    onTriggered:
    {
        time.text = Qt.formatDateTime(new Date(), "hh:mm:ss")
        date.text = Qt.formatDateTime(new Date(), "dddd dd MMMM")
    }
    }




    Rectangle
    {
      id: rectDateTime
      width: parent.width
      height: parent.height
      anchors.horizontalCenter: parent.horizontalCentre
      anchors.top: parent.top
      color: "#233343"

      //Time
      Rectangle
      {
        id: rectTime
        anchors.horizontalCenter: parent.horizontalCentre
        anchors.top: parent.top
        anchors.topMargin: 25
        width: parent.width
        height: 100
        color: "transparent"

        Text {
           id: time
           text: qsTr("10:25")
            anchors.centerIn: parent
            color: "white"
            font.pointSize: 80
            font.family: fontOpenSans.name
            }
    }
      Rectangle
      {
        id: rectDate
        anchors.horizontalCenter: parent.horizontalCentre
        anchors.top: rectTime.bottom
        width: parent.width
        height: 60
        color: "transparent"

        Text {
            id: date
            text: qsTr("October 20 2022")
            anchors.centerIn: parent
            color: "white"
            font.pointSize: 25
            font.family: fontOpenSans.name
        }

    }
      // today Weather
      ItemWeather
      {
        id: weather0
        height: 130
        width: 150
        anchors.top: rectDate.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        scaleFactor: 1.8
        lineVisible: false
      }

      // weather from tomorrow

      Rectangle
      {
          width: parent.width *0.9
          height: 150
          anchors.horizontalCenter: parent.horizontalCenter
          anchors.bottom: parent.bottom
          color: "transparent"

          Rectangle
          {
              id: horizontalLine
              height: 1
              width: parent.width
              anchors.horizontalCenter: parent.horizontalCenter
              anchors.top: parent.top
              border.width: 1
              border.color: "white"
          }

         ItemWeather
        {
            id: weather1
            width: parent.width * 0.25
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            dayOfWeek: qsTr("Tuesday")
            lineVisible: false
        }

         ItemWeather
        {
            id: weather2
            width: parent.width * 0.25
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: weather1.right
            dayOfWeek: qsTr("Wednesday")
            lineVisible: false
        }
         ItemWeather
        {
            id: weather3
            width: parent.width * 0.25
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: weather2.right
            dayOfWeek: qsTr("Thursday")
            lineVisible: false
        }
         ItemWeather
        {
            id: weather4
            width: parent.width * 0.25
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: weather3.right
            dayOfWeek: qsTr("Friday")
            lineVisible: false
        }

      }
}
    //Creat an invisible buttom to try http request

    Rectangle
    {
        id: btnRequest
        width: 120
        height: 50
        anchors.top: parent.top
        anchors.right: parent.right
        color: "transparent"

        MouseArea
        {
            anchors.fill: parent
            onClicked:
            {
              appBridge.restApiRequest();
            }

        }
    }
    Connections
    {
        target: appBridge

        onDataChanged:
        {
          //today

                weather0.setIcon(appBridge.JsonData.DailyForecasts[0].Day.Icon)
                weather0.tempMin = appBridge.JsonData.DailyForecasts[0].Temperature.Minimum.Value + " C";
                weather0.tempMax = appBridge.JsonData.DailyForecasts[0].Temperature.Maximum.Value + " C";
        //1
            var date = new Date(appBridge.JsonData.DailyForecasts[1].EpochDate * 1000);
            weather1.dayOfWeek = Qt.formatDateTime(date, "dddd");
            weather1.setIcon(appBridge.JsonData.DailyForecasts[1].Day.Icon)
            weather1.tempMin = appBridge.JsonData.DailyForecasts[1].Temperature.Minimum.Value + " C";
            weather1.tempMax = appBridge.JsonData.DailyForecasts[1].Temperature.Maximum.Value + " C";
        //2
            date = new Date(appBridge.JsonData.DailyForecasts[2].EpochDate * 1000);
            weather2.dayOfWeek = Qt.formatDateTime(date, "dddd");
            weather2.setIcon(appBridge.JsonData.DailyForecasts[2].Day.Icon)
            weather2.tempMin = appBridge.JsonData.DailyForecasts[2].Temperature.Minimum.Value + " C";
            weather2.tempMax = appBridge.JsonData.DailyForecasts[2].Temperature.Maximum.Value + " C";
        //3
            date = new Date(appBridge.JsonData.DailyForecasts[3].EpochDate * 1000);
            weather3.dayOfWeek = Qt.formatDateTime(date, "dddd");
            weather3.setIcon(appBridge.JsonData.DailyForecasts[3].Day.Icon)
            weather3.tempMin = appBridge.JsonData.DailyForecasts[3].Temperature.Minimum.Value + " C";
            weather3.tempMax = appBridge.JsonData.DailyForecasts[3].Temperature.Maximum.Value + " C";

         //4
                date = new Date(appBridge.JsonData.DailyForecasts[4].EpochDate * 1000);
                weather4.dayOfWeek = Qt.formatDateTime(date, "dddd");
                weather4.setIcon(appBridge.JsonData.DailyForecasts[4].Day.Icon)
                weather4.tempMin = appBridge.JsonData.DailyForecasts[4].Temperature.Minimum.Value + " C";
                weather4.tempMax = appBridge.JsonData.DailyForecasts[4].Temperature.Maximum.Value + " C";

        }
    }

}
