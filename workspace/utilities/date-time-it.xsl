<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--

Descrizione:

Script per la formattazione di data e ora in Italiano. Il template "format-date-it" prende 2 parametri:

1. date - [obbligatorio] la data in formato ISO (es. 2005-12-01)
2. format - [opzionale] la formattazione in forma di stringa (es. d/n/Y)

Opzioni di formattazione:

Y - anno a 4 cifre (es. 1981, 1992, 2008)
y - anno a 2 cifre (es. 81, 92, 08)
M - mese per intero (es. Gennaio, Marzo, Settembre)
m - mese in 3 lettere (es. Gen, Mar, Set)
N - mese in cifre senza lo zero iniziale (es. 3, 5, 10, 11, 12)
n - mese in cifre con lo zero iniziale (es. 03, 05, 10, 11, 12)
D - giorno in numero ordinale senza zero iniziale (es. 1°, 23°)
d - giorno in cifre con zero iniziale (es. 01, 09, 12, 25)
x - giorno in cifre senza zero iniziale (es. 1, 9, 12, 25)
T - ora in 24esimi (es. 18:30)
t - ora in 12esimi (es. 6:30pm)
W - giorno per interno (es. Lunedì, Martedì)
w - giorno in 3 lettere (es. Lun, Mar, Mer)

Esempi di formattazione:

M       => Gennaio
d M     => 21 Settembre
m D, Y  => Set 21°, 1981
n-d-y   => 09-21-81
d/n/y   => 21/09/81
d/n/y t => 21/09/81 6:30pm

-->

<xsl:template name="format-date-it">
	<xsl:param name="date"/>
	<xsl:param name="format" select="'D M, Y'"/>
	<xsl:choose>
		<xsl:when test="string-length($format) &lt;= 10">
			<xsl:call-template name="date-controller-it">
				<xsl:with-param name="date" select="$date"/>
				<xsl:with-param name="format" select="$format"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:text>La sintassi del parametro 'format' è errata: </xsl:text>
			<xsl:value-of select="string-length($format)"/>
			<xsl:text>.</xsl:text>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="date-controller-it">
	<xsl:param name="date"/>
	<xsl:param name="format"/>
	<xsl:param name="letter" select="substring($format,1,1)"/>
	<xsl:param name="tletter" select="translate($letter,'DMNYTW','dmnytw')"/>
	<xsl:choose>
		<xsl:when test="$tletter = 'y'">
			<xsl:call-template name="format-year-it">
				<xsl:with-param name="date" select="$date"/>
				<xsl:with-param name="format" select="$letter"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="$tletter = 'm'">
			<xsl:call-template name="format-month-it">
				<xsl:with-param name="date" select="$date"/>
				<xsl:with-param name="format" select="$letter"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="$tletter = 'n'">
			<xsl:call-template name="format-month-it">
				<xsl:with-param name="date" select="$date"/>
				<xsl:with-param name="format" select="$letter"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="$tletter = 'd'">
			<xsl:call-template name="format-day-it">
				<xsl:with-param name="date" select="$date"/>
				<xsl:with-param name="format" select="$letter"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="$tletter = 'x'">
			<xsl:call-template name="format-day-it">
				<xsl:with-param name="date" select="$date"/>
				<xsl:with-param name="format" select="$letter"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="$tletter = 't'">
			<xsl:call-template name="format-time-it">
				<xsl:with-param name="time" select="$date/@time"/>
				<xsl:with-param name="format" select="$letter"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="$tletter = 'w'">
			<xsl:call-template name="format-weekday-it">
				<xsl:with-param name="weekday" select="$date/@weekday"/>
				<xsl:with-param name="format" select="$letter"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$letter"/>
		</xsl:otherwise>
	</xsl:choose>
	<xsl:if test="$letter = not('')">
		<xsl:call-template name="date-controller-it">
			<xsl:with-param name="date" select="$date"/>
			<xsl:with-param name="format" select="substring($format,2)"/>
		</xsl:call-template>
	</xsl:if>
</xsl:template>

<xsl:template name="format-year-it">
	<xsl:param name="date"/>
	<xsl:param name="year" select="substring($date,1,4)"/>
	<xsl:param name="format" select="'y'"/>
	<xsl:choose>
		<xsl:when test="$format = 'y'">
			<xsl:value-of select="substring($year,3)"/>
		</xsl:when>
		<xsl:when test="$format = 'Y'">
			<xsl:value-of select="$year"/>
		</xsl:when>
	</xsl:choose>
</xsl:template>

<xsl:template name="format-month-it">
	<xsl:param name="date"/>
	<xsl:param name="month" select="format-number(substring($date,6,2), '##')"/>
	<xsl:param name="format" select="'m'"/>
	<xsl:param name="month-word">
		<xsl:choose>
			<xsl:when test="$month = 01">Gennaio</xsl:when>
			<xsl:when test="$month = 02">Febbraio</xsl:when>
			<xsl:when test="$month = 03">Marzo</xsl:when>
			<xsl:when test="$month = 04">Aprile</xsl:when>
			<xsl:when test="$month = 05">Maggio</xsl:when>
			<xsl:when test="$month = 06">Giugno</xsl:when>
			<xsl:when test="$month = 07">Luglio</xsl:when>
			<xsl:when test="$month = 08">Agosto</xsl:when>
			<xsl:when test="$month = 09">Settembre</xsl:when>
			<xsl:when test="$month = 10">Ottobre</xsl:when>
			<xsl:when test="$month = 11">Novembre</xsl:when>
			<xsl:when test="$month = 12">Dicembre</xsl:when>
		</xsl:choose>
	</xsl:param>
	<xsl:choose>
		<xsl:when test="$format = 'm'">
			<xsl:value-of select="substring($month-word, 1,3)"/>
		</xsl:when>
		<xsl:when test="$format = 'M'">
			<xsl:value-of select="$month-word"/>
		</xsl:when>
		<xsl:when test="$format = 'n'">
			<xsl:value-of select="format-number($month, '00')"/>
		</xsl:when>
		<xsl:when test="$format = 'N'">
			<xsl:value-of select="format-number($month, '0')"/>
		</xsl:when>
	</xsl:choose>
</xsl:template>

<xsl:template name="format-day-it">
	<xsl:param name="date"/>
	<xsl:param name="day" select="format-number(substring($date,9,2),'00')"/>
	<xsl:param name="format" select="'d'"/>
<!--	<xsl:param name="suffix">-->
<!--		<xsl:choose>-->
<!--			<xsl:when test="(substring($day,2) = 1) and not(substring($day,1,1) = 1)">st</xsl:when>-->
<!--			<xsl:when test="(substring($day,2) = 2) and not(substring($day,1,1) = 1)">nd</xsl:when>-->
<!--			<xsl:when test="(substring($day,2) = 3) and not(substring($day,1,1) = 1)">rd</xsl:when>-->
<!--			<xsl:otherwise>th</xsl:otherwise>-->
<!--		</xsl:choose>-->
<!--	</xsl:param>-->
	<xsl:param name="suffix">°</xsl:param>
	<xsl:choose>
		<xsl:when test="$format = 'd'">
			<xsl:value-of select="$day"/>
		</xsl:when>
		<xsl:when test="$format = 'x'">
			<xsl:value-of select="format-number($day,'0')"/>
		</xsl:when>
		<xsl:when test="$format = 'D'">
			<xsl:value-of select="format-number($day,'0')"/>
			<xsl:value-of select="$suffix"/>
		</xsl:when>
	</xsl:choose>
</xsl:template>

<xsl:template name="format-time-it">
	<xsl:param name="time"/>
	<xsl:param name="hour" select="substring-before($time, ':')"/>
	<xsl:param name="minute" select="substring-after($time, ':')"/>
	<xsl:param name="format" select="'T'"/>
	<xsl:choose>
		<xsl:when test="$format = 'T'">
			<xsl:value-of select="$time"/>
		</xsl:when>
		<xsl:when test="$format = 't'">
			<xsl:choose>
				<xsl:when test="$hour mod 12 = 0">12</xsl:when>
				<xsl:otherwise><xsl:value-of select="($hour mod 12)"/></xsl:otherwise>
			</xsl:choose>
			<xsl:value-of select="concat(':',$minute)"/>
			<xsl:choose>
				<xsl:when test="$hour &lt; 12">am</xsl:when>
				<xsl:otherwise>pm</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
	</xsl:choose>
</xsl:template>

<xsl:template name="format-weekday-it">
	<xsl:param name="weekday"/>
	<xsl:param name="format" select="'w'"/>
	<xsl:param name="result">
	<xsl:choose>
		<xsl:when test="$weekday = 1">Lunedì</xsl:when>
		<xsl:when test="$weekday = 2">Martedì</xsl:when>
		<xsl:when test="$weekday = 3">Mercoledì</xsl:when>
		<xsl:when test="$weekday = 4">Giovedì</xsl:when>
		<xsl:when test="$weekday = 5">Venerdì</xsl:when>
		<xsl:when test="$weekday = 6">Sabato</xsl:when>
		<xsl:when test="$weekday = 7">Domenica</xsl:when>
	</xsl:choose>
	</xsl:param>
	<xsl:choose>
		<xsl:when test="$format = 'W'">
			<xsl:value-of select="$result"/>
		</xsl:when>
		<xsl:when test="$format = 'w'">
			<xsl:value-of select="substring($result,1,3)"/>
		</xsl:when>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
