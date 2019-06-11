// Copyright (C) 2018-9 Arc676/Alessandro Vinciguerra <alesvinciguerra@gmail.com>

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
import Ubuntu.Components.ListItems 1.3 as ListItem

Page {
	id: aboutView
	header: DefaultHeader {}
	
	property real margin: units.gu(2)

	ListItem.ItemSelector {
		id: selector
		anchors {
			top: header.bottom
			topMargin: margin
			bottomMargin: margin
			leftMargin: margin
			rightMargin: margin
			horizontalCenter: parent.horizontalCenter
		}

		model: [
			"GPLv3 - xkcd Viewer by Arc676",
			"CC BY-NC 2.5 - xkcd by Randall Munroe",
			"MIT - icons by Michael Amaral"
		]

		expanded: false

		onDelegateClicked: {
			gplv3.visible = false
			ccbync.visible = false
			mit.visible = false

			switch (index) {
			default:
			case 0:
				gplv3.visible = true
				break
			case 1:
				ccbync.visible = true
				break
			case 2:
				mit.visible = true
				break
			}
		}
	}

	Item {
		anchors {
			top: selector.bottom
			topMargin: margin
			left: parent.left
			leftMargin: margin
			right: parent.right
			rightMargin: margin
			bottom: parent.bottom
			bottomMargin: margin
		}

		Label {
			id: gplv3

			anchors.fill: parent
			wrapMode: Text.Wrap

			text: "Copyright (C) 2018-9 Arc676/Alessandro Vinciguerra &lt;alesvinciguerra@gmail.com&gt;<br><br>This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation (version 3).<br><br>This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.<br><br>You should have received a copy of the GNU General Public License along with this program. If not, see &lt;http://www.gnu.org/licenses/&gt;."
		}

		Label {
			id: ccbync

			anchors.fill: parent
			wrapMode: Text.Wrap

			visible: false

			text: "XKCD comics by Randall Munroe published under CC BY-NC 2.5 &lt;http://creativecommons.org/licenses/by-nc/2.5/&gt;<br><br>You may copy and share these comics, but not sell them. You must provide attribution when sharing.<br><br>This short summary is not a replacement for the full license text and has no legal value."
		}

		Label {
			id: mit

			anchors.fill: parent
			wrapMode: Text.Wrap

			visible: false

			text: "App icon and loading icon published under MIT license by Michael Amaral<br>Copyright (c) 2015 Michael Amaral<br><br>Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \"Software\"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:<br><br>The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.<br><br>THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE."
		}
	}
}
