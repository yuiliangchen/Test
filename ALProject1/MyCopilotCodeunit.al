codeunit 50101 "My Copilot Codeunit"
{
    procedure Generate(UserInput: Text): Text
    begin

        AOAIChatCompletionParams.SetMaxTokens(2500);
        AOAIChatCompletionParams.SetTemperature(0);

        AOAIChatMessages.AddSystemMessage(SystemPrompt);
        AOAIChatMessages.AddUserMessage(UserInput);

        AzureOpenAI.GenerateChatCompletion(AOAIChatMessages, AOAIChatCompletionParams, AOAIOperationResponse);
        if (AOAIOperationResponse.IsSuccess()) then
            AOAIChatMessages.GetLastMessage();
            exit(AOAIChatMessages.GetLastMessage());
        exit('Error: ' + AOAIOperationResponse.GetError());
    end;
var
        AzureOpenAI: Codeunit "Azure OpenAI";
        AOAIChatCompletionParams: Codeunit "AOAI Chat Completion Params";
        AOAIChatMessages: Codeunit "AOAI Chat Messages";
        AOAIOperationResponse: Codeunit "AOAI Operation Response";
        SystemPrompt: Text; 
}