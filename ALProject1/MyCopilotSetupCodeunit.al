enumextension 50100 "My Copilot Capability" extends "Copilot Capability"
{
    value(50100; "Customer Task Creation") { }
}
codeunit 50100 "Secrets and Capabilities Setup"
{
    Subtype = Install;
    trigger OnInstallAppPerDatabase()
    begin
        RegisterCapability();
    end;
    local procedure RegisterCapability()
    var
        CopilotCapability: Codeunit "Copilot Capability";
        LearnMoreUrlText: Label 'Learn more';
        AzureOpenAI: Codeunit "Azure OpenAI";
        AOAIDeployments: Codeunit "AOAI Deployments";
        
    begin
        if not CopilotCapability.IsCapabilityRegistered(Enum::"Copilot Capability"::"Customer Task Creation") then
            CopilotCapability.RegisterCapability(Enum::"Copilot Capability"::"Customer Task Creation", LearnMoreUrlText);

        // If you are using managed resources, call this function:
        // NOTE: endpoint, deployment, and key are only used to verify that you have a valid Azure OpenAI subscription; we don't use them to generate the result
        AzureOpenAI.SetManagedResourceAuthorization(Enum::"AOAI Model Type"::"Chat Completions",
            GetEndpoint(), GetDeployment(), GetApiKey(), AOAIDeployments.GetGPT4oLatest());
        // If you are using your own Azure OpenAI subscription, call this function instead:
        // AzureOpenAI.SetAuthorization(Enum::"AOAI Model Type"::"Chat Completions", GetEndpoint(), GetDeployment(), GetApiKey());
        AzureOpenAI.SetCopilotCapability(Enum::"Copilot Capability"::"Customer Task Creation");
    end;

    local procedure GetApiKey(): SecretText
    begin
        // Use your Azure Open AI secret key.
        // NOTE: Do not add the key in plain text. Instead, use Isolated Storage or other more secure ways.
        exit(Format('CRUQ5pmaxeOAVDcsaRHnCw504ZVvh0NOCAMq7rP3OH81XQZGHAizJQQJ99ALACMsfrFXJ3w3AAABACOG1mNf'));
//        exit(Format(CreateGuid()));
    end;

    local procedure GetDeployment(): Text
    begin
        // Use your deployment name from Azure Open AI here
        exit('bc-copilot-001');
//        exit('gpt-' + CreateGuid());
    end;

    local procedure GetEndpoint(): Text
    begin
        // Use your endpoint name from Azure Open AI here
        exit('https://bc-copilot-001.openai.azure.com/');
//        exit('https://my-deployment.azure.com/');
    end;
}