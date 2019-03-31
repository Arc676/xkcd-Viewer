// Copyright (C) 2018-9  Arc676/Alessandro Vinciguerra <alesvinciguerra@gmail.com>

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation (version 3)

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

#include <QDebug>

#include "xkcdviewer.h"

XKCDviewer::XKCDviewer() {
	// init random
	srand((unsigned)time(0));
	// prepare for cache storage
	cacheDir = QStandardPaths::writableLocation(QStandardPaths::CacheLocation) + "/";
	if (!QDir(cacheDir).exists()) {
		QDir().mkdir(cacheDir);
	}
	// set up networking stuff
	netmgr = new QNetworkAccessManager(this);
	dataBuffer = new QByteArray();
}

void XKCDviewer::updateJSON() {
	// retrieve comic data from cache, if present
	QString comicCache = cacheDir + QString::number(currentComic);
	if (QDir(comicCache).exists()) {
		QFile file(comicCache + "/info.0.json");
		file.open(QIODevice::ReadOnly | QIODevice::Text);
		QString data = file.readAll();
		file.close();
		comicData = QJsonDocument::fromJson(data.toUtf8());
		imgPath = comicData.object().value("img").toString();
		imgPath = comicCache + "/" + imgPath.mid(imgPath.lastIndexOf("/") + 1);

		emit doRefreshView();
		emit imageReady();
	} else {
		downloadJSON();
	}
}

void XKCDviewer::downloadJSON() {
	emit isLoading();
	// get URL of needed data
	QUrl url;
	if (currentComic < 0) {
		url = QUrl("https://xkcd.com/info.0.json");
	} else {
		url = QUrl(QString("https://xkcd.com/%1/info.0.json").arg(currentComic));
	}
	netreply = netmgr->get(QNetworkRequest(url));

	// connect signals
	connect(netreply, &QIODevice::readyRead, this, &XKCDviewer::dataReady);
	connect(netreply, &QNetworkReply::finished, this, &XKCDviewer::dataFinished);
}

void XKCDviewer::dataReady() {
	dataBuffer->append(netreply->readAll());
}

void XKCDviewer::dataFinished() {
	comicData = QJsonDocument::fromJson(*dataBuffer);
	emit doRefreshView();
	if (currentComic < 0) {
		latestComic = comicData.object().value("num").toInt();
		currentComic = latestComic;
	}
	// create cache directory for comic if non-existent
	QString comicCache = cacheDir + QString::number(currentComic);
	if (!QDir(comicCache).exists()) {
		QDir().mkdir(comicCache);
	}
	// write JSON to cache
	QFile file(comicCache + "/info.0.json");
	file.open(QIODevice::WriteOnly);
	file.write(*dataBuffer);
	file.close();

	networkCleanup();

	// download comic image
	QUrl url(comicData.object().value("img").toString());
	netreply = netmgr->get(QNetworkRequest(url));

	// connect signals
	connect(netreply, &QIODevice::readyRead, this, &XKCDviewer::dataReady);
	connect(netreply, &QNetworkReply::finished, this, &XKCDviewer::imageFinished);
}

void XKCDviewer::imageFinished() {
	imgPath = comicData.object().value("img").toString();
	imgPath = cacheDir + QString::number(currentComic) + "/" + imgPath.mid(imgPath.lastIndexOf("/") + 1);
	QFile imgFile(imgPath);
	imgFile.open(QIODevice::WriteOnly);
	imgFile.write(*dataBuffer);
	imgFile.close();

	networkCleanup();

	emit imageReady();
}

void XKCDviewer::networkCleanup() {
	netreply->deleteLater();
	netreply = nullptr;
	dataBuffer->clear();
}

QJsonObject XKCDviewer::getComicData() {
	return comicData.object();
}

void XKCDviewer::jumpToLatest() {
	currentComic = -1;
	updateJSON();
}

void XKCDviewer::prevComic() {
	if (currentComic > 1) {
		currentComic--;
		updateJSON();
	}
}

void XKCDviewer::nextComic() {
	if (currentComic < latestComic) {
		currentComic++;
		updateJSON();
	}
}

void XKCDviewer::randomComic() {
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

void XKCDviewer::explainComic() {
	QDesktopServices::openUrl(QUrl("https://www.explainxkcd.com/" + QString::number(currentComic)));
}

QString XKCDviewer::plain(QString input) {
	QTextDocument text;
	text.setHtml(input);
	return text.toPlainText();
}
