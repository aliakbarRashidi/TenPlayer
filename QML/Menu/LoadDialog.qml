import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

Popup {
	id: popup
	modal: true
	padding: 20
	width: parent.width*.6
	visible: StatusManager.loading

	x: (parent.width-width) / 2
	y: (parent.height-height) / 2

	closePolicy: Popup.NoAutoClose

	contentItem: ColumnLayout {
		Label {
			Layout.fillWidth: true
			text: StatusManager.status
			elide: Text.ElideRight
		}

		ProgressBar {
			Layout.fillWidth: true
			to: StatusManager.top
			value: StatusManager.value
			indeterminate: StatusManager.top == 0 && StatusManager.value == 0
			Material.accent: theme.accent == theme.background ? theme.primary:theme.accent
		}

		Label {
			Layout.fillWidth: true
			text: StatusManager.file
			elide: Text.ElideRight
		}
	}
}
