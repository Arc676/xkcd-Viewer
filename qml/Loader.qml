// Copyright (C) 2018-20 Arc676/Alessandro Vinciguerra <alesvinciguerra@gmail.com>

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation (version 3)

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.

import QtQuick 2.4
import Ubuntu.Components 1.3
import QtQuick.Window 2.2

MainView {
	id: root
	objectName: 'mainView'
	applicationName: 'xkcdviewer.arc676'
	automaticOrientation: true
	property real margin: units.gu(2)

	width: units.gu(45)
	height: units.gu(75)

	PageStack {
		id: pageViewer
		anchors.fill: parent

		property SearchPage searchPage: SearchPage {
			visible: false
		}

		property Main comicView: Main {
			visible: false
		}

		Component.onCompleted: {
			pageViewer.clear()
			pageViewer.push(comicView)
		}
	}
}
