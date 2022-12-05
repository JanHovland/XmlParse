//
//  FormatDateToString.swift
//  XmlParse
//
//  Created by Jan Hovland on 05/12/2022.
//

import Foundation

/// https://nsdateformatter.com

/*
Friday, Oct 14, 2022                        EEEE, MMM d, yyyy
10/14/2022                                  MM/dd/yyyy
10-14-2022 15:51                            MM-dd-yyyy HH:mm
Oct 14, 3:51 PM                             MMM d, h:mm a
October 2022                                MMMM yyyy
Oct 14, 2022                                MMM d, yyyy
Fri, 14 Oct 2022 15:51:46 +0000             E, d MMM yyyy HH:mm:ss Z
2022-10-14T15:51:46+0000                    yyyy-MM-dd'T'HH:mm:ssZ
14.10.22                                    dd.MM.yy
15:51:46.916                                HH:mm:ss.SSS

Characters          Example                 Description
YEAR
y                   2008                    Year, no padding
yy                  08                      Year, two digits (padding with a zero if necessary)
yyyy                2008                    Year, minimum of four digits (padding with zeros if necessary)
QUARTER
Q                   4                       The quarter of the year. Use QQ if you want zero padding.
QQQ                 Q4                      Quarter including "Q"
QQQQ                4th quarter             Quarter spelled out
MONTH
M                   12                      The numeric month of the year. A single M will use '1' for January.
MM                  12                      The numeric month of the year. A double M will use '01' for January.
MMM                 Dec                     The shorthand name of the month
MMMM                December                Full name of the month
MMMMM               D                       Narrow name of the month
DAY
d                   14                      The day of the month. A single d will use 1 for January 1st.
dd                  14                      The day of the month. A double d will use 01 for January 1st.
F                   2 (numeric)             The day of week in the month.
E                   Tue                     The abbreviation for the day of the week
EEEE                Tuesday                 The wide name of the day of the week
EEEEE               T                       The narrow day of week
EEEEEE              Tu                      The short day of week
HOUR
h                   4                       The 12-hour hour.
hh                  04                      The 12-hour hour padding with a zero if there is only 1 digit
H                   16                      The 24-hour hour.
HH                  16                      The 24-hour hour padding with a zero if there is only 1 digit.
a                   PM                      AM / PM for 12-hour time formats
MINUTE
m                   35                      The minute, with no padding for zeroes.
mm                  35                      The minute with zero padding.
SECOND
s                   8                       The seconds, with no padding for zeroes.
ss                  08                      The seconds with zero padding.
SSS                 123                     The milliseconds.
TIME ZONE
zzz                 CST                     The 3 letter name of the time zone. Falls back to GMT-08:00 (hour offset) if the name is not known.
zzzz                Central Standard Time   The expanded time zone name, falls back to GMT-08:00 (hour offset) if name is not known.
ZZZZ                CST-06:00               Time zone with abbreviation and offset
Z                   -0600                   RFC 822 GMT format. Can also match a literal Z for Zulu (UTC) time.
ZZZZZ               -06:00                  ISO 8601 time zone format
*/

func FormatDateToString(date: Date, format: String) -> String {
    let formatter = DateFormatter()
    formatter.locale =  Locale.current
    formatter.dateFormat = format
    return (formatter.string(from: date))
}
