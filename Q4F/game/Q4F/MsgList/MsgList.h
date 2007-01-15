#ifndef __MSGLIST_H__
#define	__MSGLIST_H__

/*
===============================================================================

	Message menues / lists

===============================================================================
*/

#define MAX_MESSAGE_LIST_ITEMS 10

class MessageItem {

public:

	void			Execute( void );

	const char*		GetLabel( void );
	const char*		GetName( void );

	idDict			Args;

	idStr			retStr;
};

class MessageList {
public:

					MessageList( void );

	MessageItem*	GetItem( int itemNum );
	MessageItem*	GetItem( const char* name );
	MessageItem*	AddItem( void );

	const char*		GetName( void );
	const char*		GetLabel( void );

	void			Clear( void );

	idDict			Args;
	int				Index;

private:

	MessageItem		_messages[MAX_MESSAGE_LIST_ITEMS];
	int				_numitems;
	
};


class MessageListCollection {

public:

							MessageListCollection( void );

	void					Load( void );
	MessageList*			GetList( const char* name );
	MessageList*			GetList( int num );

	void					Clear();

private:

	void					ParseMessageList( idLexer &lex );
	void					LexError( const char* error, idLexer* lex = NULL );

	idList<MessageList>		_lists;
	
};

#endif