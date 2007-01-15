// Copyright (C) 2004 Id Software, Inc.
//

#ifndef __NETWORKSYSTEM_H__
#define __NETWORKSYSTEM_H__


/*
===============================================================================

  Network System.

===============================================================================
*/

class idNetworkSystem {
public:
	virtual					~idNetworkSystem( void ) {}

	virtual void			ServerSendReliableMessage( int clientNum, const idBitMsg &msg );
	virtual void			ServerSendReliableMessageExcluding( int clientNum, const idBitMsg &msg );
	virtual int				ServerGetClientPing( int clientNum );
	virtual int				ServerGetClientPrediction( int clientNum );
	virtual int				ServerGetClientTimeSinceLastPacket( int clientNum );
	virtual int				ServerGetClientTimeSinceLastInput( int clientNum );
	virtual int				ServerGetClientOutgoingRate( int clientNum );
	virtual int				ServerGetClientIncomingRate( int clientNum );
	virtual float			ServerGetClientIncomingPacketLoss( int clientNum );
	virtual int				ServerGetClientNum( int clientId );
	virtual	int				ServerGetServerTime( void );

	virtual void			ClientSendReliableMessage( const idBitMsg &msg );
	virtual int				ClientGetPrediction( void );
	virtual int				ClientGetTimeSinceLastPacket( void );
	virtual int				ClientGetOutgoingRate( void );
	virtual int				ClientGetIncomingRate( void );
	virtual float			ClientGetIncomingPacketLoss( void );
// RAVEN BEGIN
// ddynerman: added some utility functions
	// uses a static buffer, copy it before calling in game again
	virtual const char*		GetServerAddress( void );
	virtual const char*		GetClientAddress( int clientNum );
	virtual	void			AddFriend( int clientNum );
	virtual void			RemoveFriend( int clientNum );
	// for MP games
	virtual void			SetLoadingText( const char* loadingText );
	virtual void			AddLoadingIcon( const char* icon );
	virtual const char*		GetClientGUID( int clientNum );
// RAVEN END

	virtual void			GetTrafficStats(  int &bytesSent, int &packetsSent, int &bytesReceived, int &packetsReceived ) const;
};

extern idNetworkSystem *	networkSystem;

#endif /* !__NETWORKSYSTEM_H__ */
