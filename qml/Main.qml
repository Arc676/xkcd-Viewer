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
import Ubuntu.Components 1.3
import XKCDviewer 1.0

MainView {
	id: root
	objectName: 'mainView'
	applicationName: 'xkcdviewer.arc676'
	automaticOrientation: true

	width: units.gu(45)
	height: units.gu(75)

	property real margin: units.gu(2)

	Connections {
		target: XKCDviewer
		onDoRefreshView: {
			var json = XKCDviewer.comicData
			comicTitle.text = json["title"]
			titleText.text = json["alt"]
		}

		onIsLoading: {
			showLoading()
		}

		onImageReady: {
			comic.source = XKCDviewer.imgPath
		}
	}

	function showLoading() {
		comic.source = "../assets/loading.png"
		comicTitle.text = ""
		titleText.text = ""
	}

	Page {
		anchors.fill: parent

		header: PageHeader {
			id: header
			title: i18n.tr("xkcd Viewer")
		}

		Row {
			id: topBar
			spacing: margin

			anchors {
				top: header.bottom
				topMargin: margin
				left: parent.left
				leftMargin: margin
				right: parent.right
				rightMargin: margin
			}

			Button {
				id: latestBtn
				text: i18n.tr("View latest")
				onClicked: {
					XKCDviewer.jumpToLatest()
				}
			}

			Button {
				id: refreshBtn
				text: i18n.tr("Reload from source")
				onClicked: {
					XKCDviewer.downloadJSON()
				}
			}
		}

		Label {
			id: comicTitle

			anchors {
				top: topBar.bottom
				topMargin: margin
				left: parent.left
				leftMargin: margin
				right: parent.right
				rightMargin: margin
			}
		}

		Image {
			id: comic
			source: "../assets/loading.png"
			fillMode: Image.PreserveAspectFit
			//height: parent.height - header.height - topBar.height - titleText.height - bottomBar.height - margin * 5

			anchors {
				top: comicTitle.bottom
				topMargin: margin
				left: parent.left
				leftMargin: margin
				right: parent.right
				rightMargin: margin
				bottom: titleText.top
				bottomMargin: margin
			}
		}

		Label {
			id: titleText
			text: ""

			anchors {
				left: parent.left
				leftMargin: margin
				right: parent.right
				rightMargin: margin
				bottom: bottomBar.top
				bottomMargin: margin
			}
		}

		Row {
			id: bottomBar
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
					XKCDviewer.prevComic()
				}
			}

			Button {
				id: randomComicBtn
				text: i18n.tr("Random")
				onClicked: {
					XKCDviewer.randomComic()
				}
			}

			Button {
				id: explainBtn
				text: i18n.tr("Explain")
				onClicked: {
					XKCDviewer.explainComic()
				}
			}

			Button {
				id: nextComicBtn
				text: ">"
				onClicked: {
					XKCDviewer.nextComic()
				}
			}
		}
	}

}
