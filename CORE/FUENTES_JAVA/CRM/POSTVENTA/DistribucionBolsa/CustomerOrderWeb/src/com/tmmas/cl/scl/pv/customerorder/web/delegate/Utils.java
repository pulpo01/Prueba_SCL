package com.tmmas.cl.scl.pv.customerorder.web.delegate;

import java.text.*;

public class Utils {

  private static NumberFormat cash = new DecimalFormat("$#,##0.00");

  public static String formatCurrency(int cents) {
    return cash.format((double)(cents/100));
  }
}