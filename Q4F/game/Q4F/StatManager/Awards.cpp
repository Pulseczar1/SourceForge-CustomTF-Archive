#include "../../../idlib/precompiled.h"
#pragma hdrstop

#include "../../Game_local.h"

AwardsParser::AwardsParser() {
}

const char* AwardsParser::GetAwardsString() {
	_awardsStr.Clear();

	idLexer lex;

	LoadAwardsFile( lex );

	lex.FreeSource();

	return _awardsStr.c_str();
}

void AwardsParser::LoadAwardsFile( idLexer &lex ) {
	lex.LoadFile( "awards.scriptcfg" );
}