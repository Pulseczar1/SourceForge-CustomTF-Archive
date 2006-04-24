/*
+----------------------------------------------------------------------------+
| FILE: KCKSTGE.QC                                                           |
| Quaker Server Modifications (QkrMods) v4.07                                |
| Copyright (C) 1998 David G. Hesprich (Dark Grue)                           |
|                                                                            |
| RMSTOOGE.QC is based partially on source by                                |
|   Ilkka Rajala <r151925@proffa.cc.tut.fi>                                  |
|                                                                            |
| This program is free software; you can redistribute it and/or modify it    |
| under the terms of the GNU General Public License as published by the Free |
| Software Foundation; either version 2 of the License, or (at your option)  |
| any later version.                                                         |
| This program is distributed in the hope that it will be useful, but        |
| WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY |
| or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   |
| for more details.                                                          |
|                                                                            |
| You should have received a copy of the GNU General Public License along    |
| with this program; if not, write to the Free Software Foundation, Inc.,    |
| 675 Mass Ave, Cambridge, MA 02139, USA.                                    |
+----------------------------------------------------------------------------+
*/

/*
====================
Function name    : float(float v) anglemod
Calls            : <none>
Globals modified : <none>
====================
*/
float(float v) anglemod = {
  while (v >= 360) v = v - 360;
  while (v < 0) v = v + 360;
  return(v);
};

/*
====================
Function name    : void() KickStoogeInfo
Calls            : sprint
Globals modified : <none>
Purpose: Prints information on the KickStooge module.
====================
*/
void() KickStoogeInfo = {
  sprint(self, "ç “Ì”ÙÔÔÁÂ: auto-neuters StoogeBot\n  players. Humans only please.\n");
};


/*
====================
Function name    : void() CheckBot
Calls            : vlen ceil vectoyaw anglemod Log_Notice sprint stuffcmd
Globals modified : self
Purpose: Detects (at least Stooge) Bots' unnatural movements, which means
running in some direction with constant speed while firing in all directions.
====================
*/
void() CheckBot = {
  local float tmpf1, tmpf2, tmpf3;

  if ( self.isBot )
     return;

  tmpf3 = vlen(self.velocity);
  tmpf3 = ceil(tmpf3);
  tmpf1 = vectoyaw(self.velocity);
  tmpf2 = self.v_angle_y;

  if (tmpf3 == self.lastspeed) {
    if (tmpf3 != 0) {
      if (self.flags & 512) {
        if (tmpf1 == self.lastyaw) {
          if (self.button0) {
            local float tmpf, tmpf4, tmpf5;

            tmpf4 = anglemod(tmpf1);
            tmpf5 = anglemod(tmpf2);
            tmpf = tmpf4 - tmpf5;    
            self.botcount1 = self.botcount1 + 1;
            if (tmpf2 != self.lastangle) {
              if ((tmpf < -4) || (tmpf > 4)) self.botcount2 = self.botcount2 + 1;
            }
          }
        }
      }
    }
  }

  if (self.botcount1 > 10) {
    if (self.botcount2 > 5) {
      // (Begin Modifications) added for LOG.QC
      // log event
      // if (USE_MODULE_LOG) Log_Notice("RMSTOOGE", self.netname, "kicked for Stooging.");
      // (End Modificaitons)

      // inform player
      sprint(self, "** “Õ”‘œœ«≈ (");
      sprint(self, self.netname);
      sprint(self, "):\n");
      sprint(self, "Bots are forbidden, you have been\nneutered by the system for\nbot-like behavior.\n");
      sprint(self, "If you are *not* a 'bot, please\naccept our apologies, this\nfeature is still experimental.\n");
      // stuffcmd(self, "disconnect\n");
      self.isBot = 1;
    }

    self.botcount1 = 0;
    self.botcount2 = 0;
  } 
  self.lastspeed = tmpf3;
  self.lastyaw = tmpf1;
  self.lastangle = tmpf2;
};
