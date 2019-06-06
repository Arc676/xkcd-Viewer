// Copyright (C) 2019  Arc676/Alessandro Vinciguerra <alesvinciguerra@gmail.com>

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation (version 3)

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

import QtQuick 2.4
import Ubuntu.Components 1.3
import XKCDviewer 1.0

Page {
	id: searchView
	header: DefaultHeader {}

	Row {
		id: searchRow
		spacing: margin
		anchors {
			top: header.bottom
			topMargin: margin
			left: parent.left
			leftMargin: margin
			right: parent.right
			rightMargin: margin
		}

		Label {
			text: i18n.tr("Query:")
			anchors.verticalCenter: searchField.verticalCenter
		}

		TextField {
			id: searchField
		}

		Button {
			text: i18n.tr("Search")
			onClicked: {
				var query = searchField.text
				searchResults.model.load(XKCDviewer.search(query))
			}
		}
	}

	ListView {
		id: searchResults
		clip: true
		anchors {
			top: searchRow.bottom
			topMargin: margin
			left: parent.left
			leftMargin: margin
			right: parent.right
			rightMargin: margin
			bottom: parent.bottom
			bottomMargin: margin
		}
		model: SearchResultsModel {}
		delegate: ListItem {
			Label {
				text: comicID["num"] + ": " + comicID["title"]
			}

			onClicked: {
				pageStack.pop()
				XKCDviewer.jumpTo(comicID["num"])
			}
		}
	}
}
