page 50100 SimpleCustomerList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Customer;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Number; "No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Name)
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
            action(Close)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    CurrPage.Close();
                end;
            }
        }
    }
    var
        enum1: Enum CustomEnum;
}