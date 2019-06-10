// Copyright (C) 2019 Arc676/Alessandro Vinciguerra <alesvinciguerra@gmail.com>

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation (version 3)

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.

#include <QAbstractTableModel>
#include <QList>
#include <QVariant>
#include <QJsonDocument>
#include <QJsonObject>

class SearchResultsModel : public QAbstractTableModel {
	Q_OBJECT

	QList<QVariant> searchResults;

	enum {
		ComicCol = Qt::UserRole
	};
public:
	int columnCount(const QModelIndex &parent) const;
	int rowCount(const QModelIndex &parent = QModelIndex()) const;
	QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
	QHash<int, QByteArray> roleNames() const;

	/**
	 * Load a set of search results into the table
	 * @param results The obtained search results
	 * @return Whether there are any search results to display
	 */
	Q_INVOKABLE bool load(QList<QVariant> results);

	/**
	 * Utility function for refreshing the table
	 */
	Q_INVOKABLE void emitReset();
};
