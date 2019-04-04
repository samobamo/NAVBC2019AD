tableextension 50100 ExtraCustomerfields extends Customer
{
    fields
    {
        // Add changes to table fields here        
        field(50100; "warning level 1"; Option)
        {
            OptionMembers = "none","low","high";

        }
        field(50101; "warning level"; Enum CustomEnum)
        {
        }
    }
}
pageextension 50100 CustomerListExtension extends "Customer List"
{
    layout
    {
        // Add changes to page layout here        
        addlast(Control1)
        {
            field("warning level"; "warning level")
            {
                ApplicationArea = All;
                Caption = 'nivo opozarjanja 1';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}

pageextension 50101 CustomerCardExtension extends "Customer Card"
{
    layout
    {
        // Add changes to page layout here
        addlast(General)
        {
            field("warning level"; "warning level")
            {
                ApplicationArea = All;
                Caption = 'nivo opozarjanja 1';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}

codeunit 50100 CustomerSubscribers
{
    EventSubscriberInstance = StaticAutomatic;
    trigger OnRun()
    begin

    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', true, true)]
    local procedure UpdateCustomerWarningLevels(VAR SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean)
    var
        Customer: Record Customer;
    begin
        Customer.get(SalesHeader."Sell-to Customer No.");
        if Customer."warning level" = Customer."warning level"::low then begin
            Customer."warning level" := Customer."warning level"::high;
            Customer.Modify(false);
            Message('Warning level set to high!');
        end;

        if Customer."warning level" = Customer."warning level"::high then
            Error('high level warning set!');

    end;
}

table 50100 Tresholds
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Level; enum CustomEnum)
        {
            DataClassification = ToBeClassified;
        }
        field(2; treshold; decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "tip vozila"; Enum Vozila)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; Level)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}

page 50101 Treshold
{
    PageType = List;
    Editable = true;
    SourceTable = Tresholds;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Level; Level)
                {
                    ApplicationArea = All;

                }
                field(Treshold; Treshold)
                {
                    ApplicationArea = All;
                }
                field("tip vozila"; "tip vozila")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}


pageextension 50103 tresholdExtension extends "Sales & Receivables Setup"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addlast(Navigation)
        {
            /*group(ActionGroup1)
            {*/
            action(TresholdSetup)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Treshold setup',
                            SLV = 'Nastavitev nivojev';
                trigger OnAction()
                var
                    TresholdPage: Page Treshold;
                begin
                    TresholdPage.Editable(true);
                    TresholdPage.RunModal();
                end;
            }
            //}
        }
    }

    var
        myInt: Integer;
}

