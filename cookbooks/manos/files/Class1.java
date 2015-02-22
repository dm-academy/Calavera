package biz.calavera;


public class Class1 {
          String strMsg;
          
          public Class1 (String inString)
          {
                    strMsg = inString;
          }
        public String five()
        { 
                return "five";
        }

          public String webMessage()
          {
              return "<h1>" + strMsg + "</h1>";
          }


        }
