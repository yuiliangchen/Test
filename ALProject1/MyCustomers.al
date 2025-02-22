pageextension 50101 "My Customers" extends "Customer List"
{
    layout
    {
        // Add changes to page layout here
    }
    
    actions
    {
        // Add changes to page actions here
        addafter(ApplyTemplate)
        {
            action(GenerateCopilot)
            {
                Caption = 'Generate Copilot';
                Image = Sparkle;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    Page.RunModal(Page::"My Copilot Page");
                end;
            }
        }
    }
    
    var
        myInt: Integer;
}