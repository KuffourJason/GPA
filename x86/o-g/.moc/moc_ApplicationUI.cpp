/****************************************************************************
** Meta object code from reading C++ file 'ApplicationUI.hpp'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.6)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../src/ApplicationUI.hpp"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'ApplicationUI.hpp' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.6. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_ApplicationUI[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
       9,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: signature, parameters, type, tag, flags
      15,   14,   14,   14, 0x05,

 // slots: signature, parameters, type, tag, flags
      26,   14,   14,   14, 0x08,
      58,   52,   14,   14, 0x0a,
      94,   14,   14,   14, 0x0a,
     107,   14,   14,   14, 0x0a,
     123,  118,   14,   14, 0x0a,
     141,   14,   14,   14, 0x0a,
     157,   14,   14,   14, 0x0a,
     170,   14,   14,   14, 0x0a,

       0        // eod
};

static const char qt_meta_stringdata_ApplicationUI[] = {
    "ApplicationUI\0\0mySignal()\0"
    "onSystemLanguageChanged()\0event\0"
    "clearAll(bb::cascades::TouchEvent*)\0"
    "updateCred()\0updateGP()\0text\0"
    "updateGP(QString)\0courseRemoved()\0"
    "saveValues()\0loadValues()\0"
};

void ApplicationUI::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        ApplicationUI *_t = static_cast<ApplicationUI *>(_o);
        switch (_id) {
        case 0: _t->mySignal(); break;
        case 1: _t->onSystemLanguageChanged(); break;
        case 2: _t->clearAll((*reinterpret_cast< bb::cascades::TouchEvent*(*)>(_a[1]))); break;
        case 3: _t->updateCred(); break;
        case 4: _t->updateGP(); break;
        case 5: _t->updateGP((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 6: _t->courseRemoved(); break;
        case 7: _t->saveValues(); break;
        case 8: _t->loadValues(); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData ApplicationUI::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject ApplicationUI::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_ApplicationUI,
      qt_meta_data_ApplicationUI, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &ApplicationUI::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *ApplicationUI::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *ApplicationUI::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_ApplicationUI))
        return static_cast<void*>(const_cast< ApplicationUI*>(this));
    return QObject::qt_metacast(_clname);
}

int ApplicationUI::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 9)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 9;
    }
    return _id;
}

// SIGNAL 0
void ApplicationUI::mySignal()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}
QT_END_MOC_NAMESPACE
