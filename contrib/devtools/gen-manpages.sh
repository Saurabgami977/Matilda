#!/usr/bin/env bash
# Copyright (c) 2016-2019 The Matilda Core developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

MATILDAD=${MATILDAD:-$BINDIR/matildad}
MATILDACLI=${MATILDACLI:-$BINDIR/matilda-cli}
MATILDATX=${MATILDATX:-$BINDIR/matilda-tx}
WALLET_TOOL=${WALLET_TOOL:-$BINDIR/matilda-wallet}
MATILDAQT=${MATILDAQT:-$BINDIR/qt/matilda-qt}

[ ! -x $MATILDAD ] && echo "$MATILDAD not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
read -r -a MTLVER <<< "$($MATILDACLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }')"

# Create a footer file with copyright content.
# This gets autodetected fine for matildad if --version-string is not set,
# but has different outcomes for matilda-qt and matilda-cli.
echo "[COPYRIGHT]" > footer.h2m
$MATILDAD --version | sed -n '1!p' >> footer.h2m

for cmd in $MATILDAD $MATILDACLI $MATILDATX $WALLET_TOOL $MATILDAQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${MTLVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${MTLVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
