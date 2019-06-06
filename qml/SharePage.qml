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
import Ubuntu.Content 1.3
import XKCDviewer 1.0

Page {
	id: shareView
	title: i18n.tr("Send Comic To...")

	property var url

	function shareLink(url) {
		cpp.contentType = ContentType.Links
		shareView.url = url
	}

	function saveComic(url) {
		cpp.handler = ContentHandler.Destination
		shareView.url = url
	}

	function shareComic(url) {
		shareView.url = url
	}

	ContentPeerPicker {
		id: cpp
		objectName: "sharePicker"
		anchors.fill: parent
		contentType: ContentType.Pictures
		handler: ContentHandler.Share
		showTitle: false

		onPeerSelected: {
			pageStack.pop()
			var activeTransfer = peer.request()
			if (activeTransfer.state === ContentTransfer.InProgress) {
				activeTransfer.items = [ resultComponent.createObject(parent, {"url": parent.url}) ]
				activeTransfer.state = ContentTransfer.Charged
			}
		}

		onCancelPressed: pageStack.pop()
	}

	Component {
		id: resultComponent
		ContentItem {}
	}
}
