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

#include <QDebug>

#include "xkcdviewer.h"

Xkcdviewer::Xkcdviewer() {
	// init random
	srand((unsigned)time(0));
	// set up networking stuff
	netmgr = new QNetworkManager(this);
	dataBuffer = new QByteArray();
	// get latest comic
	downloadJSON();
}

QJsonObject Xkcdviewer::getComicData() {
	return comicData;
}

void Xkcdviewer::updateJSON() {
	downloadJSON();
}

void Xkcdviewer::downloadJSON() {
	// get URL of needed data
	QUrl url;
	if (currentComic > 0) {
		url = QUrl(QString("http://xkcd.com/%1/info.0.json").arg(currentComic));
	} else {
		url = QUrl("http://xkcd.com/info.0.json");
	}
	netreply = netmgr->get(QNetworkRequest(url));

	// connect signals
	connect(netreply, &QIODevice::readyRead, this, &Xkcdviewer::dataReady);
	connect(netreply, &QNetworkReply::finished, this, &Xkcdviewer::dataFinished);
}

void Xkcdviewer::dataReady() {
	dataBuffer->append(netreply->readAll());
}

void Xkcdviewer::dataFinished() {
	comicData = QJsonObject::fromJson(*dataBuffer);
}

void Xkcdviewer::prevComic() {
	if (currentComic > 1) {
		currentComic--;
		updateJSON();
	}
}

void Xkcdviewer::nextComic() {
	if (currentComic < latestComic) {
		currentComic++;
		updateJSON();
	}
}

void Xkcdviewer::randomComic() {
	// take note of the comic that was just seen
	int justSeen = currentComic;
	// use modulo to generate a random number in the range (0, latest - 1]
	// add 1 to make the range (1, latest - 1)
	currentComic = rand() % (latestComic - 1) + 1;
	// if the new comic number >= the one that was just seen, shift one over
	// the new comic is now in one of the ranges (1, justSeen], [justSeed, latest),
	// thus giving each comic equal probability (ignoring bias introduced by rand + mod)
	// while avoiding the same comic being picked by RNG
	if (currentComic >= justSeen) {
		currentComic++;
	}
	updateJSON();
}

void Xkcdviewer::explainComic() {
}

