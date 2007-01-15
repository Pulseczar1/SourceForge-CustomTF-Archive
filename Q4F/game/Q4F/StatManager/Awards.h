#ifndef __TFSTATAWARDS_H__
#define __TFSTATAWARDS_H__

typedef struct awardLine_s {

	idStr			_txt;

} awardLine_t;

class AwardsParser {
public:
					AwardsParser( void );

	const char*		GetAwardsString( void );

private:

	void			LoadAwardsFile( idLexer &lex );

	idStr			_awardsStr;
};

#endif