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

#include "searchresultsmodel.h"

int SearchResultsModel::columnCount(const QModelIndex &parent) const {
	return 1;
}

int SearchResultsModel::rowCount(const QModelIndex &parent) const {
	return searchResults.length();
}

QVariant SearchResultsModel::data(const QModelIndex &index, int role) const {
	QJsonDocument json = searchResults[index.row()].toJsonDocument();
	QString num = QString::number(json.object().value("num").toInt());
	QString ret = QString("%1: %2").arg(num, json.object().value("title").toString());
	return QVariant(ret);
}

QHash<int, QByteArray> SearchResultsModel::roleNames() const {
	QHash<int, QByteArray> names;
	names[ComicCol] = "comicID";
	return names;
}

void SearchResultsModel::load(QList<QVariant> results) {
	searchResults = results;
	emitReset();
}

void SearchResultsModel::emitReset() {
	beginResetModel();
	endResetModel();
}
