# ccPositionManager
Position Manager App for OSX and IOS
[![Swift](https://github.com/creacominc/ccPositionManager/actions/workflows/swift.yml/badge.svg)](https://github.com/creacominc/ccPositionManager/actions/workflows/swift.yml)

NOTE:  This is a Work-In-Progress.  See the Progress section for the current status and what needs to be done.

Workflows:
- Buy Side:  which securities should be bought now based on rules;
- Sell Side:  which securities should have standing sell orders added or updated;
- Contracts:  which securities (which already have standing sell orders (or cannot have standing sell orders)) can be committed to covered calls;
- Accounts:  information specific to accounts
- Reports:  
    - income (annualized) per security including contract sales, realized gains, unrealized gains, dividends, and interest;
    - income grouped by various categories;
    - success rate of contract sales;
    - graph of gains and losses per security;
    - table of orders likely to be filled soon;
    - table of contracts about to get exercised or expire worthless;

Views:
- Main View:  split view with a navigation on the left and details on the right
- Navigation View:  A VStack of  Workflow Buttons, Needs Attention Only Toggle, List of Relevant Securities
- Detail View:  Details based on the workflow selected.
- Workflow View:  An HStack of buttons and a selector for accounts for the account workflow.  The buttons should be Red or Green if there are buy or sell alerts associated with the workflow.
- Needs Attention Only Toggle:  enable to limit the security list to items in the selected workflow that need attention.
- Securities List View:  A list of the securities for the select workflow.  This list may be limited by the Needs Attention Only Toggle.  The securities can be clicked on to get the relevant information in the detail view.


Progress:
    Done:
        - Experimented with the OATH connection.  A 'TestViews' folder contains views used to test aspects of the program.  The SecretsTestView and AuthroizeTestView (combined into TestUI) demonstrate the saving and load of Secrets and the process of Authorizing and acquiring an Access Token (and proving it with fetching the account numbers).  
        - Using the AuthorizeTestView demonstrates everything up to getting the account numbers.
    ToDo:
        - Aquire the account information;
        - Aquire a list of positions in available accounts;
