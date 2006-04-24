/*
==============================================================================

Portal

==============================================================================
*/

$cd id1/models/portal
$scale	0.8
$origin 0 0 24
$base base
$skin base

$frame close1 close2 close3 close4 close5 close6 close7 close8 close9
//============================================================================

void() pclose =
{
        if (self.walkframe <= 0) self.count_count = 0;
        if (self.walkframe >= 9) self.count_count = 1;
        if (!self.count_count)
                self.walkframe = self.walkframe + 1;
        else self.walkframe = self.walkframe - 1;
        self.frame = $close1 + self.walkframe;
};
