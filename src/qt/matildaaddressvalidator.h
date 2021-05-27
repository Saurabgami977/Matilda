// Copyright (c) 2011-2014 The Matilda Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef MATILDA_QT_MATILDAADDRESSVALIDATOR_H
#define MATILDA_QT_MATILDAADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class MatildaAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit MatildaAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const override;
};

/** Matilda address widget validator, checks for a valid matilda address.
 */
class MatildaAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit MatildaAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const override;
};

#endif // MATILDA_QT_MATILDAADDRESSVALIDATOR_H
