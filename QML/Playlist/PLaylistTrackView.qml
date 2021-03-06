import QtQuick 2.10

import "../Track"

TrackView {
	id: view

	cellWidth: width/2
	cellHeight: 20 + consts.textSize*3

	model: PlaylistTrackModel {
		onMenuRequested: {
			menu.x = x-view.contentX
			menu.y = y-view.contentY
			menu.currentIndex = index
			menu.open()
		}
	}
}
