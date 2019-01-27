//Copyright (C) 2018-9  Arc676/Alessandro Vinciguerra <alesvinciguerra@gmail.com>

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
import Ubuntu.Components 1.3

MainView {
	id: root
	objectName: 'mainView'
	applicationName: 'xkcdviewer.arc676'
	automaticOrientation: true

	width: units.gu(45)
	height: units.gu(75)

	Page {
		header: PageHeader {
			id: header
			title: i18n.tr("xkcd Viewer")

			Button {
				id: aboutButton
				text: i18n.tr("About")

				anchors {
					right: parent.right
					rightMargin: units.gu(2)
					verticalCenter: parent.verticalCenter
				}

				property bool onAbout: false

				onClicked: {
					onAbout = !onAbout;
					if (onAbout) {
						text = i18n.tr("Back")
						viewLoader.source = "About.qml"
					} else {
						text = i18n.tr("About")
						viewLoader.source = "Main.qml"
					}
				}
			}
		}

		Loader {
			id: viewLoader
			source: "Main.qml"

			anchors {
				top: header.bottom
				left: parent.left
				right: parent.right
				bottom: parent.bottom
			}
		}
	}
}
