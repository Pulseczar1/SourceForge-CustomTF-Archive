
#ifndef __SYS_CMDS_H__
#define __SYS_CMDS_H__

void	D_DrawDebugLines( void );

void	KillEntities( const idCmdArgs &args, const idTypeInfo &superClass );

typedef enum {
	CHAT_TARGET_ALL = 0,
	CHAT_TARGET_TEAM = 1,
	CHAT_TARGET_TARGET = 2
} chatTargetType_t;

#endif /* !__SYS_CMDS_H__ */
