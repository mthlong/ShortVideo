class NumberFormatter{
  static String formatter(String currentBalance) {
    // suffix = {' ', 'k', 'M', 'B', 'T', 'P', 'E'};
    double value = double.parse(currentBalance);
    if(value < 1000){ // less than a million
      return value.toStringAsFixed(0);
    }
    else if(value >=1000 && value < 1000000) {
      double result = value/(1000);
      return result.toStringAsFixed(1)+"k";
    }
    else if(value >= 1000000 && value < (1000000*10*100)){ // less than 100 million
      double result = value/1000000;
      return result.toStringAsFixed(1)+"M";
    }else if(value >= (1000000*10*100) && value < (1000000*10*100*100)){ // less than 100 billion
      double result = value/(1000000*10*100);
      return result.toStringAsFixed(1)+"B";
    }else if(value >= (1000000*10*100*100) && value < (1000000*10*100*100*100)){ // less than 100 trillion
      double result = value/(1000000*10*100*100);
      return result.toStringAsFixed(1)+"T";
    } else {
      return value.toString();
    }
  }
}
