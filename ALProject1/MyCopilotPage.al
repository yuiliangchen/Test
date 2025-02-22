page 50101 "My Copilot Page"
{
    Caption = 'My Copilot Page';
    PageType = PromptDialog;
    Extensible = false;
    IsPreview = true;
    ApplicationArea = All;
    UsageCategory = Administration;
//    SourceTable = Customer; // Replace 'Customer' with an existing table name
//    SourceTableTemporary = true;
    DataCaptionExpression = UserInput;
 
    layout
    {
        area(Prompt)
        {
            field(UserInput; UserInput)
            {
                ShowCaption = false;
                MultiLine = true;
                InstructionalText = 'Please input the name of the customer';
            }        
        }
        area(Content)
        {
            field(Name; GeneratedText)
            {
//                ShowCaption = false;
//                MultiLine = true;
            }
            part(CustomerListPart; "Customer List Part")
            {
                ApplicationArea = All;
            }
        }
        area(PromptOptions)
        {
            field(Tone; Tone)
            {
                Caption = 'Tone';
                ApplicationArea = All;
                ToolTip = 'Specifies the Style of the generated text';
            }
            field(TextFormat; TextFormat)
            {
                Caption = 'Format';
                ApplicationArea = All;
                ToolTip = 'Specifies the length and Format of the generated text';
            }
            field(Emphasis; Emphasis)
            {
                Caption = 'Emphasis';
                ApplicationArea = All;
                ToolTip = 'Specifies the quality to Emphasis in the generated text';
            }

        }
    }

    actions
    {
        
        area(SystemActions)
        {
            systemaction(Generate)
            {
                Caption = 'Generate';
                trigger OnAction()
                var
                    MyCopilot: Codeunit "My Copilot Codeunit";
                begin
                    GeneratedText := UserInput;
//                    GeneratedText := MyCopilot.Generate(UserInput);
                end;
            }
            systemaction(Regenerate)
            {
                Caption = 'Regenerate';
                trigger OnAction()
                var
                    MyCopilot: Codeunit "My Copilot Codeunit";
                begin
                    GeneratedText := MyCopilot.Generate(UserInput);
                end;
            }
            systemaction(Attach)
            {
                Caption = 'Attach';
                trigger OnAction()
                var
                    InStr: InStream;
                    Filename: Text;
                begin
                    UploadIntoStream('Select a file', '', 'All file (*.*)|*.*', Filename, InStr);
                    if (Filename ='') then
                        Output := Filename;        
                end;
            }
//            systemaction(Ok)
//            {
//                Caption = 'Ok';
//            }
//            systemaction(Cancel)
//            {
//                Caption = 'Cancel';
//            }
        }
    }
    
    var
    UserInput: Text;
    GeneratedText: Text;
    Output: Text;
    Tone: Enum "Entity Text Tone";
    TextFormat: Enum "Entity Text Format";
    Emphasis: Enum "Entity Text Emphasis";

    trigger OnInit()
    begin
        CurrPage.PromptMode := PromptMode::Prompt;
    end;
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if (CloseAction = Action::Ok) then
            Message('User clicked Ok');
        if (CloseAction = Action::Cancel) then
            Message('User clicked Cancel');

    end;
}
page 50102 "Customer List Part"
{
    PageType = ListPart;
    SourceTable = Customer;
    layout
    {
        area(Content)
        {
            repeater(CustomerList)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}