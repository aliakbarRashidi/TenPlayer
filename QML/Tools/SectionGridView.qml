import QtQuick 2.10
import STools.Extras 1.0 as M

M.SectionGridView {
	sectionBackgroundColor: theme.primary
	emptyText: "Nothing Here!"
	property int sectionTextIndex: 0
	onUpdateSectionText: sectionText = item ? item.model[sectionTextIndex][0]:""
}
