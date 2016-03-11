# This file is a part of AstroLib.jl. License is MIT "Expat".

using AstroLib
using Base.Test

# Test daycnv with Gregorian Calendar in force.
@test AstroLib.daycnv(2440000.0) == DateTime(1968, 05, 23, 12)

# Test daycnv with Julian Calendar in force (same result as IDL AstroLib's
# daycnv).
@test AstroLib.daycnv(2000000.0) == DateTime(763, 09, 18, 12)
@test AstroLib.daycnv(0.0) == DateTime(-4713, 11, 24, 12)

# Test get_date with mixed keywords.
@test AstroLib.get_date(DateTime(2001,09,25,14,56,14), old=true,timetag=true) == "25/09/2001:T14:56:14"

# Test juldate with Gregorian Calendar in force.  This also makes sure precision
# of the result is high enough.  Note that "juldate(dt::DateTime) =
# Dates.datetime2julian(dt)-2.4e6" would not be precise.
@test (rjd=57388.5 + 1.0/3.0;
       abs(AstroLib.juldate(DateTime(2016, 1, 1, 8)) - rjd) < eps(rjd))

# Test juldate with Julian Calendar in force, for different centuries.  This
# also makes sure precision of the result is high enough.
@test (rjd=-100843.0 + 1.0/3.0;
       abs(AstroLib.juldate(DateTime(1582, 10, 1, 20)) - rjd) < eps(rjd))
@test (rjd=-313692.0 + 1.0/3.0;
       abs(AstroLib.juldate(DateTime(1000, 1, 1, 20)) - rjd) < eps(rjd))
@test (rjd=-642119.0 + 1.0/3.0;
       abs(AstroLib.juldate(DateTime(100, 10, 25, 20)) - rjd) < eps(rjd))
@test (rjd=-2.4e6;
       abs(AstroLib.juldate(DateTime(-4713, 1, 1, 12)) - rjd) < eps(rjd))

# Test daycnv and juldate together, with Gregorian Calendar in force.  Note that
# they are not expected to be one the inverse of the other during Julian
# Calendar.
@test (dt=DateTime(2016, 1, 1, 20);
       AstroLib.daycnv(AstroLib.juldate(dt) + 2.4e6) == dt)
