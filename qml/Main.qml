//Copyright (C) 2018  Arc676/Alessandro Vinciguerra <alesvinciguerra@gmail.com>

//This program is free software: you can redistribute it and/or modify
//it under the terms of the GNU General Public License as published by
//the Free Software Foundation (version 3) with the exception that
//linking the OpenSSL library is allowed.

//This program is distributed in the hope that it will be useful,
//but WITHOUT ANY WARRANTY; without even the implied warranty of
//MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//GNU General Public License for more details.

//You should have received a copy of the GNU General Public License
//along with this program.  If not, see <http://www.gnu.org/licenses/>.

import QtQuick 2.4
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import Xkcdviewer 1.0

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'xkcd_viewer.arc676'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

    property real margin: units.gu(2)

    Page {
        anchors.fill: parent

        header: PageHeader {
            id: header
            title: i18n.tr('xkcd Viewer')
        }

    	Row {
		id: buttons
		spacing: margin

		anchors {
			left: parent.left
			leftMargin: margin
			right: parent.right
			rightMargin: margin
			bottom: parent.bottom
			bottomMargin: margin
		}

		Button {
			id: prevComicBtn
			text: "<"
			onClicked: {
				Xkcdviewer.prevComic()
			}
		}

		Button {
			id: randomComicBtn
			text: i18n.tr("Random")
			onClicked: {
				Xkcdviewer.randomComic()
			}
		}

		Button {
			id: altTextBtn
			text: i18n.tr("Title Text")
		}

		Button {
			id: explainBtn
			text: i18n.tr("Explain")
		}

		Button {
			id: nextComicBtn
			text: ">"
			onClicked: {
				Xkcdviewer.nextComic()
			}
		}
	}
    }

}
