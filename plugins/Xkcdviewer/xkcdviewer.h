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

#ifndef XKCDVIEWER_H
#define XKCDVIEWER_H

#include <QObject>

#include <cstdlib>
#include <ctime>

class Xkcdviewer: public QObject {
	Q_OBJECT

	int currentComic = -1;
	int latestComic = -1;

	/**
	 * Obtains the JSON data for the currently selected comic
	 */
	void updateJSON();

public:
	Xkcdviewer();

	/**
	 * Show the previous comic
	 */
	void prevComic();

	/**
	 * Show the next comic
	 */
	void nextComic();

	/**
	 * Show a random comic
	 */
	void randomComic();

	/**
	 * Show the title text for the current comic
	 */
	void showAltText();

	/**
	 * Go to the explainxkcd page for the current comic
	 */
	void explainComic();
};

#endif
