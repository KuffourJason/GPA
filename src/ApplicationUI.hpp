/*
 * Copyright (c) 2011-2014 BlackBerry Limited.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#ifndef ApplicationUI_HPP_
#define ApplicationUI_HPP_

#include <QObject>
#include <bb/cascades/Label>
#include <bb/cascades/Button>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/ActionItem>

namespace bb
{
    namespace cascades
    {
        class LocaleHandler;
    }
}

class QTranslator;

/*!
 * @brief Application UI object
 *
 * Use this object to create and init app UI, to create context objects, to register the new meta types etc.
 */
class ApplicationUI : public QObject
{
    Q_OBJECT
public:
    ApplicationUI( QObject *parent = 0);
    virtual ~ApplicationUI() {}
    static int numCredits;
    static int currCred;
    static int gpa;
    static double finalGPA;

private slots:
    void onSystemLanguageChanged();

private:
    QTranslator* m_pTranslator;
    bb::cascades::LocaleHandler* m_pLocaleHandler;
    QPointer <bb::cascades::Label> cRedits;
    QPointer <bb::cascades::Label> clear_Button;
    QPointer <bb::cascades::Label> gPa;
    QPointer <bb::cascades::Label> add;
    QPointer <bb::cascades::ActionItem> save;
    QPointer <bb::cascades::ActionItem> load;
    bb::cascades::Container* holder;

    void updateCredits(bool clear, int update);
    void updateGPA(bool clear, int update);
    void setnumCred( int cred );
    int getnumCred();
    void setcurrCred( int cred );
    int getcurrCred();
    void setfinalGPA( double gpa );
    double getfinalGPA();

public slots:
    void clearAll(bb::cascades::TouchEvent *event);
    void updateCred();
    void updateGP();
    void updateGP( QString text);
    void courseRemoved();
    void saveValues();
    void loadValues();
};


#endif /* ApplicationUI_HPP_ */
