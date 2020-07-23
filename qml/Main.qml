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
import Ubuntu.Components.Popups 1.3
import XKCDviewer 1.0

Page {
	id: comicView
	header: DefaultHeader {}

	Component.onCompleted: XKCDviewer.jumpToLatest()

	function jumpToComic() {
		PopupUtils.open(jumpDialog, comicView, {})
	}

	function latestCached() {
		XKCDviewer.latestCached()
	}

	Component {
		id: jumpDialog

		JumpDialog {
			onJump: {
				XKCDviewer.jumpTo(selected)
			}
		}
	}

	property SharePage sharePage: SharePage { visible: false }

	function saveComic() {
		var page = pageStack.push(sharePage)
		page.saveComic(XKCDviewer.imgPath)
	}

	function shareLink() {
		var json = XKCDviewer.comicData
		var comicNum = json["num"]
		var page = pageStack.push(sharePage)
		page.shareLink("https://xkcd.com/" + comicNum)
	}

	function shareComic() {
		var page = pageStack.push(sharePage)
		page.shareComic(XKCDviewer.imgPath)
	}

	function unescapeHTML(text) {
		return text.replace(/&amp;eacute;/g, "é").replace(/&quot;/g, "\"")
	}

	Connections {
		target: XKCDviewer
		onDoRefreshView: {
			var json = XKCDviewer.comicData
			comicTitle.text = json["num"] + ": " + unescapeHTML(XKCDviewer.valueToPlainText("title"))
			titleText.text = unescapeHTML(XKCDviewer.valueToPlainText("alt"))

			// update JSON model
			jsonModel.clear()
			for (var key in json) {
				jsonModel.append({"key" : key, "value" : unescapeHTML(XKCDviewer.valueToPlainText(key))})
			}
		}

		onIsLoading: {
			showLoading()
		}

		onImageReady: {
			comic.source = XKCDviewer.imgPath
			var aspectRatio = comic.implicitHeight / comic.implicitWidth

			// scale image to fit in flickable container
			// then center image in view
			if (flick.width * aspectRatio > flick.height) {
				// tall/portrait images
				flick.contentHeight = flick.height
				flick.contentWidth = flick.height / aspectRatio

				flick.contentX = -(flick.width - flick.contentWidth) / 2
			} else {
				// wide/landscape images
				flick.contentWidth = flick.width
				flick.contentHeight = flick.width * aspectRatio

				flick.contentY = -(flick.height - flick.contentHeight) / 2
			}
		}
	}

	function showLoading() {
		comic.source = "../assets/loading.png"
		flick.contentWidth = flick.width
		flick.contentHeight = flick.height
		comicTitle.text = ""
		titleText.text = ""
	}

	Label {
		id: comicTitle

		anchors {
			top: header.bottom
			topMargin: margin
			left: parent.left
			leftMargin: margin
			right: parent.right
			rightMargin: margin
		}
	}

	Flickable {
		id: flick

		contentWidth: width

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

		PinchArea {
			property real w0
			property real h0
			anchors.fill: parent

			onPinchStarted: {
				w0 = flick.contentWidth
				h0 = flick.contentHeight
			}

			onPinchUpdated: {
				flick.contentX += pinch.previousCenter.x - pinch.center.x
				flick.contentY += pinch.previousCenter.y - pinch.center.y

				flick.resizeContent(w0 * pinch.scale, h0 * pinch.scale, pinch.center)
			}

			onPinchFinished: {
				flick.returnToBounds()
			}	

			AnimatedImage {
				id: comic
				source: "../assets/loading.png"
				anchors.fill: parent
				onStatusChanged: playing = (status == AnimatedImage.Ready)
			}
		}
	}

	ListView {
		id: jsonView
		visible: false
		model: jsonModel
		delegate: jsonDelegate
		anchors {
			top: comicTitle.bottom
			topMargin: margin
			left: parent.left
			leftMargin: margin
			right: parent.right
			rightMargin: margin
			bottom: bottomBar.top
			bottomMargin: margin
		}
	}

	ListModel {
		id: jsonModel
	}

	Component {
		id: jsonDelegate
		Row {
			spacing: margin
			Text {
				id: keyLabel
				wrapMode: Text.Wrap
				text: key
				width: units.gu(10)
			}
			Text {
				wrapMode: Text.Wrap
				text: "" + value
				width: parent.parent.width - keyLabel.width - margin
			}
		}
	}

	Label {
		id: titleText
		wrapMode: Text.Wrap

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
		height: units.gu(4)

		anchors {
			left: parent.left
			leftMargin: margin
			right: parent.right
			rightMargin: margin
			bottom: parent.bottom
			bottomMargin: margin
		}

		Image {
			id: prevComicBtn
			source: "../assets/back.png"
			height: parent.height
			width: height
			anchors.verticalCenter: parent.verticalCenter
			MouseArea {
				anchors.fill: parent
				onClicked: {
					XKCDviewer.prevComic()
				}
			}
		}

		Image {
			id: randomComicBtn
			source: "../assets/r4.png"
			height: parent.height * 1.5
			width: height
			anchors.verticalCenter: parent.verticalCenter
			MouseArea {
				anchors.fill: parent
				onClicked: {
					XKCDviewer.randomComic()
					var n = Math.floor(Math.random() * 6) + 1
					randomComicBtn.source = "../assets/r" + n + ".png"
				}
			}
		}

		Image {
			id: refreshBtn
			source: "../assets/refresh.png"
			height: parent.height
			width: height
			anchors.verticalCenter: parent.verticalCenter

			MouseArea {
				anchors.fill: parent
				onClicked: {
					XKCDviewer.downloadJSON()
				}
			}
		}

		Image {
			id: comicInfoBtn
			source: "../assets/json.png"
			height: parent.height
			width: height
			anchors.verticalCenter: parent.verticalCenter

			MouseArea {
				anchors.fill: parent
				property bool showingJSON: false

				onClicked: {
					showingJSON = !showingJSON
					jsonView.visible = showingJSON
					flick.visible = !showingJSON
					titleText.visible = !showingJSON
				}
			}
		}

		Image {
			id: explainBtn
			source: "../assets/explain.png"
			height: parent.height
			width: height
			anchors.verticalCenter: parent.verticalCenter
			MouseArea {
				anchors.fill: parent
				onClicked: {
					XKCDviewer.explainComic()
				}
			}
		}

		Image {
			id: nextComicBtn
			source: "../assets/next.png"
			height: parent.height
			width: height
			anchors.verticalCenter: parent.verticalCenter
			MouseArea {
				anchors.fill: parent
				onClicked: {
					XKCDviewer.nextComic()
				}
			}
		}

		Image {
			id: latestBtn
			source: "../assets/last.png"
			height: parent.height
			width: height
			anchors.verticalCenter: parent.verticalCenter
			MouseArea {
				anchors.fill: parent
				onClicked: {
					XKCDviewer.jumpToLatest()
				}
			}
		}
	}

}
