/*
 *
 * $Workfile: SimpleDate.java $
 *
 * Last Modification:
 *  $Author: mgodoy $
 *  $JustDate: 25/10/02 $
 *
 * Developed by:
 *  everis
 *  Vitacura 2939 - Piso 7 - Las Condes
 *  Santiago - Chile
 *  Phone: 56-2-4215300, Fax: 56-2-4215311
 *  www.everis.com
 * $NoKeywords: $
 */


package com.tmmas.scl.wsseguridad.validacion;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

/**

Representa una fecha simple, con año, mes, dia, hora, minutos, segundos y milisegundos.
Puede ser convertido  a un java.util.Date o java.util.Calendar.
<br>IMPORTANTE: El primer mes del año es el 1, no como en el Calendar que
es el 0 (ver Calendar.JANUARY).

Sigue el patrón de diseño Inmutable: una vez creado un SimpleDate, no es modificable su valor.

@author Erick A. Jansson B. / erick.jansson@everis.com
@author Luis Longeri. / luis.longeri@everis.com
*/

public class SimpleDate implements java.io.Serializable, Cloneable, Comparable  {

    private static final String s_defaultPattern = "yyyy/MM/dd HH:mm:ss";

    private static final double MILLIS_IN_ONE_SECOND = 1000;
    private static final double MILLIS_IN_ONE_MINUTE = 60000;
    private static final double MILLIS_IN_ONE_HOUR = 3600000;
    private static final double MILLIS_IN_ONE_DAY = 86400000;

    private static final String[] DAY_OF_WEEKS = {"monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"};

//    public static void seDefaultPattern(String p_defaultPattern) {
//        if ( p_defaultPattern != null ) {
//            s_defaultPattern = p_defaultPattern;
//        }
//    }

    public static String getDefaultPattern() {
        return s_defaultPattern;
    }

    private int year = 1968;
    private int month = 12;
    private int day = 1;
    private int hour = 0;
    private int min = 0;
    private int sec = 0;
    private int millisec = 0;

    /**
    */
    public SimpleDate() {
    }

    public SimpleDate(int p_year, int p_month, int p_day) {
        this(p_year,p_month,p_day, 0, 0, 0, 0);
    }

    public SimpleDate(int p_year, int p_month, int p_day, int p_hour) {
        this(p_year,p_month,p_day,p_hour, 0, 0, 0);
    }

    public SimpleDate(int p_year, int p_month, int p_day, int p_hour, int p_min) {
        this(p_year,p_month,p_day,p_hour,p_min, 0, 0);
    }

    public SimpleDate(int p_year, int p_month, int p_day, int p_hour, int p_min, int p_sec) {
        this(p_year,p_month,p_day,p_hour,p_min, p_sec, 0);
    }

    /**
     * Inicializa este objeto con el año, mes, dia, hora, minutos, segundos, y milisegundos
     * especificados.
     *
     * @param p_year int
     * @param p_month int
     * @param p_day int
     * @param p_hour int
     * @param p_min int
     * @param p_sec int
     * @param p_millisec int
     */
    public SimpleDate(int p_year, int p_month, int p_day, int p_hour, int p_min, int p_sec, int p_millisec) {

        setYear(p_year);
        setMonth(p_month);
        setDay(p_day);
        setHour(p_hour);
        setMin(p_min);
        setSec(p_sec);
        setMillisec(p_millisec);
    }

    /**
    Parsea la fecha contenida en el String con el patron por defecto,
    la normaliza y carga el año, mes y dia en este objeto.
    @param p_date la fecha como String
    @throws ParseException si falla el parseo de la fecha.
    */
    public SimpleDate(String p_date) throws ParseException {
        load(p_date);
    }

    /**
    Parsea la fecha contenida en el String con el patron especificado,
    la normaliza y carga el año, mes y dia en este objeto.
    @param p_date la fecha como String
    @param p_pattern el patron para interpretar la fecha, igual a java.text.SimpleDateFormat.
    @throws ParseException si falla el parseo de la fecha.
    */
    public SimpleDate(String p_date, String p_pattern) throws ParseException {
        load(p_date, p_pattern);
    }

    /**
     * Inicializa este objeto con la fecha especificada
     *
     * @param p_date Date
     */
    public SimpleDate(Date p_date) {
        load(p_date);
    }

    /**
     * Inicializa este objeto con el calendario especificado.
     *
     * @param p_calendar Calendar
     */
    public SimpleDate(Calendar p_calendar) {
        load(p_calendar);
    }

    public int hashCode() {
        return year + month + day + hour + min + sec + millisec;
    }

    public boolean equals(Object p_other) {

        boolean areEqual = this == p_other;

        if ( !areEqual
            && getClass().isInstance(p_other)
                && p_other.getClass().isInstance(this) ) {

            SimpleDate o = (SimpleDate) p_other;

            areEqual = year == o.year && month == o.month
                && day == o.day && hour == o.hour
                && min == o.min && sec == o.sec
                && millisec == o.millisec;
        }

        return areEqual;
    }

    /**
     * Retorna una copia de este objeto.
     *
     * @return Object
     */
    public Object clone() {
        return new SimpleDate(year, month, day, hour, min, sec, millisec);
    }


    /**
     * Returns a String representation of this simple date.
     *
     * @return String
     */
    public String toString() {

        return toString(getDefaultPattern());
    }

    /**
     * Retorna un String con una fecha formateada de acuerdo al patron especificado. El patron sigue
     * la norma de java.text.SimpleDateFormat.
     *
     * @param p_pattern patron para formatear fecha.
     * @return String
     */
    public String toString(String p_pattern) {

        SimpleDateFormat sdf = new SimpleDateFormat(p_pattern, Locale.ENGLISH);

        return sdf.format(toDate());
    }

    // Attributes accessors:

    public int getMillisec() {
        return millisec;
    }

    protected void setMillisec(int p_millisec) {
        millisec = p_millisec;
    }
    public int getSec() {
        return sec;
    }

    protected void setSec(int p_sec) {
        sec = p_sec;
    }
    public int getMin() {
        return min;
    }

    protected void setMin(int p_min) {
        min = p_min;
    }
    public int getHour() {
        return hour;
    }

    protected void setHour(int p_hour) {
        hour = p_hour;

    }

    public int getDay() {
        return day;
    }

    protected void setDay(int p_day) {
        day = p_day;
    }

    public int getMonth() {
        return month;
    }

    protected void setMonth(int p_month) {
        month = p_month;
    }

    public int getYear() {
        return year;
    }

    protected void setYear(int p_year) {
        year = p_year;
    }

    public int getDayOfWeek() {
        return toCalendar().get(Calendar.DAY_OF_WEEK);
    }

    public SimpleDate normalize() {

        return new SimpleDate(toCalendar());
    }

    /**
     * Extrae el año, mes y dia desde el calendario especificado y carga este objeto. Si p_cal es
     * null, no hace nada.
     *
     * @param p_cal Calendar
     */
    private void load(Calendar p_cal) {

        if ( p_cal != null ) {
            setYear(p_cal.get(Calendar.YEAR));
            setMonth(p_cal.get(Calendar.MONTH) - Calendar.JANUARY + 1);
            setDay(p_cal.get(Calendar.DAY_OF_MONTH));
            setHour(p_cal.get(Calendar.HOUR_OF_DAY));
            setMin(p_cal.get(Calendar.MINUTE));
            setSec(p_cal.get(Calendar.SECOND));
            setMillisec(p_cal.get(Calendar.MILLISECOND));
        }
    }

    private void load(String p_date) throws ParseException {
        load(p_date, getDefaultPattern());
    }

    private void load(String p_date, String p_pattern) throws ParseException {

        SimpleDateFormat sdf = new SimpleDateFormat(p_pattern, Locale.ENGLISH);

        load((Date) sdf.parse(p_date));
    }

    /**
     * Utiliza un calendar por defecto para extraer la fecha especificada en el parametro de entrada
     * y cargarla en este objeto. Si la fecha es null, no hace nada.
     *
     * @param p_date Date
     */
    private void load(Date p_date) {

        if ( p_date != null ) {

            Calendar cal = Calendar.getInstance();

            cal.setTime(p_date);

            load(cal);
        }
    }

    // Convertion:

    /**
     * Retorna un Date que representa esta fecha. Utiliza el Calendar especificado.
     *
     * @param p_cal Calendar
     * @return Date
     */
    public Date toDate(Calendar p_cal) {

        if ( p_cal == null ) {
            p_cal = Calendar.getInstance();
        }

        p_cal.set(Calendar.YEAR, getYear());
        p_cal.set(Calendar.MONTH, (getMonth() - 1) + Calendar.JANUARY);
        p_cal.set(Calendar.DAY_OF_MONTH, getDay());
        p_cal.set(Calendar.HOUR_OF_DAY, getHour());
        p_cal.set(Calendar.MINUTE, getMin());
        p_cal.set(Calendar.SECOND, getSec());
        p_cal.set(Calendar.MILLISECOND, getMillisec());
//      p_cal.set(Calendar.AM_PM, getAmPm());

        return p_cal.getTime();
    }

    /**
     * Retorna un Date que representa esta fecha. Utiliza el Calendar por defecto.
     *
     * @return Date
     */
    public Date toDate() {
        return toDate(null);
    }

    /**
     * Retorna un Calendar (por defecto).
     *
     * @return Calendar
     */
    public Calendar toCalendar() {

        Calendar result = Calendar.getInstance();

        toDate(result);

        return result;
    }

    /**
     * Adds specified number of days.
     *
     * @param p_days double
     * @return SimpleDate
     */
    public SimpleDate addDays(double p_days) {

        int completeDays = (int) p_days;
        double datePart = (p_days - completeDays) * MILLIS_IN_ONE_DAY;

        Calendar c = Calendar.getInstance();
        Date currentDate = toDate(c);
        c.setTime(currentDate);
        c.add(Calendar.DATE, (int) p_days);
        c.add(Calendar.MILLISECOND, (int) datePart);

        return new SimpleDate(c);


    }

    /**
     * Adds specified number of hours.
     *
     * @param p_hours double
     * @return SimpleDate
     */
    public SimpleDate addHours(double p_hours) {

        return addMillis(p_hours * MILLIS_IN_ONE_HOUR);

    }

    /**
     * Adds specified number of minutes.
     *
     * @param p_minutes double
     * @return SimpleDate
     */
    public SimpleDate addMinutes(double p_minutes) {

        return addMillis(p_minutes * MILLIS_IN_ONE_MINUTE);
    }

    /**
     * Adds specified number of seconds.
     *
     * @param p_seconds double
     * @return SimpleDate
     */
    public SimpleDate addSeconds(double p_seconds) {

        return addMillis(p_seconds * MILLIS_IN_ONE_SECOND);
    }

    /**
     * Adds specified number of milliseconds.
     *
     * @param p_millis double
     * @return SimpleDate
     */
    public SimpleDate addMillis(double p_millis) {

        Calendar c = Calendar.getInstance();
        Date currentDate = toDate(c);
        c.setTime(currentDate);
        c.add(Calendar.MILLISECOND, (int) p_millis);

        return new SimpleDate(c);

    }

    /**
     * Compares this SimpleDate with other.
     *
     * @return -1, 0 or 1, corresponding to interface Comparable.
     * @param p_other Object
     */
    public int compareTo(Object p_other) {

        return toDate().compareTo(((SimpleDate) p_other).toDate());
    }

    /**
     *
     * @param p_date SimpleDate
     * @return true if passed SimpleDate is greater (later, newer), false otherwise.
     */
    public boolean lessThan(SimpleDate p_date) {
        if (compareTo(p_date) < 0) {
            return true;
        } else {
            return false;
        }
    }

    /**
     *
     * @param p_date SimpleDate
     * @return true if passed SimpleDate is equal or greater (later, newer), false otherwise.
     */
    public boolean lessOrEqualThan(SimpleDate p_date) {
        if (compareTo(p_date) <= 0) {
            return true;
        } else {
            return false;
        }
    }

    public SimpleDate add(int p_field, int p_amount) {

        Calendar c = Calendar.getInstance();

        c.setTime(toDate());

        c.add(p_field, p_amount);

        return new SimpleDate(c.getTime());
    }

    /**
     *
     * @param p_date SimpleDate
     * @return true if passed SimpleDate is smaller (earlier, former), false otherwise.
     */
    public boolean greaterThan(SimpleDate p_date) {
        if (compareTo(p_date) > 0) {
            return true;
        } else {
            return false;
        }
    }

    /**
     *
     * @param p_date SimpleDate
     * @return true if passed SimpleDate is equal or smaller (earlier, former), false otherwise.
     */
    public boolean greaterOrEqualThan(SimpleDate p_date) {
        if (compareTo(p_date) >= 0) {
            return true;
        } else {
            return false;
        }
    }

    ////////////////////////////////////////////////////////////////////////////
    //
    // Resource keys
    // =============


    public String getMonthResourceKey() {
        String result = null;

        result = SimpleDate.class.getName() + ".month." + getMonth();

        return result;
    }

    public String getDayOfWeekResourceKey() {
        String result = null;

        result = SimpleDate.class.getName() + ".dayOfWeek."
                + DAY_OF_WEEKS[getDayOfWeek() - Calendar.MONDAY];

        return result;
    }













    /*
    public static void main(String[] p_args) {

    try {

    SimpleDate d0 = new SimpleDate(2000, 2, 34);
    SimpleDate d1 = new SimpleDate("34/02/2001", "dd/MM/yyyy");

    d1.setYear(2000);











    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

    Object o = sdf.parse("01/12/1968");





    } catch ( Exception x ) {
    x.printStackTrace(System.out);
    }

    System.exit(0);

    }
    */


}

