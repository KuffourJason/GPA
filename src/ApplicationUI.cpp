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

#include "ApplicationUI.hpp"
#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/LocaleHandler>
#include <bb/cascades/Container>
#include <bb/cascades/Label>
#include <bb/cascades/Page>
#include <bb/cascades/TouchEvent>
#include <QVariant>
#include <QMap>
#include <bb/cascades/SceneCover>
#include <QDataStream>
#include <QByteArray>

using namespace bb::cascades;



//Add the stuff for the help menu
//
//Handle the system toast stuff for when the file has been successfully
//loaded and saved by sending a signal to QML
//

AbstractPane *root;
QDeclarativePropertyMap *propertyMap;

ApplicationUI::ApplicationUI(QObject *parent) :
        QObject(parent)
{
    // prepare the localization
    m_pTranslator = new QTranslator(this);
    m_pLocaleHandler = new LocaleHandler(this);

    bool res = QObject::connect(m_pLocaleHandler, SIGNAL(systemLanguageChanged()), this, SLOT(onSystemLanguageChanged()));
    // This is only available in Debug builds
    Q_ASSERT(res);
    // Since the variable is not used in the app, this is added to avoid a compiler warning
    Q_UNUSED(res);

    // initial load
    onSystemLanguageChanged();

    // Create scene document from main.qml asset, the parent is set
    // to ensure the document gets destroyed properly at shut down.
    QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);

    qml->setContextProperty("oldStuff", this);
    propertyMap = new QDeclarativePropertyMap;
    qml->setContextProperty("propertyMap", propertyMap);

    // Create root object for the UI
    root = qml->createRootObject<AbstractPane>();

    // Set created root object as the application scene
    Application::instance()->setScene(root);

    top = root->findChild<Container*>("top");
    cRedits = root->findChild<Label*>("cRedits");
    gPa = root->findChild<Label*>("gPa");
    clear_Button = root->findChild<Label*>("clear_Button");
    add = root->findChild<Label*>("add");
    holder = root->findChild<Container*>("mai");
    save = root->findChild<ActionItem*>("save");
    load = root->findChild<ActionItem*>("load");

    bool clearSig = connect( clear_Button, SIGNAL( touch(bb::cascades::TouchEvent *) ), this, SLOT( clearAll(bb::cascades::TouchEvent *) ) );
    Q_ASSERT( clearSig );
    Q_UNUSED(clearSig);

    bool credSig = connect( add, SIGNAL( cREDChange() ), this, SLOT(updateCred() ) );
    Q_ASSERT( credSig );
    Q_UNUSED(credSig);

    bool gradSig = connect( add, SIGNAL( gRADChange() ), this, SLOT(updateGP() ) );
    Q_ASSERT( gradSig );
    Q_UNUSED(gradSig);

    bool removedSig = connect( add, SIGNAL( courRemoved() ), this, SLOT(courseRemoved() ) );
    Q_ASSERT( removedSig );
    Q_UNUSED( removedSig);

    bool saveSig = connect( top, SIGNAL( done() ), this, SLOT(saveValues() ) );
    Q_ASSERT( saveSig );
    Q_UNUSED( saveSig);

}

void ApplicationUI::saveValues()
{
    QFile file("data/stat.txt");
    file.open( QIODevice::WriteOnly );
    QFile file1("data/old.bin");
    file1.open( QIODevice::WriteOnly );
    QDataStream stream1( &file1);
    QDataStream stream( &file );
    stream1 << map;

    stream << this->finalGPA << this->numCredits;
}

void ApplicationUI::loadValues(){

    if( this->opened == false){

        QMap<int, pane> temp;

        QFile file1("data/stat.txt");
        file1.open( QIODevice::ReadOnly | QIODevice::Text );
        QFile file("data/old.bin");
        file.open( QIODevice::ReadOnly | QIODevice::Text );
        QDataStream stream( &file);
        QDataStream stream1( &file1);

        stream >> temp;
        stream1 >> this->finalGPA >> this->numCredits;

        double value = ( this->finalGPA / this->numCredits );

        if( isnan( value ) == 1 ){ value = 0; }
        QString upp = QString::number(value, 'g',3);
        gPa.data()->setText(upp);

        QString up = QString::number( this->numCredits, 10);
        cRedits.data()->setText( up );

        QMap<int,pane>::iterator it = temp.begin();

        int num = 1;

        while ( it != temp.end() ){

            map[num] = it.value();

            qDebug() << endl << "The value of key " << num << " is " + it.value().course_name << endl << endl;

            propertyMap->setProperty("cou", it.value().course_name);
            propertyMap->setProperty("cre", it.value().credit_value);
            propertyMap->setProperty("gra", it.value().letter_grade);
            propertyMap->setProperty("key", num );
            emit mySignal();
            num++;
            it++;
        }

        this->opened = true;
    }
}

//Obtains the recently added course's credits and updates the displayed field
void ApplicationUI::updateCred()
{
    bool *ok = new bool();
    int sp = add.data()->property("cREDIT").toInt( ok);
    ApplicationUI::setcurrCred(sp);
    updateGP( add.data()->property("gRADE").toString() ); // Added this line
    updateCredits( false, sp );
    updateGPA( false, gpa*currCred);

    pane element;
    element.credit_value = sp;
    element.letter_grade = add.data()->property("gRADE").toString();
    element.course_name = add.data()->property("cour_name").toString();
    map.insert( add.data()->property("kEY").toInt(ok), element);
}

//Converts the grade letter to its grade point value
void ApplicationUI::updateGP()
{
    int gpA = 0;
    QString text = add.data()->property("gRADE").toString();

    if     ( text.compare("A+") == 0 ){ gpA = 9;  }
    else if( text.compare("A") == 0  ){ gpA = 8;  }
    else if( text.compare("B+") == 0 ){ gpA = 7;  }
    else if( text.compare("B") == 0  ){ gpA = 6;  }
    else if( text.compare("C+") == 0 ){ gpA = 5;  }
    else if( text.compare("C") == 0  ){ gpA = 4;  }
    else if( text.compare("D+") == 0 ){ gpA = 3;  }
    else if( text.compare("D") == 0  ){ gpA = 2;  }
    else if( text.compare("E") == 0  ){ gpA = 1;  }

    gpa = gpA;

    //Added everything that follows
    bool *ok = new bool();
    int sp = add.data()->property("cREDIT").toInt( ok);
    ApplicationUI::setcurrCred(sp);
    updateCredits( false, sp );
    updateGPA( false, gpa*currCred);
}

//Used by the course removed function
void ApplicationUI::updateGP( QString text )
{
    int gpA = 0;

    if     ( text.compare("A+") == 0 ){ gpA = 9;  }
    else if( text.compare("A") == 0  ){ gpA = 8;  }
    else if( text.compare("B+") == 0 ){ gpA = 7;  }
    else if( text.compare("B") == 0  ){ gpA = 6;  }
    else if( text.compare("C+") == 0 ){ gpA = 5;  }
    else if( text.compare("C") == 0  ){ gpA = 4;  }
    else if( text.compare("D+") == 0 ){ gpA = 3;  }
    else if( text.compare("D") == 0  ){ gpA = 2;  }
    else if( text.compare("E") == 0  ){ gpA = 1;  }

    gpa = gpA;
}

//Updates the total number of credits displayed and used
void ApplicationUI::updateCredits(bool clear, int update)
{
    if( clear){
        cRedits.data()->setText("0");
        ApplicationUI::setnumCred(-10);
    }
    else{
        ApplicationUI::setnumCred(update);
        QString up = QString::number( ApplicationUI::getnumCred(), 10);
        cRedits.data()->setText( up );
    }
}

//Re-calculates and displays the GPA
void ApplicationUI::updateGPA( bool clear, int update)
{
    if( clear){
           gPa.data()->setText("0");
           ApplicationUI::setfinalGPA(-10);
    }
    else{
        ApplicationUI::setfinalGPA(update);
        double value = ( ApplicationUI::getfinalGPA() / ApplicationUI::getnumCred() );

        if( isnan( value ) == 1 ){ value = 0; }
        QString upp = QString::number(value, 'g',3);
        gPa.data()->setText(upp);
    }
}

//Resets the everything to 0
void ApplicationUI::clearAll( bb::cascades::TouchEvent *event)
{
    holder->removeAll();
    updateCredits(true, -10);
    updateGPA(true, -10);

    map.clear();
}

int ApplicationUI::numCredits = 0;
double ApplicationUI::finalGPA = 0;
int ApplicationUI::currCred = 0;
int ApplicationUI::gpa = 0;
bool ApplicationUI::opened = false;

//Updates the finalGPA and numOfCreds so that it reflects the deleted values
void ApplicationUI::courseRemoved(){

    bool *ok = new bool();
    int sup = add.data()->property("removeCredit").toInt( ok);
    ApplicationUI::setcurrCred( -sup);
    updateGP( add.data()->property("removeGrade").toString() );

    map.remove( add.data()->property("kEY").toInt());

    updateCredits( false, -sup );
    updateGPA( false, gpa*currCred);
    Q_ASSERT( ok );
    Q_UNUSED(ok);
}

//Setter method for the static field numCred
void ApplicationUI::setnumCred( int credd ){
    if( credd == -10){ numCredits = 0; currCred = 0; }
    else { numCredits = numCredits + credd; }
}

//Setter method for the static field finalGPA
void ApplicationUI::setfinalGPA( double gp ){
    if( gp == -10 ){ finalGPA = 0; gpa = 0; }
    else{ finalGPA = finalGPA + gp; }
}

//Setter method for the static field currCred
void ApplicationUI::setcurrCred( int cred ){
    currCred = cred;
}

//Getter method for the static field numCred
int ApplicationUI::getnumCred(){
    return numCredits;
}

//Getter method for the static field currCred
int ApplicationUI::getcurrCred(){
    return currCred;
}

//Getter method for the static field finalGPA
double ApplicationUI::getfinalGPA(){
    return finalGPA;
}


void ApplicationUI::onSystemLanguageChanged()
{
    QCoreApplication::instance()->removeTranslator(m_pTranslator);
    // Initiate, load and install the application translation files.
    QString locale_string = QLocale().name();
    QString file_name = QString("Practice_%1").arg(locale_string);
    if (m_pTranslator->load(file_name, "app/native/qm")) {
        QCoreApplication::instance()->installTranslator(m_pTranslator);
    }
}
