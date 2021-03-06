import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3
import STools.Extras 1.0
import STools.Utils 1.0
import Qt.labs.settings 1.0

import "Main"
import "Min"

ApplicationWindow {
	id: applicationWindow
	visible: true
	title: qsTr("Ten Player")

	// TODO find out where this function is used in the prev version
	function refresh() {
		if (StatusManager.needsRefresh)
		{
			StatusManager.needsRefresh = false
			MainManager.safeRefresh()
		}
	}

	Material.accent: theme.accent
	Material.primary: theme.primary
	Material.background: theme.background
	Material.foreground: theme.foreground
	Material.theme: ColorAlt.lightness(theme.background) > .5 ?
						Material.Light:Material.Dark

	Consts {
		id: consts
	}

	Theme {
		id: theme

		foreground: ColorAlt.lightness(theme.background) > .5 ? "black":"white"

		accent: !appSettings.colorFromArtwork || !ActiveInfo.artworkInfo
				? appSettings.accent:(ColorAlt.areDistant(colorExtractor.secondColor, colorExtractor.firstColor) ?
										  colorExtractor.secondColor:ColorAlt.toMiddle(colorExtractor.secondColor, .2))

		primary: !appSettings.colorFromArtwork || !ActiveInfo.artworkInfo
					? appSettings.primary:colorExtractor.firstColor

		background: !appSettings.colorFromArtwork || !ActiveInfo.artworkInfo
				? appSettings.background:(ColorAlt.lightness(colorExtractor.firstColor)>.5 ?
											  MaterialTheme.primary:MaterialTheme.primaryDark)
	}

	AppSettings {
		id: appSettings

		onCurrentLoaderChanged: print(currentLoader)

		property color accent: MaterialTheme.purple
		property color primary: MaterialTheme.teal
		property color background: MaterialTheme.primary
	}

	Settings {
		property alias currentLoader: appSettings.currentLoader

		property alias imageOpacity: appSettings.imageOpacity
		property alias minViewSize: appSettings.minViewSize

		property alias iconFromAccent: appSettings.iconFromAccent
		property alias colorFromArtwork: appSettings.colorFromArtwork
		property alias backgroundFromArtwork: appSettings.backgroundFromArtwork

		property alias backgroundSource: appSettings.backgroundSource

		property alias accent: appSettings.accent
		property alias primary: appSettings.primary
		property alias background: appSettings.background
	}

	Connections {
		target: ActiveInfo

		onRowChanged: if (appSettings.backgroundFromArtwork && ActiveInfo.artworkInfo)
								colorExtractor.extractImage(ActiveInfo.artworkInfo)
	}

	ColorExtractor {
		id: colorExtractor
	}

	StackView {
		id: appStack
		visible: !busy
		anchors.fill: parent
		initialItem: mainView

		Component {
			id: mainView
			MainView { objectName: "Main" }
		}

		Component {
			id: minView
			MinView { objectName: "Min" }
		}
	}

	BusyIndicator {
		running: appStack.busy
		anchors.centerIn: appStack
	}

	property bool isInMin: appStack.currentItem.objectName == "Min"
	flags: isInMin ? Qt.Window | Qt.FramelessWindowHint:Qt.Window
	property real minModeSize: 300

	height: isInMin ? minModeSize:600
	width: isInMin ? minModeSize:600*16/9

	minimumWidth: isInMin ? minModeSize:480
	minimumHeight: isInMin ? minModeSize:360
}
