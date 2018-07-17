#ifndef MAINMANAGER_H
#define MAINMANAGER_H

#include "albumloader.h"
#include "artistloader.h"
#include "playlistloader.h"
#include "queueloader.h"
#include "recentlyaddedloader.h"
#include "recentlyplayedloader.h"
#include "songloader.h"
#include "trackmanager.h"

#include "activeinfo.h"
#include "databasemanager.h"
#include "pathmanager.h"
#include "statusmanager.h"

#include <QObject>
#include <QVector>
#include <QtConcurrent/QtConcurrent>

class MainManager : public QObject
{
	Q_OBJECT

	void setupLoaders();

	void clearAll();
	void eraseAll();

	void load();
	void refresh();
	void loadDir(const QString &dir);
	void loadFiles(const QStringList &files);

	static void loadStatic(MainManager *manager);
	static void refreshStatic(MainManager *manager);
	static void loadDirStatic(MainManager *manager, const QString &path);
	static void loadFilesStatic(MainManager *manager, const QStringList &list);

public:
	ActiveInfo *Active;
	QueueLoader *Queue;
	StatusManager *Status;
	TrackManager *TrackMgr;
	PathManager *PathMgr;
	QVector<Loader *> Loaders;
	DatabaseManager *DatabaseMgr;

	explicit MainManager(QObject *parent = nullptr);

public slots:
	void safeLoad();
	void safeRefresh();
	void safeLoadDir(const QString &path);
	void safeLoadFiles(const QStringList &list);
};

#endif  // MAINMANAGER_H
