#include "apirest.h"

ApiRest::ApiRest(QObject *parent) : QObject(parent)
{
    QObject::connect(&m_NetworkAccessManager,SIGNAL(finished(QNetworkReply*)), this,SLOT(onRestApiFinished(QNetworkReply*)));
}

QJsonObject ApiRest::JsonData() const
{
    return m_JsonData;
}

void ApiRest::setJsonData(const QJsonObject& data)
{
    m_JsonData =data;
    emit dataChanged(m_JsonData);
}

void ApiRest::restApiRequest()
{
    QNetworkRequest request;
    QUrl url("http://dataservice.accuweather.com/forecasts/v1/daily/5day/210841?apikey=io1kAbo7bmZ8j4Al00JpCeuhQBDTYpLC&metric=true");

    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/Json");
    request.setUrl(url);
    m_NetworkAccessManager.get(request);
}

void ApiRest::onRestApiFinished(QNetworkReply *reply)
{
    QJsonDocument jsdoc = QJsonDocument::fromJson(reply->readAll());
    setJsonData(jsdoc.object());
    QByteArray docByteArray = jsdoc.toJson(QJsonDocument::Compact);
    qDebug() << QLatin1String(docByteArray);
}
