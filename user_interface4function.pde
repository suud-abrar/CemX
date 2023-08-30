String place;
String typeofcement;
String branch;
String typeoffactory;
String amount;
String transactionnumber;
String price="";
int Tprice;
String date= month()+"/"+(day()+7)+"/"+year();
String transaction="s";
String  data[] ;
int indexphone;
String lastState;
int tolalamount;
String phone="4";
import static  javax.swing.JOptionPane.*;
import org.apache.commons.lang3.RandomStringUtils;
String path1="C:/Users/Win 10 Pro/Documents/Processing/factory.csv";
String path2="C:/Users/Win 10 Pro/Documents/Processing/factory2.csv";
String path3="C:/Users/Win 10 Pro/Documents/Processing/factorydata.csv";
String userpath="C:/Users/Win 10 Pro/Documents/Processing/Usersdata.csv";
Table table1;
Table table2;
Table table3;
Table table4;

String STATE_PLACE ="Place";
String STATE_TYPE_OF_CEMENT= "Type of cement";
String STATE_TYPE_OF_FACTORY = "Type of factory";
String STATE_AMOUNT ="Amount";
String STATE_TRANSACTION_NUMBER="Transaction Number";
String STATE_TRANSACTION_NUMBER2="Transaction Number2";
String STATE_BRANCH="branch";

void draw() {
  data = getHeaders (path3);
  String input = showInputDialog ("");
  table4=loadTable(userpath, "header");
  indexphone=table4.findRowIndex(phone, 0);
  table1=loadTable(path1, "header");
  table2=loadTable(path2, "header");
  table3=loadTable(path3, "header");
  lastState = indexphone == -1? "" : table4.getString(table4.getRowCount()-1, "State");
  if (indexphone==-1||lastState.equals(STATE_TRANSACTION_NUMBER)) {
    newuser(indexphone);
  } else if (lastState.equals(STATE_TRANSACTION_NUMBER2)) {
    place(input);
  } else if (lastState.equals(STATE_PLACE)) {
    typeofcementorbranch(input);
  } else if (lastState.equals(STATE_BRANCH)) {
    typeofcement(input);
  } else if (lastState.equals(STATE_TYPE_OF_CEMENT)) {
    typeoffactory(input);
  } else if (lastState.equals(STATE_TYPE_OF_FACTORY)) {
    amount(input);
  } else if (lastState.equals(STATE_AMOUNT)) {
    transaction(input);
  }
}
void newuser(int index) {
  table4.setString(table4.getRowCount(), 0, phone);
  indexphone=table4.getRowCount()-1;
  showMessageDialog(null, "Please select the place from where you want to take the cement\n1.Factory\n2.Suppliers");
  saveState (STATE_TRANSACTION_NUMBER2);
}
void place(String inputs) {
  String getrows[]=getrowheader(table1);
  indexphone=table4.getRowCount()-1;
  place=inputs;
  if (place.equals("1")) {
    table4.setString(indexphone, "Factoryp", "factory");
    saveTable(table4, userpath);
    saveState ( STATE_PLACE);
    showMessageDialog(null, "please select the type of cement\n1.PPC\n2.OPC");
  } else  if (place.equals("2")) {
    table4.setString(indexphone, "Factoryp", "supplier");
    saveTable(table4, userpath);
    saveState ( STATE_PLACE);
    showMessageDialog(null, getrows);
  }
}  

void typeofcementorbranch(String inputs) {
  indexphone=table4.getRowCount()-1;
  if (table4.getString(indexphone, "Factoryp").equals( "factory")) {
    typeofcement=inputs;
    if (lastState.equals(STATE_PLACE)) {
      if (typeofcement.equals("1")) {
        table4.setString(indexphone, "Type of cement", "ppc");
        saveTable(table4, userpath);
        saveState(STATE_TYPE_OF_CEMENT );
      } else if (typeofcement.equals("2")) {
        table4.setString(indexphone, "Type of cement", "opc");
        saveTable(table4, userpath);
        saveState(STATE_TYPE_OF_CEMENT );
      }
      showMessageDialog(frame, data);
    }
  } else if (table4.getString(indexphone, "Factoryp").equals( "supplier")) {
    branch=inputs;
    if (int(branch)>=1&&int(branch)<=table1.getRowCount()) {
      table4.setString(indexphone, "supplierp", table1.getString(int(branch)-1, "PPC"));
      saveTable(table4, userpath);
      saveState(STATE_BRANCH);
      showMessageDialog(null, "please select the type of cement\n1.PPC\n2.OPC");
    }
  }
}
void typeofcement(String inputs) {
  indexphone=table4.getRowCount()-1;
  typeofcement=inputs;
  if (typeofcement.equals("1")) {
    table4.setString(indexphone, "Type of cement", "ppc");
    saveTable(table4, userpath);
    saveState(STATE_TYPE_OF_CEMENT );
  } else if (typeofcement.equals("2")) {
    table4.setString(indexphone, "Type of cement", "opc");
    saveTable(table4, userpath);
    saveState(STATE_TYPE_OF_CEMENT );
  }
  showMessageDialog(null, data);
}
void typeoffactory(String inputs) {
  indexphone=table4.getRowCount()-1;
  typeoffactory =inputs;
  String contents[]=loadStrings(path3);
  String a=contents[0];
  String places[]=split(a, ",");
  if (int(typeoffactory)>=1&&int(typeoffactory)<places.length) {
    saveState( STATE_TYPE_OF_FACTORY);
    table4.setString(indexphone, "Type of factory", places[int(typeoffactory)]);
    saveTable(table4, userpath);
  }
  showMessageDialog(null, "Enter the amount of Cement you want (in quintal).\n You can only enter 100-1000 (quintal)");
}
void amount(String inputs) {
  indexphone=table4.getRowCount()-1;
  String preamount=table4.getString(indexphone, "Amount");
  amount=inputs;
  tolalamount=int(preamount)+int(amount);
  if (tolalamount<15000&&int(amount)<1000&&int(amount)>100) {
    saveState(STATE_AMOUNT);
    table4.setString(indexphone, "Amount", amount);  
    table4.setString(indexphone, "TotalAmount", str(tolalamount));  
    saveTable(table4, userpath);
    if (lastState.equals(STATE_AMOUNT)) {
      Tprice = prices(amount);    
      table4.setString(indexphone, "Total price", str(Tprice));
      saveTable(table4, userpath);
      String TP=table4.getString(indexphone, "Total price");
      String AMOUNT=table4.getString(indexphone, "Amount");
      showMessageDialog(frame, "Dear customer your total price is "+TP+" for "+AMOUNT+".\n Pay with tele-birr using 0947853943 and send the transaction number!");
    }    showMessageDialog(null, "Enter the right transaction Code you recieved from tele-birr");
  } else if (int(amount)>=1000||int(amount)<=100) {
    showMessageDialog(null, "you can not purchase this amount at this time\nplease enter the right amount");
  }
}
void transaction(String inputs) {
  indexphone=table4.getRowCount()-1;
  transactionnumber=inputs;
  if (transaction.equals(transactionnumber)) {
    table4.setString(indexphone, "Time", time());
    String code = RandomStringUtils.randomAlphanumeric (10).toUpperCase ();
    table4.setString(indexphone, "code", code);
    showMessageDialog(frame, "Dear customer you have succesfully paied "+Tprice+ " to our acount.\n"+"We will notify you when your requirement is ready!\n Thank you for Using Ethio-Digital-Cement system.");
    showMessageDialog(frame, "You can take the cement from its factory using "+code+" code on "+date+" Thank you for Using Ethio-Digital-Cement system.");
    saveState(STATE_TRANSACTION_NUMBER);
  }
}
void saveState (String states) {
  table4.setString(indexphone, "State", states);
  saveTable(table4, userpath);
  lastState=states;
}
String [] getHeaders (String paths) {
  String headers [] = new String [0];

  String contents[]=loadStrings(paths);
  String a=contents[0];
  String places[]=split(a, ",");
  for (int x=1; x<places.length; x++) {
    String head=str(x)+"."+places[x];
    headers=append(headers, head);
  }
  return headers;
}
String []getrowheader(Table table) {
  String rowheader[]=new String [0];
  for (int x=0; x<table.getRowCount(); x++) {
    String dat=str(x+1)+"."+table1.getString(x, "PPC");
    rowheader=append(rowheader, dat);
  }    
  return rowheader;
}
int prices(String amount) {
  int indexof_f= table3.getColumnIndex( table4.getString(indexphone, "Type of factory"));
  if (table4.getString(indexphone, "Factoryp").equals("factory")&& table4.getString(indexphone, "Type of cement").equals( "ppc")) {
    price=table3.getString(0, indexof_f);
    Tprice=int(price)*int(table4.getString(indexphone, "Amount"));
  } else if (table4.getString(indexphone, "Factoryp").equals("factory")&& table4.getString(indexphone, "Type of cement").equals( "opc")) {
    price=table3.getString(1, indexof_f);
    Tprice=int(price)*int(table4.getString(indexphone, "Amount"));
  } else if (table4.getString(indexphone, "Factoryp").equals("supplier")&&table4.getString(indexphone, "Type of cement").equals( "ppc")) {
    int indexof_b=table1.findRowIndex(table4.getString(indexphone, "supplierp"), 0);
    price=table1.getString(indexof_b, table4.getString(indexphone, "Type of factory"));
    Tprice=int(price)*int(table4.getString(indexphone, "Amount"));
  } else if (table4.getString(indexphone, "Factoryp").equals("supplier")&&table4.getString(indexphone, "Type of cement").equals( "opc")) {

    int indexof_b=table2.findRowIndex( table4.getString(indexphone, "supplierp"), 0);
    price=table2.getString(indexof_b, table4.getString(indexphone, "Type of factory"));
    Tprice=int(price)*int(table4.getString(indexphone, "Amount"));
  }
  return Tprice;
}
String  time() {
  String times=day()+"-"+month()+"-"+year()+","+hour()+":"+minute()+":"+second();
  return times;
}
