
import  ballerina/io;
import  ballerina/http;
import  ballerina/log;

service / on new http:Listener(9090){
            
    resource function get readXml(string fileName) returns xml|error? {
        // performs a read operation to read the XML content.
        string filePath = string `${fileName}.xml`;
        xml|error? readFile = check io:fileReadXml(filePath);

        if (readFile is xml) {
            return readFile;
        } else {
            log:printError("Error reading XML file", 'error = readFile);
            error fileReadError = error("FileReadError", message = "Unable to read the specified XML file");
            return fileReadError;
        }
    }

    resource function get readJson(string fileName) returns json|error? {
        // performs a read operation to read the JSON content.
        string filePath = string `${fileName}.json`;
        json|error? readFile = check io:fileReadJson(filePath);

        if (readFile is json) {
            return readFile;
        } else {
            log:printError("Error reading JSON file", 'error = readFile);
            error fileReadError = error("FileReadError", message = "Unable to read the specified JSON file");
            return fileReadError;
        }
    }

    resource function get getQueryParam(string key, string fileName) returns json|error {

        http:Client httpClient = check new ("localhost:9090");
        json|error readFile = httpClient->get(string `/readJson?fileName=${fileName}`);

        if (readFile is json) {
            if (readFile is map<json>) {
                return readFile[key];
            }
            else {
                log:printInfo("File does not contain a map of json.");
            }

        } else {

            io:println("Error occurred in invokng the API: ", readFile);
        }

    }

        resource function get updateId2115Request3(string file) returns error?{
       
        string fileName =  string `resources/Dev05/LOR-2115/${file}`;
        json|error? jsonData = check io:fileReadJson(fileName);

        if(jsonData is json){
            string transactionId = (check jsonData.transactionId).toString();
            log:printInfo(transactionId);

            string newString = check shuffleSubstring(transactionId, 0, 8);
            log:printInfo(newString);

           if (jsonData is map<json>){
            jsonData["transactionId"] = newString;
           }

           check io:fileWriteJson(fileName, jsonData);
        }

    }

        resource function get updateId2115Request12(string file) returns error?{
    
        string fileName =  string `resources/Dev05/LOR-2115/${file}`;
        json|error? jsonData = check io:fileReadJson(fileName);

        if(jsonData is json){
            string emailAddress = (check jsonData.emailAddress).toString();
            string[] emails = re `INSURED`.split(emailAddress);

            string newEmail = emails[0]+"1INSURED"+emails[1];

           if (jsonData is map<json>){
            jsonData["emailAddress"] = newEmail;
           }

           check io:fileWriteJson(fileName, jsonData);
        }

    }
}



