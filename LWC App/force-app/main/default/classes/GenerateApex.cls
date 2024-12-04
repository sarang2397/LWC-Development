public with sharing class GenerateApex {
    
    @AuraEnabled
    public static String generateApexClass(String jsonString){
        JSONParser parser = JSON.createParser(jsonString);
        try {
            String finalApex='JSONGenerator gen = JSON.createGenerator(true); \n';
            Integer count=0;
            Boolean isArrayStarted=false;
            String currentValue='';

            while(parser.nextToken() !=null){

                System.debug(parser.getCurrentToken());
                //System.debug(parser.nextValue());
               
                if(parser.getCurrentToken()== JSONToken.START_OBJECT){
                    if(count==1){
                        finalApex=finalApex+');\ngen.writeStartObject(); \n';
                        
                    }
                    else{
                        finalApex=finalApex+'gen.writeStartObject(); \n';

                    }
                    
                }
                if(parser.getCurrentToken()== JSONToken.END_OBJECT){

                    if(count==1){
                        finalApex=finalApex+'\ngen.writeEndObject(); \n';
                        
                    }
                   
                    finalApex=finalApex+'gen.writeEndObject(); \n';
                   
                }
                if(parser.getCurrentToken()== JSONToken.START_ARRAY){
                    if(count==1){
                        finalApex=finalApex+'); \ngen.writeStartArray(); \n';
                        
                    }
                    else{
                        finalApex=finalApex+'gen.writeStartArray(); \n';
                    }
                    isArrayStarted=true;
                   
                }
                
                if(parser.getCurrentToken()== JSONToken.END_ARRAY){
                    finalApex=finalApex+'gen.writeEndArray(); \n';
                    isArrayStarted=false;
                    
                }

                if(parser.getCurrentToken()== JSONToken.FIELD_NAME  ){
                    count=1;
                    finalApex=finalApex+'gen.writeStringField('+''+parser.getText();
                    currentValue=parser.getText();
                }
                if(parser.getCurrentToken()== JSONToken.VALUE_STRING ){
                    count=0;
                    if(isArrayStarted){
                        finalApex=finalApex+'gen.writeStringField('+parser.getText()+'); \n';
                    }
                    else{
                        finalApex=finalApex+','+'\'' + parser.getText() + '\'); \n';
                    }
                    
                   
                }
                if(parser.getCurrentToken()== JSONToken.VALUE_NUMBER_INT ){
                    count=0;
                    String newStr=finalApex;
                    String s2 = newStr.substringAfterLast('\n');
                    finalApex=newStr.removeEndIgnoreCase(s2);
                    System.debug('last string: '+s2);
                    finalApex=finalApex+'gen.writeNumberField('+currentValue+','+ parser.getText()+'); \n';
                    //finalApex=finalApex+','+ parser.getText()+'); \n';
                    
                }
                if(parser.getCurrentToken()== JSONToken.VALUE_NUMBER_FLOAT ){
                    count=0;
                    String newStr=finalApex;
                    String s2 = newStr.substringAfterLast('\n');
                    finalApex=newStr.removeEndIgnoreCase(s2);
                    System.debug('last string: '+s2);
                    finalApex=finalApex+'gen.writeNumberField('+currentValue+','+ parser.getText()+'); \n';
                    //finalApex=finalApex+','+ parser.getText()+'); \n';
                   
                }


            }

            finalApex=finalApex+'String jsonData = gen.getAsString(); \n';

            return finalApex;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}