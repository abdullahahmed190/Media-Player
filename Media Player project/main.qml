import QtQuick 2.15
import QtQuick.Controls 2.15
import QtMultimedia 5.15

ApplicationWindow {
    width: 400
    height: 300
    visible: true
    title: "Video Player"

    MediaPlayer {
        id: mediaPlayer
    }

    VideoOutput {
        id: videoOutput
        anchors.fill: parent
        source: mediaPlayer

        MouseArea {
            anchors.fill: parent
            onPressed: {
                mediaPlayer.seek(videoSlider.value * mediaPlayer.duration)
            }
        }
    }

    Slider {
        id: videoSlider
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            bottomMargin: 10
        }
        from: 0
        to: mediaPlayer.duration
        value: mediaPlayer.position
    }

    Row {
        anchors.centerIn: parent

        Button {
            text: mediaPlayer.playbackState === MediaPlayer.PlayingState ? "Pause" : "Play"
            onClicked: {
                if (mediaPlayer.playbackState === MediaPlayer.PlayingState) {
                    mediaPlayer.pause()
                } else {
                    mediaPlayer.play()
                }
            }
        }
    }

    FileDialog {
        id: fileDialog
        title: "Select a Video File"
        folder: shortcuts.home
        nameFilters: ["Video Files (*.mp4 *.avi *.mkv)"]
        onAccepted: {
            mediaPlayer.source = fileDialog.fileUrl
            mediaPlayer.play()
        }
    }

    Component.onCompleted: {
        fileDialog.open()
    }
}
